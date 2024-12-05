package dishwasher;

import java.io.IOException;
import java.net.ServerSocket;

import dishwasher.Dishwasher.WashMode;




public class DishWasherControler{
    Dishwasher dishwasher;
    ServerSocket serverSocket;

    public DishWasherControler(int port, Dishwasher dishwasher){
        this.dishwasher = dishwasher;
        WSoket socket;
        
        try {
            serverSocket = new ServerSocket(port);
            while (true) {
                socket = new WSoket(serverSocket.accept());
                while (true) {
                    if (socket.isClosed())
                        break;
                    
                    var message = socket.recive_line();
                    if (message == null || message == "")
                        continue;
                    onMessage(socket, message);
                }
            }
        } catch (IOException e) { }
    }
    
    
    public void onMessage(WSoket conn, String message) {
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
                    System.out.print(e.getMessage());
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
}
