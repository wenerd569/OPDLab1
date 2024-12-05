package dishwasher;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.File;

public class App {
    public static void main(String[] args) {
        int port;
        try{
            port = Integer.parseInt(args[0]);
        } catch (Exception e){
            port = 60605;
        }
        String dir = System.getenv("HOME") + "/dishwasher";
        File dirty_file = new File(dir + "/dirty_file");
        File clean_file = new File(dir + "/clean_file");
        dirty_file.mkdir();
        clean_file.mkdir();


        var dishwasher = new Dishwasher(dirty_file, clean_file);
        var controler = new DishWasherControler(port, dishwasher);
                
        try{
            BufferedReader sysin = new BufferedReader(new InputStreamReader(System.in));
            while (true) {
                String in = sysin.readLine();
                if (in.equals("exit")) {
                    return;
                }
            }
        } catch (Exception e){
        }
    }
}
