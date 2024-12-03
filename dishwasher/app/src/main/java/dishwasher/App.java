package dishwasher;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetSocketAddress;

public class App {
    public static void main(String[] args) {
        int port;
        try{
            port = Integer.parseInt(args[0]);
        } catch (Exception e){
            port = 60610;
        }
        String dir = System.getProperty("user.dir") + "/dishwasher";
        InetSocketAddress address = new InetSocketAddress(port);
        var dishwasher = new Dishwasher(dir + "/dirty_file", dir + "/clear_file");
        var controler = new DishWasherControler(address, dishwasher);
        controler.setTcpNoDelay(true);
        controler.setDaemon(true);
        controler.start();
        try{
            BufferedReader sysin = new BufferedReader(new InputStreamReader(System.in));
            while (true) {
                String in = sysin.readLine();
                controler.broadcast(in);
                if (in.equals("exit")) {
                    controler.stop(1000);
                    break;
                }
            }
        } catch (Exception e){
        }
    }
}
