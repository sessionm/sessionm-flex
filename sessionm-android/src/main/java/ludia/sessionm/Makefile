# Build sessionm-android.jar #

## Configuration
CONFIG_FILE = ../../../../../../Makefile.config.example
include $(CONFIG_FILE)

## Build rules and recipes
build:
	mkdir -p ../../../../../../sessionm-ane/Android-ARM/
	javac *.java -cp ../../:./*
	cd ../../
	jar cvf  ../../../../../../sessionm-ane/Android-ARM/sessionm-android.jar ../../com/ ../../ludia/sessionm/*.class ../../ludia/sessionm/functions/*.class ../../ludia/sessionm/util/*.class ../../ludia/urbanairship/*.class

clean:	
	rm -f *.class functions/*.class util/*.class
