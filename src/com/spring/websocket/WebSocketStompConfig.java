package com.spring.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketStompConfig implements WebSocketMessageBrokerConfigurer {
	
	//messageBroker config
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
 
        //in-memory message-broker, topic�� ���� prefix ����
         config.enableSimpleBroker("/topic");
 
 
        //�޼����� �����ϴ� handler�� �޼��� prefix ���� 
        config.setApplicationDestinationPrefixes("/api");
 
    };
 
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
       registry.addEndpoint("/ws").setAllowedOrigins("*").withSockJS();
    }
}
