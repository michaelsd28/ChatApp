
let stompClient = null;

export function connect(callback) {

    var socket = new SockJS('/chat-app');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {

        console.log('Connected: ' + frame);
        stompClient.subscribe('/message/comm', function (greeting) {
            console.log(greeting," * greeting *")
     
        });
    });
}




