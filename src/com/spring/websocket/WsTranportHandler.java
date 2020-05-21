package com.spring.websocket;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WsTranportHandler extends TextWebSocketHandler {
	
	// connection�� �ξ��� �� ����ȴ�
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.err.println("session connected +=" + session);
    }
    // �޼��� ����
    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
    	System.err.println(("session connected +=" + session)+ ", message=" + message);
        //echo Message
        session.sendMessage(message);
 
    }
    // transport �� error
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        System.err.println("transport error =" + session +", exception =" + exception);
    }
    // connection close
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
 
        System.err.println("session close -=" + session);
 
    }
}
