

## Shared Web UI  

Browser-based visualization of shared concepts inspired by *Johnny Mnemonic*'s [Global Mind Network](https://github.com/kozmic-labs/future-concept-stream/blob/main/topic/Global-Mind-Network.md)

 [**conceptual prototype only**] that simulates:

- Concept streams in 3D space
- Collaborative environment
- Emoji-tagged content

---

### Prototype Concept

- 🔁 Real-time collaborative mind streaming using WebSocket + GraphQL
- 🌀 Interactive 3D visualization of concepts via Three.js
- 🤖 AI emotion detector from text input
- 👥 Shared “mental rooms” for collaboration and idea exchange
- 🧭 Emoji mood map overlay (simulated)
- 🛡️ Consent-based sharing system

---

### 💻 Tech Stack

| Layer       | Tools Used                     |
|-------------|--------------------------------|
| Frontend    | React, Three.js, WebGL         |
| Backend     | Node.js, Express, GraphQL      |
| Worker      | TensorFlow.js / HuggingFace    |
| Collab      | Socket.IO, WebSockets          |
|             |                                |

---

### ⚙️ Setup Instructions

1. Clone the repo:
   ```bash
   git clone https://github.com/kozmic-labs/web-ui
   cd web-ui
   ```

2. Install and run frontend:
   ```
   cd frontend && npm install
   npm start
   ```

3. Install and run backend:
   ```
   cd ../backend-nodejs && npm install
   node server.js
   ```
   
---

