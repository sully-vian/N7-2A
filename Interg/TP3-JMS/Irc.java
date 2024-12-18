
import java.awt.Button;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Frame;
import java.awt.TextArea;
import java.awt.TextField;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.Vector;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

public class Irc {
    public static TextArea text;
    public static TextField data;
    public static Frame frame;

    public static String url = ActiveMQConnection.DEFAULT_BROKER_URL;
    public static String subject = "MyQueue";

    public static Vector<String> users = new Vector<String>();
    public static String myName;

    public static ConnectionFactory connectionFactory;
    public static Connection connection;
    public static Session session;
    public static MessageConsumer consumer;
    public static MessageProducer producer;
    public static Topic topic;

    public static void main(String argv[]) {

        if (argv.length != 1) {
            System.out.println("java Irc <name>");
            return;
        }
        myName = argv[0];

        // creation of the GUI
        frame = new Frame();
        frame.setLayout(new FlowLayout());

        text = new TextArea(10, 55);
        text.setEditable(false);
        text.setForeground(Color.green);
        frame.add(text);

        data = new TextField(55);
        frame.add(data);

        Button writeButton = new Button("write");
        writeButton.addActionListener(new WriteListener());
        frame.add(writeButton);

        Button connectButton = new Button("connect");
        connectButton.addActionListener(new ConnectListener());
        frame.add(connectButton);

        Button whoButton = new Button("who");
        whoButton.addActionListener(new WhoListener());
        frame.add(whoButton);

        Button leaveButton = new Button("leave");
        leaveButton.addActionListener(new LeaveListener());
        frame.add(leaveButton);

        frame.setSize(470, 300);
        text.setBackground(Color.black);
        frame.setVisible(true);

        frame.setTitle(myName);

        frame.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent we) {
                frame.dispose();
            }
        });
    }

    /* allow to print something in the window */
    public static void print(String msg) {
        try {
            text.append(msg + "\n");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

// action invoked when the "write" button is clicked
class WriteListener implements ActionListener {
    public void actionPerformed(ActionEvent ae) {
        System.out.println("write button pressed");
        try {
            TextMessage msg = Irc.session.createTextMessage(Irc.myName + ":" + Irc.data.getText());
            Irc.producer.send(msg);
        } catch (JMSException e) {
            e.printStackTrace();
        }
    }
}

// action invoked when the "connect" button is clicked
class ConnectListener implements ActionListener {
    public void actionPerformed(ActionEvent ae) {
        System.out.println("connect button pressed");

        try {
            Irc.connectionFactory = new ActiveMQConnectionFactory(Irc.url);
            Irc.connection = Irc.connectionFactory.createConnection();
            Irc.connection.setClientID(Irc.myName);
            Irc.connection.start();

            Irc.session = Irc.connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

            Destination destination = Irc.session.createTopic(Irc.subject);

            Irc.producer = Irc.session.createProducer(destination);
            Irc.consumer = Irc.session.createDurableSubscriber((Topic) destination, Irc.myName);

            TextMessage msg = Irc.session.createTextMessage("[connection] " + Irc.myName);
            Irc.producer.send(msg);

            MessageListener listener = new MessageListener() {
                public void onMessage(Message msg) {
                    try {
                        TextMessage textmsg = (TextMessage) msg;
                        String msgText = textmsg.getText();
                        if (msgText.startsWith("[connection] ")) {
                            String userName = msgText.substring(12);
                            Irc.users.add(userName);
                        } else if (msgText.startsWith("[disconnection] ")) {
                            String userName = msgText.substring(15);
                            Irc.users.remove(userName);
                        }

                        Irc.print(textmsg.getText());
                        System.out.println(textmsg.getText());
                    } catch (JMSException e) {
                        e.printStackTrace();
                    }
                }
            };
            Irc.consumer.setMessageListener(listener);
        } catch (JMSException e) {
            e.printStackTrace();
        }
    }
}

// action invoked when the "who" button is clicked
class WhoListener implements ActionListener {
    public void actionPerformed(ActionEvent ae) {
        try {
            System.out.println(Irc.users);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

// action invoked when the "leave" button is clicked
class LeaveListener implements ActionListener {
    public void actionPerformed(ActionEvent ae) {
        try {
            System.out.println("leave button pressed");
            TextMessage msg = Irc.session.createTextMessage("[disconnection] " + Irc.myName);
            Irc.producer.send(msg);
            Irc.connection.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
