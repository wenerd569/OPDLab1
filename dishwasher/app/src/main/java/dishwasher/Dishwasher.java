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

    protected String cleanDir;
    protected String dirtyDir;

    public Dishwasher(String dirtyDir, String cleanDir){
        this.dirtyDir = dirtyDir;
        this.cleanDir = cleanDir;
    }


    public void setMode(WashMode washMode){
        this.washMode = washMode.getCleaningPercentage();
    }
    
    public void start() throws IOException{   
        File folder = new File(dirtyDir);
        File[] listOfFiles = folder.listFiles();

        for (File in : listOfFiles) {
            if (in.isFile()) {
                File out = new File(cleanDir + "/" + in.getName());
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
        reader.close();
        writer.close();
    }

    public void washString(char[] string){
        Random random = new Random();
        for (int i = 0; i < string.length; i++){
            if (random.nextDouble()<washMode){
                string[i] = ' ';
            }
        }
    }
}