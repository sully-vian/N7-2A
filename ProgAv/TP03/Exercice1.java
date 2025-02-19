import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Exercice1 {
    public static void main(String[] args) {
        List<Integer> list = new ArrayList<Integer>();
        Collections.addAll(list, 2, 3, 5, 7);
        System.out.println(list);
        list.remove((Object) 5);
        System.out.println(list);

        List<Integer> unmodifiableList = Collections.unmodifiableList(list);
        System.out.println(unmodifiableList);
        unmodifiableList.add(5);
        System.out.println(unmodifiableList);
        unmodifiableList.remove((Object) 2);
        System.out.println(unmodifiableList);
    }
}