# Le chemin vers Z3 est positionné vers un répertoire partagé.
# Vous pouvez modifier cette variable d'environnement si vous
# avez installé Z3 sur votre compte ou sur votre machine
# personnelle.
ifeq ($(shell whoami), sully_vian)
	PATH_TO_Z3 = /home/sully_vian/z3-4.11.2-x64-glibc-2.31/bin/
else
	PATH_TO_Z3 = /mnt/n7fs/ens/tp_dupont/z3/bin
endif

JAVAC = javac
JAVA = LD_LIBRARY_PATH=$(PATH_TO_Z3) java
CP_OPTS = -cp $$CLASSPATH:$(PATH_TO_Z3)/com.microsoft.z3.jar
JAVAC_OPTS = $(CP_OPTS) -d classes
JAVA_OPTS = $(CP_OPTS):./classes -Djava.library.path=$(PATH_TO_Z3)
SRC_DIR = src/fr/n7/smt

_SRC_FILES = Z3Utils.java TransitionSystem.java DummyTransitionSystem.java \
	BMC.java MainDummySimulation.java MainDummyExact.java \
	ArraySwapsTransitionSystem.java MainArrayCLI.java

SRC_FILES = $(patsubst %,$(SRC_DIR)/%,$(_SRC_FILES))

.PHONY: compile run-simulation run-exact

compile: $(SRC_FILES) | classes
	$(JAVAC) $(JAVAC_OPTS) $^

run-simulation: compile
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.MainDummySimulation

run-exact: compile
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.MainDummyExact

run-array-swaps: compile
	$(JAVA) $(JAVA_OPTS) fr.n7.smt.MainArrayCLI $(ARRAY)

classes:
	mkdir -p $@

clean:
	- rm -rf classes *.log **/*~
