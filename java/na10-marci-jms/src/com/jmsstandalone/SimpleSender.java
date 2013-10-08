package com.jmsstandalone;

import java.util.Date;
import java.util.Hashtable;
import javax.jms.Connection;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.QueueConnectionFactory;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class SimpleSender {

    public static void main(String[] args) throws Exception {
        final String CONNECTION_FACTORY = "jms/QueueConnectionFactory"; //nome JNDI 
        final String QUEUE = "jms/Queue1"; //nome JNDI 

        InitialContext ctx = null;
        Connection con = null;
        try {
                Hashtable ht = new Hashtable();
                //ht.put(Context.INITIAL_CONTEXT_FACTORY,
                //            "weblogic.jndi.WLInitialContextFactory");
                ht.put(Context.PROVIDER_URL,
                        "t3://localhost:7001");
                //1. Criacao do contexto inicial e lookup dos Objetos Administrados:
                ctx = new InitialContext(); 
                QueueConnectionFactory qcf = (QueueConnectionFactory) ctx.lookup(CONNECTION_FACTORY);
                Destination destination = (Destination) ctx.lookup(QUEUE);

                //2. Criacao da conexao:
                con = qcf.createConnection();

                //3. Criacao da sessao:
                Session session = con.createSession(false,Session.AUTO_ACKNOWLEDGE);

                //4. Criacao do MessageProducer e da mensagem:
                MessageProducer producer = session.createProducer(destination);
                TextMessage msg = session.createTextMessage("Hello by SimpleSender !"+new Date());

                //5. Envio da mensagem:
                producer.send(msg);
                System.out.println("Mensagem enviada!");
        } catch (NamingException e) {
                System.out.println("Erro no lookup...");
                e.printStackTrace();
        } catch (JMSException e2) {
                System.out.println("Erro JMS...");
                e2.printStackTrace();
        } finally {
                //6. Liberacao dos recursos:
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
