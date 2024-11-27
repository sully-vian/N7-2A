import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface UnTest {
    boolean enabled() default true;

    Class<? extends Throwable> expected() default None.class;

    // Exception privée qui ne sera jamais jetée dans un test
    static class None extends Throwable {

    }

}