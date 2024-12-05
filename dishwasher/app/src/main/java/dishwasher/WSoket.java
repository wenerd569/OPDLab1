package dishwasher;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

public class WSoket{
    private Socket socket;
    private BufferedReader reader;
    private BufferedWriter writer;

    public WSoket(Socket socket){
        this.socket = socket;
        try {
            reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
        } catch (IOException e) {
            System.out.println(e);
        }
    }
    public void send(String message){
        System.out.println(message);
        try{
            writer.append(message);
            writer.newLine();
            writer.flush();
        } catch (IOException e){
            System.out.println(e);
        }
    }
    public String recive_line(){
        try {
            var result = reader.readLine();
            System.out.println(result);
            return result;
        } catch (IOException e){
            System.out.println(e);
        }
        return null;
    }
    public boolean isConnected(){
        return socket.isConnected();
    }
    public boolean isClosed(){
        return socket.isClosed();
    }
    public void close(){
        try{
            socket.close();
        } catch (IOException e){
            System.out.println(e);
        }
    }
}
