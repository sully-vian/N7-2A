package fr.n7.hagimule.test;

import static org.junit.Assert.assertTrue;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.rmi.RemoteException;

import org.junit.Before;
import org.junit.Test;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.DiaryImpl;

public class TestDiaryImpl {

    private DiaryImpl diary;
    private Host host1;
    private Host host2;

    @Before
    public void setUp() throws RemoteException {
        this.diary = new DiaryImpl();
        this.host1 = new Host("host1", 1234);
        this.host2 = new Host("host2", 5678);
    }

    // @Test
    // public void testDiaryImpl() throws RemoteException {
    //     assertTrue(this.diary.getFileNames().isEmpty());
    // }

    // @Test
    // public void testGetFileNames() throws RemoteException, DuplicateFileNameException {
    //     assertTrue(this.diary.getFileNames().isEmpty());
    //     this.diary.addFile("file1", 100, host1);
    //     assertTrue(this.diary.getFileNames().contains("file1"));
    // }

    // @Test
    // public void testGetFileSize() throws RemoteException, DuplicateFileNameException {
    //     this.diary.addFile("file1", 100, host1);
    //     assertTrue(this.diary.getFileSize("file1") == 100);
    // }

    // @Test
    // public void testGetHosts() throws RemoteException, DuplicateFileNameException {
    //     assertTrue(this.diary.getHosts("file1") == null);
    //     this.diary.addFile("file1", 100, host1);
    //     assertTrue(this.diary.getHosts("file1").contains(host1));
    // }

    // @Test
    // public void testAddFile() throws RemoteException, DuplicateFileNameException {
    //     this.diary.addFile("file1", 100, host1);
    //     assertTrue(this.diary.getFileNames().contains("file1"));
    //     assertTrue(this.diary.getHosts("file1").contains(host1));

    //     this.diary.addFile("file1", 100, host2);
    //     assertTrue(this.diary.getHosts("file1").contains(host2));
    // }

    // @Test
    // public void testAddHostAlreadyPresent() throws RemoteException, DuplicateFileNameException {
    //     this.diary.addFile("file1", 100, host1);
    //     int initialSize = this.diary.getHosts("file1").size();

    //     this.diary.addFile("file1", 100, new Host("host1", 1234));
    //     int newSize = this.diary.getHosts("file1").size();

    //     assertTrue(initialSize == newSize);
    // }

    // @Test(expected = DuplicateFileNameException.class)
    // public void testAddFileException() throws RemoteException, DuplicateFileNameException {
    //     this.diary.addFile("file1", 100, host1);
    //     this.diary.addFile("file1", 200, host2);
    // }

    // @Test
    // public void testRemoveHost() throws RemoteException, DuplicateFileNameException {
    //     this.diary.addFile("file1", 100, host1);
    //     this.diary.addFile("file1", 100, host2);
    //     this.diary.removeHost("file1", host1);
    //     assertTrue(this.diary.getHosts("file1").contains(host2));
    //     assertTrue(!this.diary.getHosts("file1").contains(host1));
    // }

    // @Test
    // public void testSerializability() throws IOException, DuplicateFileNameException, ClassNotFoundException {
    //     this.diary.addFile("file1", 100, host1);

    //     // Sérialiser l'annuaire
    //     ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
    //     try (ObjectOutputStream oos = new ObjectOutputStream(byteOut)) {
    //         oos.writeObject(this.diary);
    //     }

    //     ByteArrayInputStream byteIn = new ByteArrayInputStream(byteOut.toByteArray());
    //     try (ObjectInputStream ois = new ObjectInputStream(byteIn)) {
    //         // DiaryImpl deserializedDiary = (DiaryImpl) ois.readObject();
    //     }

    // }

}