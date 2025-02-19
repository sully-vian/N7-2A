import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProtectionHandler implements InvocationHandler {

    private Object object;
    private List<String> forbiddenMethods;

    public ProtectionHandler(Object object, String... forbiddenMethods) {
        this.object = object;
        this.forbiddenMethods = new ArrayList<String>();
        Collections.addAll(this.forbiddenMethods, forbiddenMethods);
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        String methodName = method.getName();
        if (this.forbiddenMethods.contains(methodName)) {
            throw new UnsupportedOperationException();
        } else {
            // invoquer la méthode sur l'objet.
            return method.invoke(this.object, args);
        }
    }

}