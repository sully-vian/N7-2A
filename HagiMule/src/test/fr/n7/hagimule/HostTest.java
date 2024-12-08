package test.fr.n7.hagimule;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.Random;

import static org.junit.Assert.assertFalse;

import org.junit.Before;
import org.junit.Test;

import fr.n7.hagimule.Host;

public class HostTest {

    private String randName1;
    private String randName2;
    private int randPort1;
    private int randPort2;
    private Host host1;
    private Host host2;
    private Random random;

    @Before
    public void setUp() {
        random = new Random();
        randName1 = randomName();
        randName2 = randomName();
        randPort1 = randomPort();
        randPort2 = randomPort();
        host1 = new Host(randName1, randPort1);
        host2 = new Host(randName2, randPort2);
    }

    @Test
    public void testGetName() {
        assertEquals(randName1, this.host1.getName());
        assertEquals(randName2, this.host2.getName());
    }

    @Test
    public void testGetPort() {
        assertEquals(randPort1, this.host1.getPort());
        assertEquals(randPort2, this.host2.getPort());
    }

    @Test
    public void testEquals() {
        assertTrue(this.host1.equals(this.host1));
        assertTrue(this.host2.equals(this.host2));

        assertFalse(this.host1.equals(this.host2));
        assertFalse(this.host2.equals(this.host1));

        assertTrue(this.host1.equals(new Host(randName1, randPort1)));
        assertTrue(this.host2.equals(new Host(randName2, randPort2)));
        assertFalse(this.host1.equals(new Host(randName2, randPort1)));

        assertFalse(this.host1.equals(null));
        assertFalse(this.host1.equals(new Object()));
    }

    @Test
    public void testToString() {
        assertEquals(randName1 + ":" + randPort1, this.host1.toString());
        assertEquals(randName2 + ":" + randPort2, this.host2.toString());
    }

    private String randomName() {
        int length = random.nextInt(10) + 1;
        String chars = "abcdefghijklmnopqrstuvwxyz";
        StringBuilder name = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            name.append(chars.charAt(random.nextInt(chars.length())));
        }
        return name.toString();
    }

    private int randomPort() {
        return random.nextInt(65536 - 1024) + 1024;
    }
}