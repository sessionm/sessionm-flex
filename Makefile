# Top level Makefile for SessionmAirExample #

## Configuration
CONFIG_FILE = Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
.PHONY: default build/sessionm.ane iPhone android 

default: build build/sessionm.ane iPhone android

build/sessionm.ane: build/$(SWC) sessionm-ane/Android-ARM/sessionm-android.jar sessionm-ane/iPhone-ARM/libsessionm-ios.a
	$(MAKE) -C sessionm-ane

build/$(SWC):
	$(MAKE) -C sessionm-actionscript

sessionm-ane/Android-ARM/sessionm-android.jar:
	$(MAKE) -C sessionm-android/src/main/java/ludia/sessionm

sessionm-ane/iPhone-ARM/libsessionm-ios.a:
	$(MAKE) -C sessionm-ios/src/xcode

iPhone: build build/sessionm.ane
	$(MAKE) -C sessionm-example iPhone

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
	rm -R -f build



