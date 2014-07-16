# Build sessionm-android.jar #

## Configuration
CONFIG_FILE = ../../../../../../Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build:
	mkdir -p ../../../../../../sessionm-ane/Android-ARM/
	jar cvf ../../../../../../sessionm-ane/Android-ARM/sessionm-android.jar *.java functions/ util/ $(ANDROID-SDK)

clean:	
	rm -f *.class functions/*.class util/*.class
