package com.example.ChatApp.Controller;

import com.example.ChatApp.Models.Greeting;
import com.example.ChatApp.Models.HelloMessage;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.HtmlUtils;

@RestController
public class ChatController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/")
    public String hello() {
        return "<body style='background-color:black;color:white'><h1>index</h1><body>";
    }


    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Greeting chat(HelloMessage message) {
        System.out.println("Message: " + message.getName());
        return new Greeting(" Hi, " + HtmlUtils.htmlEscape(message.getName()));
    }

    @PostMapping("/send")
    public Greeting send(@RequestBody Greeting message) {

        chatService.notifyFrontEnd(message.getMessage());

        return new Greeting(" Hi, " + HtmlUtils.htmlEscape(message.getMessage()));
    }

    @GetMapping("/hello")
    public Greeting get() {
        return new Greeting("Michael");
    }


}
