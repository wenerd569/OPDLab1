package dishwasher;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;

public class Dishwasher
{
    public enum WashMode{
        eco(0.6),
        hygiene(0.8),
        intense(0.95);

        private double cleaningPercentage;
        private WashMode(double cleaningPercentage){
            this.cleaningPercentage = cleaningPercentage;
        }
        public double getCleaningPercentage(){
            return cleaningPercentage;
        }
    }
    protected double washMode = 0;
    static private final int BUFFER_SIZE = 1024;

    protected File cleanDir;
    protected File dirtyDir;

    public Dishwasher(File dirtyDir, File cleanDir){
        this.dirtyDir = dirtyDir;
        this.cleanDir = cleanDir;
    }


    public void setMode(WashMode washMode){
        this.washMode = washMode.getCleaningPercentage();
    }
    
    public void start() throws IOException{
        File[] listOfFiles = dirtyDir.listFiles();
        if (listOfFiles == null)
            return;

        for (File in : listOfFiles) {
            if (in.isFile()) {
                File out = new File(cleanDir, in.getName());
                out.createNewFile();
                washFile(in, out);
            }
        }
    }

    protected void washFile(File in, File out) throws IOException{
        FileReader reader;
        FileWriter writer;
        reader = new FileReader(in);
        writer = new FileWriter(out);
        char[] buff = new char[BUFFER_SIZE];
        int count_char = 0;
        while ((count_char = reader.read(buff)) > 0) {
            if (count_char < BUFFER_SIZE){
                buff = Arrays.copyOf(buff, count_char);
            }
            washString(buff);
            writer.write(buff);
        }
        in.delete();
        reader.close();
        writer.close();
    }

    public void washString(char[] string){
        Random random = new Random();
        for (int i = 0; i < string.length; i++){
            if (string[i] != '\n' && random.nextDouble()<washMode){
                string[i] = ' ';
            }
        }
    }
}