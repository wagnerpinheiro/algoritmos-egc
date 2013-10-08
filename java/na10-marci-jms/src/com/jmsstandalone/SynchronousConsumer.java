package com.jmsstandalone;

import javax.jms.Connection;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageConsumer;
import javax.jms.QueueConnectionFactory;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class SynchronousConsumer {
    
    public static void main(String[] args) {
        final String CONNECTION_FACTORY = "jms/QueueConnectionFactory"; //nome JNDI 
	final String QUEUE = "jms/Queue1"; //nome JNDI 
	
	InitialContext ctx = null;
	Connection con = null;
	try {
            //1. Criacao do contexto inicial e lookup dos Objetos Administrados:
            ctx = new InitialContext(); 
            QueueConnectionFactory qcf = (QueueConnectionFactory) ctx.lookup(CONNECTION_FACTORY);
            Destination destination = (Destination) ctx.lookup(QUEUE);
			
            //2. Criacao e start da conexao:
            con = qcf.createConnection();
            con.start();
			
            //3. Criacao da sessao:
            Session session = con.createSession(false,Session.AUTO_ACKNOWLEDGE);
	
            //4. Criacao do MessageConsumer:
            MessageConsumer consumer = session.createConsumer(destination);
						
            //5. Consumo sincrono com o medodo receive():
            System.out.println("Consumidor aguardando mensagem...");
            TextMessage msg = (TextMessage) consumer.receive();
            System.out.println("Mensagem recebida = "+msg.getText());	
	} catch (NamingException e) {
            System.out.println("Erro no lookup...");
            e.printStackTrace();
	} catch (JMSException e2) {
            System.out.println("Erro JMS...");
            e2.printStackTrace();
	} finally {
            //6 Libercao dos recursos:
            if (con!=null) {
                try {
                    con.close();
                } catch (JMSException e) {
                    System.out.println("Erro fechando a conexão.");
                    e.printStackTrace();
                }
            }
            if (ctx!=null) {
                try {
                    ctx.close();
                } catch (NamingException e) {
                    System.out.println("Erro fechando o InitialContext.");
                    e.printStackTrace();
		}
            }
        }
    }    
}
