# Build sessionm.ane #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)
include ../Makefile.extversion

## Build rules and recipes
build:  default ../build/sessionm.ane 

default: 
	mkdir default

../build/sessionm.ane: extension.xml iPhone-ARM/platform.xml Android-ARM/platform.xml library.swf Android-ARM/sessionm-android.jar iPhone-ARM/libsessionm-ios.a ../build/sessionm-actionscript.swc
	cp $(SESSIONM-ANDROID-SDK)/*.jar Android-ARM/SessionM.jar
	$(AIR-SDK)/bin/adt -package -target ane ../build/sessionm.ane \
	extension.xml -swc ../build/sessionm-actionscript.swc -platform iPhone-ARM -C \
	iPhone-ARM library.swf libsessionm-ios.a -platformoptions \
	iPhone-ARM/platform.xml -platform default -C default . -platform \
	Android-ARM -C Android-ARM library.swf sessionm-android.jar SessionM.jar -platformoptions Android-ARM/platform.xml

extension.xml:
	sed -e 's/$$(AIR-VERSION)/$(AIR-VERSION)/g' -e 's/$$(EXT-ID)/$(EXT-ID)/g' -e 's/$$(EXT-VERSION)/$(EXT-VERSION)/g' extension.xml.in > extension.xml

iPhone-ARM/platform.xml:
	sed -e 's/$$(AIR-VERSION)/$(AIR-VERSION)/g' iPhone-ARM/platform.xml.in > iPhone-ARM/platform.xml

Android-ARM/platform.xml:
	sed -e 's/$$(AIR-VERSION)/$(AIR-VERSION)/g' Android-ARM/platform.xml.in > Android-ARM/platform.xml

clean:
	rm -f ../build/sessionm.ane 
	rm -f Android-ARM/SessionM.jar
	rm -f extension.xml
	rm -f iPhone-ARM/platform.xml
	rm -f Android-ARM/platform.xml
