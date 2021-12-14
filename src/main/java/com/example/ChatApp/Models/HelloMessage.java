package com.example.ChatApp.Models;


import lombok.*;

@Data
@NoArgsConstructor
public class HelloMessage {

    @Getter @Setter
    private String name;

    public HelloMessage(String name) {
        this.name = name;
    }
}
