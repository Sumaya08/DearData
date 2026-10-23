//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

import java.util.ArrayList;

public class Main {
    public Main() {
    }

    public static void main(String[] args) {
        ArrayList<Walk> walks = new ArrayList();
        walks.add(new Walk(45, "moderate", 4, "pavement and grass", 2));
        Walk firstwalk = (Walk)walks.get(0);
        System.out.println("Duration:" + firstwalk.duration);
        System.out.println("Pace:" + firstwalk.pace);
        System.out.println("turns:" + firstwalk.turns);
        System.out.println("Surface:" + firstwalk.surface);
        System.out.println("Breaks:" + firstwalk.breaks);
    }
}

