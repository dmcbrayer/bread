import {Socket} from "phoenix"

let socket = new Socket("/socket", {
  params: {token: window.userToken},
  logger: (kind, msg, data) => { console.log(`${kind}: ${msg}`, data)}
})

if(window.userToken !== "") {
  socket.connect()

  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel("room:1", {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on("test", data => console.log(data))
}

export default socket
