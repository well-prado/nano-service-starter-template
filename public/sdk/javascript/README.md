
# NanoSDK – Vanilla JavaScript SDK for Atomic Computing (CDN)

**NanoSDK** is the official lightweight client to execute remote nanoservice nodes on the [Atomic Computing](https://deskree.com) platform.  
This SDK is designed specifically for **browser environments** and distributed via **CDN** for easy integration without build tools or dependencies.

---

## 🌐 Getting Started

### 📥 Include via CDN

```html
<script src="https://cdn.yourdomain.com/nanosdk.min.js"></script>
```

This will make `NanoSDK` available globally in the browser:

```js
const client = new NanoSDK().createHttpClient("https://your-atomic-app.com", "your-access-token");
```

---

## 🚀 Example Usage

### Execute a Python Nanoservice

```html
<script>
  const client = new NanoSDK().createHttpClient("https://your-atomic-app.com", "your-access-token");

  async function run() {
    const response = await client.python3("my-python-node", {
      prompt: "What is the capital of France?"
    });

    if (response.success) {
      console.log("✅ Result:", response.data);
    } else {
      console.error("❌ Error:", response.errors);
    }
  }

  run();
</script>
```

---

### Execute a Node.js Nanoservice (as module)

```js
await client.nodejs("@nanoservice-ts/api-call", {
  url: "https://catfact.ninja/fact",
  method: "GET",
  responseType: "application/json"
});
```

### 📌 Understanding the Parameters

Each SDK method (e.g. `python3`, `nodejs`) expects **two parameters**:

```js
client.python3(nodeName, inputs)
client.nodejs(nodeName, inputs)
```

| Parameter     | Type      | Description                                                                 |
|---------------|-----------|-----------------------------------------------------------------------------|
| `nodeName`    | `string`  | The name of the node to execute. This name must match a registered nanoservice. |
| `inputs`      | `object`  | A plain object representing the inputs the nanoservice expects at runtime.     |

---

## 🧠 Features

- Zero setup — works in any browser with `<script>` tag
- Executes nanoservices remotely using **HTTP 1.1**
- Supports runtime types like `python3`, `nodejs`
- Includes simple **debug logging** mode
- Unified response structure with `success`, `data`, `errors`

---

## 🔄 Response Format

Each call returns a consistent response object:

```js
{
  success: true | false,
  data: { ... },         // Parsed JSON response
  rawData: "...",        // Fallback if not JSON
  errors: [ ... ],       // Array of error messages (if any)
  contentType: "...",    // Server response content type
  status: "..."          // Server response status code
}
```

---

## ⚙️ Custom Headers

You may override default headers:
```js
client.setHeaders({
  "x-correlation-id": "abc-123"
});
```

---

## 🧪 Debug Mode

Enable debug logging:
```js
const client = new NanoSDK().createHttpClient("https://your-host", "your-token", true);
```

Console will log:
- Request headers
- Workflow JSON
- Encoded message
- Final fetch URL

---

## 🔐 Requirements

- A valid **Atomic Application URL**
- A valid **Access Token** (generated via the Deskree platform)
- Public nanoservice endpoints accessible via Atomic workflows

---

## ❗ Important Notes

- This SDK does **not support TypeScript**, npm, or Node.js environments.
- It is limited to browser-based use and exposes only HTTP-level functionality.

---

## 🛡 Licensing & Security

This version of NanoSDK is distributed under an open-source license but is limited in scope to avoid exposing internal infrastructure features. For enterprise-grade use, please contact Deskree.

---

## 🧑‍💻 Maintained by [Deskree Inc.](https://deskree.com)
