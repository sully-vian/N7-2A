import java.util.Set;

import javax.annotation.processing.AbstractProcessor;
import javax.annotation.processing.Messager;
import javax.annotation.processing.RoundEnvironment;
import javax.annotation.processing.SupportedAnnotationTypes;
import javax.annotation.processing.SupportedSourceVersion;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.Element;
import javax.lang.model.element.ElementKind;
import javax.lang.model.element.Modifier;
import javax.lang.model.element.TypeElement;
import javax.tools.Diagnostic.Kind;

/** Check that a class marked {@code @Utility} is indeed a utility class. */
@SupportedAnnotationTypes("Utility")
@SupportedSourceVersion(SourceVersion.RELEASE_11)
public class UtilityProcessor extends AbstractProcessor {

	@Override
	public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment roundingEnvironment) {
		Messager messager = processingEnv.getMessager();
		messager.printMessage(Kind.NOTE,
				"UtilityProcessor executed.");
		for (TypeElement te : annotations) {
			for (Element elt : roundingEnvironment.getElementsAnnotatedWith(te)) {

				if (elt.getKind() != ElementKind.CLASS) {
					messager.printMessage(Kind.ERROR, "@Utility applies to class only:", elt);

				} else if (!elt.getModifiers().contains(Modifier.FINAL)) {
					messager.printMessage(Kind.NOTE, elt.getModifiers().toString());
					messager.printMessage(Kind.ERROR, "@Utility applies to final class only:", elt);

				} else if (elt.getEnclosedElements().stream()
						.allMatch(e -> e.getModifiers().contains(Modifier.STATIC))) {
					messager.printMessage(Kind.ERROR, "@Utility applies to class with only static methods", elt);
				}
			}
		}
		return true;
	}

}
