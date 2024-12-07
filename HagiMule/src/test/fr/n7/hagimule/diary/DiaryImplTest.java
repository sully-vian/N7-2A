package test.fr.n7.hagimule.diary;

import static org.junit.Assert.assertTrue;

import java.io.Serializable;
import java.lang.reflect.Method;
import java.rmi.RemoteException;

import org.junit.Before;
import org.junit.Test;

import fr.n7.hagimule.diary.DiaryImpl;

public class DiaryImplTest {

    private DiaryImpl diary;

    @Before
    public void setUp() throws RemoteException {
        this.diary = new DiaryImpl();
    }

    @Test
    public void testDiaryImpl() throws RemoteException {
        assertTrue(this.diary.getFiles().isEmpty());
    }

    @Test
    public void testGetFiles() throws RemoteException {
        assertTrue(this.diary.getFiles().isEmpty());
        this.diary.addHost("file1", "host1");
        assertTrue(this.diary.getFiles().contains("file1"));
    }

    @Test
    public void testGetHosts() throws RemoteException {
        assertTrue(this.diary.getHosts("file1").isEmpty());
        this.diary.addHost("file1", "host1");
        assertTrue(this.diary.getHosts("file1").contains("host1"));
    }

    @Test
    public void testAddHost() throws RemoteException {
        this.diary.addHost("file1", "host1");
        assertTrue(this.diary.getFiles().contains("file1"));
        assertTrue(this.diary.getHosts("file1").contains("host1"));

        this.diary.addHost("file1", "host2");
        assertTrue(this.diary.getHosts("file1").contains("host2"));
    }

    @Test
    public void testRemoveHost() throws RemoteException {
        this.diary.addHost("file1", "host1");
        this.diary.addHost("file1", "host2");
        this.diary.removeHost("file1", "host1");
        assertTrue(this.diary.getHosts("file1").contains("host2"));
        assertTrue(!this.diary.getHosts("file1").contains("host1"));
    }

    @Test
    public void testReturnTypesAreSerializable() {
        Method[] methods = DiaryImpl.class.getDeclaredMethods();
        for (Method method : methods) {
            Class<?> returnType = method.getReturnType();
            if (returnType.equals(void.class)) {
                continue;
            }
            assertTrue(
                    "Le type de retour de " + method.getName()
                            + " n'est pas sérialisable et ne peut pas être renvoyé par RMI.",
                    Serializable.class.isAssignableFrom(returnType));
        }
    }

}