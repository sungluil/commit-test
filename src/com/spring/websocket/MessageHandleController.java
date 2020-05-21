package com.spring.websocket;

import java.time.LocalDateTime;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MessageHandleController {


    private final ObjectMapper mapper = new ObjectMapper();

    @MessageMapping("/echo")
    @SendTo("/topic/messages")
    public EchoMessage echo(String message) throws Exception {
        System.err.println(message);
        return  new EchoMessage(message,LocalDateTime.now());
    }

    @RequestMapping("/api/healthcheck")
    public String healthCheck(){
        return "hello world";
    }
}

class EchoMessage{
    private String message;
    private LocalDateTime time;

    public EchoMessage(String message, LocalDateTime time) {
        this.message = message;
        this.time = time;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    @Override
    public String toString() {
        return "EchoMessage{" +
                "message='" + message + '\'' +
                ", time=" + time +
                '}';
    }
}
