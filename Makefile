# Top level Makefile for SessionmAirExample #

## Configuration
CONFIG_FILE = Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
.PHONY: default build/sessionm.ane iPhone android 

default: build build/sessionm.ane iPhone android

# If you receive "Error: This Java instance does not support a 32-bit JVM" when building this target, remove all references to the -d32 flag from the $(AIR-SDK)/bin/asdoc script
doc: build/sessionm-actionscript.swc
	$(AIR-SDK)/bin/aasdoc -source-path sessionm-actionscript/src/main/flex/ -doc-sources sessionm-actionscript/src/main/flex/

build/sessionm.ane: build/sessionm-actionscript.swc sessionm-ane/Android-ARM/sessionm-android.jar sessionm-ane/iPhone-ARM/libsessionm-ios.a
	$(MAKE) -C sessionm-ane

build/sessionm-actionscript.swc:
	$(MAKE) -C sessionm-actionscript

sessionm-ane/Android-ARM/sessionm-android.jar:
	$(MAKE) -C sessionm-android/src/main/java/ludia/sessionm

sessionm-ane/iPhone-ARM/libsessionm-ios.a:
	$(MAKE) -C sessionm-ios/src/xcode

iPhone: build build/sessionm.ane
	$(MAKE) -C sessionm-example iPhone

android-certificate: build
	$(MAKE) -C sessionm-example android-certificate

install-android: android
	$(MAKE) -C sessionm-example install-android

uninstall-android:
	$(MAKE) -C sessionm-example uninstall-android

android: build build/sessionm.ane
	$(MAKE) -C sessionm-example android

build:
	mkdir build

clean:
	$(MAKE) -C sessionm-actionscript clean
	$(MAKE) -C sessionm-android/src/main/java/ludia/sessionm clean
	$(MAKE) -C sessionm-ios/src/xcode clean
	$(MAKE) -C sessionm-ane clean
	$(MAKE) -C sessionm-example clean
	rm -R -f asdoc-output
	rm -R -f build
