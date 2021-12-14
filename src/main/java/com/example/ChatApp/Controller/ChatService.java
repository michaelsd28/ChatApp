package com.example.ChatApp.Controller;

import com.example.ChatApp.Models.Greeting;
import com.example.ChatApp.Models.HelloMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Service
public class ChatService {


    SimpMessagingTemplate messagingTemplate;

    @Autowired
    public ChatService(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    public void notifyFrontEnd(String message) {
     Greeting greeting = new Greeting(message);

     messagingTemplate.convertAndSend("/topic/greetings", greeting);
    }



}
