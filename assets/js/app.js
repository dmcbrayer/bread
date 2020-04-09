// We need to import the CSS so that webpack will load it.
import css from "../css/app.css"

// Import dependencies
//
import "phoenix_html"
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"
import "@fortawesome/fontawesome-free/js/all";

// Import local files
//
// import socket from "./socket"

// LiveView set up
//
let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  logger: (kind, msg, data) => { console.log(`${kind}: ${msg}:`, data)}
});
liveSocket.connect();

// Normal Socket set up
//
let socket = new Socket("/socket", {
  params: {token: window.userToken},
  logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data)}
})

if(window.userToken !== "") {
  socket.connect()

  let channel = socket.channel("analytics:users", {
    path: window.location.pathname,
    sessionId: window.sessionId
  })
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on("test", data => console.log(data))
}

// Navbar toggling
const triggers = Array.from(document.querySelectorAll('[data-toggle="collapse"]'));
triggers.forEach(trigger => {
  const selector = trigger.getAttribute('data-target');
  const targetElement = document.getElementById(selector);
  trigger.addEventListener('click', event => {
    targetElement.classList.toggle('show')
  })
})
