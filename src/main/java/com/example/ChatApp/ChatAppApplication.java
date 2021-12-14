package com.example.ChatApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ChatAppApplication {

	public static void main(String[] args) {

//		open url in browser
//		http://localhost:8080/

		String url = "http://localhost:8080/";

		try {
			java.awt.Desktop.getDesktop().browse(java.net.URI.create(url));
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		SpringApplication.run(ChatAppApplication.class, args);
	}

}
