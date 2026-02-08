const http = require("http");
const fs = require("fs");
const path = require("path");
const WebSocket = require("ws");

const server = http.createServer((req, res) => {
  const filePath = path.join(
    __dirname,
    "../public",
    req.url === "/" ? "index.html" : req.url
  );

  const ext = path.extname(filePath);
  let contentType = "text/html";

  if (ext === ".css") contentType = "text/css";
  else if (ext === ".js") contentType = "text/javascript";

  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end("Not found");
      return;
    }

    res.writeHead(200, { "Content-Type": contentType });
    res.end(data);
  });
});

const wss = new WebSocket.Server({ server });

let clients = [];

function broadcast(data) {
  const msg = JSON.stringify(data);
  clients.forEach(c => c.ws.send(msg));
}

function broadcastUsers() {
  const users = clients.map(c => ({ id: c.id, name: c.name }));
  broadcast({ type: "users", users });
}

wss.on("connection", ws => {
  const clientId = Date.now() + "" + Math.floor(Math.random() * 1000);
  let clientName = "";

  clients.push({ id: clientId, ws, name: clientName });
  ws.send(JSON.stringify({ type: "init", id: clientId }));

  ws.on("message", message => {
    const data = JSON.parse(message);

    if (data.type === "join") {
      clientName = data.name;
      clients = clients.map(c =>
        c.id === clientId ? { ...c, name: clientName } : c
      );
      broadcastUsers();
    }

    if (data.type === "message") {
      const recipient = clients.find(c => c.id === data.to);
      if (recipient) {
        recipient.ws.send(
          JSON.stringify({
            type: "message",
            from: clientId,
            fromName: clientName,
            text: data.text
          })
        );
      }
    }
  });

  ws.on("close", () => {
    clients = clients.filter(c => c.id !== clientId);
    broadcastUsers();
  });
});

server.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});