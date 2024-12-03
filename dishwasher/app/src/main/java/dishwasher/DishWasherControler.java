package dishwasher;

import java.io.IOException;
import java.net.InetSocketAddress;

import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.*;

import dishwasher.Dishwasher.WashMode;

public class DishWasherControler extends WebSocketServer{
    Dishwasher dishwasher;

    public DishWasherControler(InetSocketAddress address, Dishwasher dishwasher){
        super(address);
        this.dishwasher = dishwasher;
    }

    @Override
    public void onOpen(WebSocket conn, ClientHandshake handshake) {
        System.out.println(conn + " is open");
        conn.send("welcome");
    }

    @Override
    public void onClose(WebSocket conn, int code, String reason, boolean remote) {
        System.out.println(conn + " is close");
    }

    @Override
    public void onMessage(WebSocket conn, String message) {
        System.out.println(message);
        var parts = message.split(" ");
        switch (parts[0].toLowerCase()){
            case "start":
                switch (parts[1].toLowerCase()){
                    case "hard", "intense", "3":
                        dishwasher.setMode(WashMode.intense);
                        break;
                    case "normal", "hygiene", "2":
                        dishwasher.setMode(WashMode.hygiene);
                        break;
                    case "light", "eco", "1":
                        dishwasher.setMode(WashMode.eco);
                        break;
                    default:
                        conn.send("Error: mod is incorrect");
                        conn.close();
                        return;
                }
                try {
                    dishwasher.start();
                    conn.send("Сompleted");
                    conn.close();
                } catch (IOException e) {
                    conn.send("File read or write error");
                    conn.close();
                }
                break;
            default:
                conn.send("Error command");
                conn.close();
                break;
        }
    }

    @Override
    public void onError(WebSocket conn, Exception ex) {
        System.out.println(conn + " has error");
        ex.printStackTrace();
    }

    @Override
    public void onStart() {
        System.out.println("Server started on port " + getPort());
        setConnectionLostTimeout(0);
        setConnectionLostTimeout(100);
    }
}
