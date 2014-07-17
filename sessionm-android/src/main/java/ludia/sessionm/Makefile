# Build sessionm-android.jar #
ROOT = ../../../../../..
JAVA-6 = /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Commands

## Configuration
CONFIG_FILE = $(ROOT)/Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build: $(ROOT)/sessionm-ane/Android-ARM/sessionm-android.jar

$(ROOT)/sessionm-ane/Android-ARM/sessionm-android.jar:
	mkdir -p $(ROOT)/sessionm-ane/Android-ARM/
	$(JAVA-6)/javac -target 1.6 *.java */*.java -cp '$(ANDROID-SDK)/platforms/android-19/*:$(SESSIONM-ANDROID-SDK)/*:$(AIR-SDK)/lib/android/*:./*'
	(cd ../../ ; $(JAVA-6)/jar cvf  ../../../../sessionm-ane/Android-ARM/sessionm-android.jar ludia/sessionm/*.class ludia/sessionm/functions/*.class ludia/sessionm/util/*.class) 

clean:  
	rm -f *.class functions/*.class util/*.class
	rm -f $(ROOT)/sessionm-ane/Android-ARM/sessionm-android.jar
