# Browserless

Browserless is a headless browser service that runs Chromium in a Docker container, exposing it over HTTP. It provides REST APIs and WebSocket endpoints compatible with Puppeteer, Playwright, and Selenium, making it ideal for web scraping, PDF generation, screenshot capture, and automated browser testing.

**[Website](https://www.browserless.io/)** | **[Documentation](https://docs.browserless.io/)** | **[GitHub](https://github.com/browserless/browserless)**

## How to enable?

```
platys init --enable-services BROWSERLESS
platys gen
```

Or in `config.yml`:

```yaml
      BROWSERLESS_enable: true
```

To restrict access with a token:

```yaml
      BROWSERLESS_enable: true
      BROWSERLESS_token: 'my-secret-token'
```

## How to use it?

Navigate to <http://dataplatform:28423> for the built-in UI (API playground and debugger).

### REST API examples

**Take a screenshot:**
```bash
curl -X POST http://dataplatform:28423/screenshot \
  -H 'Content-Type: application/json' \
  -d '{"url": "https://example.com"}' \
  --output screenshot.png
```

**Generate a PDF:**
```bash
curl -X POST http://dataplatform:28423/pdf \
  -H 'Content-Type: application/json' \
  -d '{"url": "https://example.com"}' \
  --output page.pdf
```

**Puppeteer / Playwright connection:**
```javascript
const browser = await puppeteer.connect({
  browserWSEndpoint: 'ws://dataplatform:28423'
});
```

When a token is set, append it as a query parameter:
```
ws://dataplatform:28423?token=my-secret-token
```
