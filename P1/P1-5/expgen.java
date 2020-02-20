import java.util.Random;

public class expgen {

    static String gen(int max) {
        Random rand = new Random();
        int op = rand.nextInt(5);
        if (op == 0 || max <= 1)
            return Integer.toString(rand.nextInt(10));
        else if (op == 1 || op == 2) {
            return gen(max - 1) + "+" + gen(max - 1);
        } else {
            return gen(max - 1) + "*" + gen(max - 1);
        }
    }
    
    public static void main(String[] args){
        Random rand = new Random();
        for(int i = 0; i < 30; i++)
            System.out.println(gen(rand.nextInt(6) + 2));
    }
}