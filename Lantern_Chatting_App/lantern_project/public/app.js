let ws;
let myId = null;
let myName = "";
let selectedUserId = null;
let messageHistory = {};

const loginScreen = document.getElementById("loginScreen");
const loginBtn = document.getElementById("loginBtn");
const nameInput = document.getElementById("nameInput");
const chatApp = document.getElementById("chatApp");
const userList = document.getElementById("userList");
const messagesDiv = document.getElementById("messages");
const chatTargetName = document.getElementById("chatTargetName");
const msgInput = document.getElementById("msgInput");
const sendBtn = document.getElementById("sendBtn");
const sidebar = document.getElementById("sidebar");
const menuToggle = document.getElementById("menuToggle");
const closeMenu = document.getElementById("closeMenu");

menuToggle.onclick = () => sidebar.classList.add("open");
closeMenu.onclick = () => sidebar.classList.remove("open");

function joinChat() {
  const name = nameInput.value.trim();
  if (!name) return;

  myName = name;
  loginScreen.style.display = "none";
  chatApp.hidden = false;

  ws = new WebSocket(`ws://${location.host}`);
  ws.onopen = () =>
    ws.send(JSON.stringify({ type: "join", name: myName }));

  ws.onmessage = e => {
    const data = JSON.parse(e.data);
    if (data.type === "init") myId = data.id;
    if (data.type === "users") updateUserList(data.users);
    if (data.type === "message") handleIncomingMessage(data);
  };
}

function updateUserList(users) {
  userList.innerHTML = "";

  users.forEach(u => {
    if (u.id === myId) return;

    const li = document.createElement("li");
    li.textContent = u.name;

    if (u.id === selectedUserId) {
      li.classList.add("active");
    }

    li.onclick = () => {
      selectedUserId = u.id;
      chatTargetName.textContent = u.name;
      sidebar.classList.remove("open");
      renderMessages();
      updateUserList(users);
    };

    userList.appendChild(li);
  });
}

function handleIncomingMessage(data) {
  if (!messageHistory[data.from]) {
    messageHistory[data.from] = [];
  }

  const msgObj = {
    text: data.text,
    cls: "received",
    fromName: data.fromName
  };

  messageHistory[data.from].push(msgObj);

  if (data.from === selectedUserId) {
    addMessageToUI(msgObj);
  }
}

function sendMessage() {
  const text = msgInput.value.trim();
  if (text === "" || !selectedUserId) return;

  const msgObj = {
    text,
    cls: "sent",
    fromName: "Me"
  };

  if (!messageHistory[selectedUserId]) {
    messageHistory[selectedUserId] = [];
  }

  messageHistory[selectedUserId].push(msgObj);

  ws.send(
    JSON.stringify({
      type: "message",
      to: selectedUserId,
      text
    })
  );

  addMessageToUI(msgObj);
  msgInput.value = "";
}

function renderMessages() {
  messagesDiv.innerHTML = "";
  const history = messageHistory[selectedUserId] || [];
  history.forEach(msg => addMessageToUI(msg));
}

function addMessageToUI(msg) {
  const div = document.createElement("div");
  div.className = `message ${msg.cls}`;

  const nameColor =
    msg.cls === "sent"
      ? "rgba(255,255,255,0.8)"
      : "var(--primary-blue)";

  const nameLabel = `
    <small style="
      display:block;
      font-size:10px;
      font-weight:700;
      color:${nameColor};
      margin-bottom:2px;
    ">
      ${msg.fromName}
    </small>
  `;

  div.innerHTML = `${nameLabel}<div>${msg.text}</div>`;
  messagesDiv.appendChild(div);
  messagesDiv.scrollTop = messagesDiv.scrollHeight;
}

loginBtn.onclick = joinChat;
nameInput.onkeydown = e => { if (e.key === "Enter") joinChat(); };
sendBtn.onclick = sendMessage;
msgInput.onkeydown = e => { if (e.key === "Enter") sendMessage(); };