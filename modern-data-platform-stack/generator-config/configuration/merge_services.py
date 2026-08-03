#!/usr/bin/env python3
"""
Merge all individual service YAML files from configuration/services/ into
the single services.yml file.

Usage:
    python3 merge_services.py               # merge all files
    python3 merge_services.py --dry-run     # preview without writing
    python3 merge_services.py --verbose     # show each service processed

Run this script whenever a file in configuration/services/ changes.
Paths are resolved relative to the directory this script lives in.
"""

import argparse
import os
import re
import sys
import yaml


# ---------- Paths (resolved relative to this script) ----------

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SERVICES_DIR = os.path.join(SCRIPT_DIR, "services")
INDEX_YML = os.path.join(SCRIPT_DIR, "index.yml")
OUTPUT_YML = os.path.join(SCRIPT_DIR, "services.yml")


# ---------- YAML helpers ----------

def load_yaml(path):
    with open(path, encoding="utf-8") as f:
        return yaml.safe_load(f.read())


def write_description(text, indent):
    """Emit a YAML block scalar (>) for a description string."""
    lines = []
    lines.append(f"{indent}description: >")
    words = str(text).split()
    line = f"{indent}  "
    for word in words:
        if len(line) + len(word) + 1 > 80:
            lines.append(line.rstrip())
            line = f"{indent}  {word} "
        else:
            line += word + " "
    if line.strip():
        lines.append(line.rstrip())
    return lines


def format_default(value):
    """Return a safely-quoted YAML representation of a default value."""
    s = str(value)
    if "\\" in s:
        # Single-quoted YAML: no escape processing, but must escape single quotes
        return "'" + s.replace("'", "''") + "'"
    return '"' + s + '"'


def yaml_name(text):
    """Quote a name string if it contains YAML-special characters."""
    special = set('`:#&*?|<>=!%@\\')
    if any(c in str(text) for c in special):
        return '"' + str(text).replace('"', '\\"') + '"'
    return str(text)


# ---------- Service serialiser ----------

def write_service(svc):
    """Serialise one service entry to a list of text lines."""
    lines = []

    lines.append(f"  - name: {yaml_name(svc.get('name', ''))}")
    lines.append(f"    id: {svc.get('id', '')}")

    # category block
    category = svc.get("category", {})
    if isinstance(category, dict) and category:
        lines.append("    category:")
        lines.append(f"      id: {category.get('id', '99_other')}")
        lines.append(f"      name: {category.get('name', 'other')}")
        lines.append(f"      color: {category.get('color', 'gray')}")

    # arch
    arch = svc.get("arch", ["x86-64"])
    lines.append(f"    arch: [{', '.join(arch)}]")

    # tags / dependencies
    tags = svc.get("tags") or []
    lines.append(f"    tags: [{', '.join(str(t) for t in tags)}]")
    deps = svc.get("dependencies") or []
    lines.append(f"    dependencies: [{', '.join(str(d) for d in deps)}]")

    # links
    links = svc.get("links") or {}
    if links:
        lines.append("    links:")
        for key in ("website", "documentation", "github"):
            if key in links:
                lines.append(f"      {key}: {links[key]}")

    # description
    if svc.get("description"):
        lines.extend(write_description(svc["description"], "    "))

    # enable
    enable = svc.get("enable") or {}
    if enable:
        lines.append("    enable:")
        lines.append(f"      platys_init: {enable.get('platys_init', '')}")
        example = enable.get("example", "")
        if example:
            lines.append("      example: |")
            for el in str(example).rstrip("\n").split("\n"):
                lines.append(f"        {el}")

    # usage
    for u in svc.get("usage") or []:
        if not lines[-1].endswith("usage:"):
            # First usage item — emit the key
            lines.append("    usage:")
        title = str(u.get("title", "")).replace("'", "''")
        lines.append(f"      - title: {title}")
        content = u.get("content", "")
        if content:
            lines.append("        content: |")
            for cl in str(content).rstrip("\n").split("\n"):
                lines.append(f"          {cl}")

    # parameters
    params = svc.get("parameters") or []
    if params:
        lines.append("    parameters:")
        for p in params:
            lines.append(f"      - name: {p.get('name', '')}")
            lines.append(f"        default: {format_default(p.get('default', ''))}")
            lines.append(f'        since: "{p.get("since", "")}"')

            if p.get("sensitive"):
                lines.append("        sensitive: true")

            allowed = p.get("allowed_values")
            if allowed:
                lines.append(f"        allowed_values: [{', '.join(str(v) for v in allowed)}]")

            applicable = p.get("applicable_when")
            if applicable:
                lines.append(f'        applicable_when: "{applicable}"')

            if p.get("description"):
                lines.extend(write_description(
                    str(p["description"]).replace('"', "'"),
                    "        "
                ))

            lines.append("")

    return lines


# ---------- Main logic ----------

def build_services_yml(verbose=False):
    """
    Read index.yml and all individual service yml files, return the merged
    content as a string.
    """
    # Load ordered service list from index.yml
    index = load_yaml(INDEX_YML)
    ordered_sections = []
    for config_block in index.get("configuration", []):
        for section in config_block.get("sections", []):
            ordered_sections.append((
                section.get("name", ""),
                section.get("services", []),
            ))

    # Load every individual service yml file
    service_data = {}
    missing_files = []
    for fname in os.listdir(SERVICES_DIR):
        if not fname.endswith(".yml"):
            continue
        svc_id = fname[:-4]
        try:
            data = load_yaml(os.path.join(SERVICES_DIR, fname))
            if data:
                service_data[svc_id] = data
        except yaml.YAMLError as exc:
            print(f"  WARNING: could not parse {fname}: {exc}", file=sys.stderr)

    if verbose:
        print(f"Loaded {len(service_data)} individual service files")

    # Build output
    output_lines = ["services:"]
    written = set()

    # Sections defined in index.yml
    all_indexed_ids = {sid for _, sids in ordered_sections for sid in sids}

    for section_name, section_ids in ordered_sections:
        section_header_added = False
        for svc_id in section_ids:
            if svc_id in written:
                continue  # de-duplicate services listed in multiple sections
            if svc_id not in service_data:
                missing_files.append(svc_id)
                if verbose:
                    print(f"  WARNING: no yml file found for '{svc_id}'")
                continue
            if not section_header_added:
                output_lines.extend(["", f"  # ---- {section_name} ----", ""])
                section_header_added = True
            output_lines.extend(write_service(service_data[svc_id]))
            written.add(svc_id)
            if verbose:
                print(f"  [{section_name}] {svc_id}")

    # Services with yml files that are not listed in index.yml
    extra = sorted(sid for sid in service_data if sid not in all_indexed_ids)
    if extra:
        output_lines.extend(["", "  # ---- Other ----", ""])
        for svc_id in extra:
            output_lines.extend(write_service(service_data[svc_id]))
            written.add(svc_id)
            if verbose:
                print(f"  [Other] {svc_id}")

    # Collapse more-than-two consecutive blank lines
    text = "\n".join(output_lines)
    text = re.sub(r"\n{4,}", "\n\n\n", text)
    return text + "\n", written, missing_files


def main():
    parser = argparse.ArgumentParser(
        description="Merge configuration/services/*.yml into services.yml"
    )
    parser.add_argument("--dry-run", action="store_true",
                        help="Print what would be written without touching the file")
    parser.add_argument("--verbose", "-v", action="store_true",
                        help="Print each service as it is processed")
    args = parser.parse_args()

    print(f"Reading service files from: {SERVICES_DIR}")
    print(f"Reading section order from: {INDEX_YML}")

    content, written, missing = build_services_yml(verbose=args.verbose)

    line_count = content.count("\n")
    print(f"Merged {len(written)} services ({line_count} lines)")

    if missing:
        print(f"WARNING: {len(missing)} service(s) in index.yml have no yml file: "
              f"{', '.join(missing[:10])}{'...' if len(missing) > 10 else ''}")

    if args.dry_run:
        print(f"[dry-run] Would write {len(content)} bytes to {OUTPUT_YML}")
        return

    with open(OUTPUT_YML, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"Written → {OUTPUT_YML}")


if __name__ == "__main__":
    main()
