#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 [-h] [-f <filename>] [-v] [-n <name>]"
    echo
    echo "Options:"
    echo "  -h              Display this help message."
    echo "  -f <filename>   Specify a filename to process."
    echo "  -v              Enable verbose mode."
    echo "  -n <name>       Provide a name."
    exit 1
}

# Default values for options
verbose=false
filename=""
name=""

# Process options using getopts
while getopts ":hf:vn:" opt; do
    case ${opt} in
        h ) # Display help
            usage
            ;;
        f ) # File option
            filename=$OPTARG
            ;;
        v ) # Verbose option
            verbose=true
            ;;
        n ) # Name option
            name=$OPTARG
            ;;
        \? ) # Invalid option
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        : ) # Missing argument
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Check if filename is provided
if [[ -n $filename ]]; then
    echo "Filename provided: $filename"
else
    echo "No filename provided."
fi

# Check if name is provided
if [[ -n $name ]]; then
    echo "Name provided: $name"
else
    echo "No name provided."
fi

# Check verbose flag
if $verbose; then
    echo "Verbose mode is enabled."
fi

# Generate the password template file
jinja2 /opt/mdps-gen/dotenv-passsword.j2 /opt/mdps-gen/destination/docker-compose.yml --format=yaml --outfile /opt/mdps-gen/destination/.env-password
#cat /opt/mdps-gen/destination/.env-password > /opt/mdps-gen/destination/.env-password

docker run --rm \
-v $PWD/.j2/:/templates \
-v $PWD/../docker-compose.yml:/variables/docker-compose.yml \
dinutac/jinja2docker:latest /templates/dotenv-passsword.j2 /variables/docker-compose.yml --format=yaml
