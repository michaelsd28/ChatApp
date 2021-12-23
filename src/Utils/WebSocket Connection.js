let stompClient = null;

export function connectWS(sendCallback, receiveCallback) {
  const socket = new WebSocket("ws://localhost:8080/send");

  socket.onopen = () => {
    console.log("WebSocket Client Connected");
    alert("connected");
  };

  socket.onmessage = (evt) => {

    setMessages((messages) => [...messages, evt.data]);
    receiveCallback(evt.data);
  };

  socket.onclose = () => {
    console.log("WebSocket Client Disconnected");
    alert("disconnected");
  };

  socket.onerror = (error) => {
    console.log("WebSocket Client Error: " + error);
    alert("error occured web socket");
  };

  return socket;
}

export function disconnectWS(disconnectCallback) {
    let socket = new WebSocket("ws://localhost:8080/send");

    socket.send("disconnect " + sessionId);
    socket.close();

    disconnectCallback();

  
  
    }



