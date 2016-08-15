# Build sessionm-android.jar #
ROOT = ../../../../../..

## Configuration
CONFIG_FILE = $(ROOT)/Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build: $(ROOT)/sessionm-ane/Android-ARM/sessionm-android.jar

$(ROOT)/sessionm-ane/Android-ARM/sessionm-android.jar: *.java functions/*.java util/*.java
	mkdir -p $(ROOT)/sessionm-ane/Android-ARM/
	$(JAVA-COMMANDS)/javac -target 1.7 *.java */*.java -cp '$(ANDROID-SDK)/platforms/android-19/*:$(SESSIONM-ANDROID-SDK)/*:$(AIR-SDK)/lib/android/*:./*'
	(cd ../../ ; $(JAVA-COMMANDS)/jar cvf  ../../../../sessionm-ane/Android-ARM/sessionm-android.jar sessionm/flex/*.class sessionm/flex/functions/*.class sessionm/flex/util/*.class)

clean:  
	rm -f *.class functions/*.class util/*.class
	rm -f $(ROOT)/sessionm-ane/Android-ARM/sessionm-android.jar
