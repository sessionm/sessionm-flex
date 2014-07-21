# Build sessionm.ane #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build:  ../build/sessionm.ane

../build/sessionm.ane:
	cp $(SESSIONM-ANDROID-SDK)/*.jar Android-ARM/SessionM.jar
	$(AIR-SDK)/bin/adt -package -target ane ../build/sessionm.ane \
	extension.xml -swc ../build/sessionm-actionscript.swc -platform iPhone-ARM -C \
	iPhone-ARM library.swf libsessionm-ios.a -platformoptions \
	iPhone-ARM/platform.xml -platform default -C default . -platform \
	Android-ARM -C Android-ARM library.swf sessionm-android.jar SessionM.jar -platformoptions Android-ARM/platform.xml

clean:
	rm -f ../build/sessionm.ane 
	rm -f Android-ARM/SessionM.jar

