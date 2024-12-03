import java.util.List;
import java.util.Map;
import java.net.Socket;
import java.util.HashMap;

public class DiaryImpl extends Thread implements Diary {

    private static Map<String, List<String>> clientMap = new HashMap<String, List<String>>();

    private static final String mapFilePath = "map.json";

    private Socket clientSocket;

    public DiaryImpl(Socket clientSocket) {
        this.clientSocket = clientSocket;
    }

    @Override
    public void sendFiles() {
        // TODO
    }

    @Override
    public void sendClientIPs(String filename) {
        // TODO
    }

    @Override
    public void AddEntry(String filename, String clientIP) {
        // TODO
    }

    @Override
    public void removeEntry(String filename, String clientIP) {
        // TODO
    }

    @Override
    public void writeMap() {
        // TODO
    }

    @Override
    public void readMap() {
        // TODO
    }
}