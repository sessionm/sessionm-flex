# Top level Makefile for SessionmAirExample #

## Configuration
CONFIG_FILE = Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
.PHONY: default ane iPhone android 

default: build ane iPhone android

ane:
	$(MAKE) -C sessionm-actionscript
	$(MAKE) -C sessionm-android/src/main/java/ludia/sessionm
	$(MAKE) -C sessionm-ios/src/xcode
	$(MAKE) -C sessionm-ane

iPhone: build ane
	$(MAKE) -C sessionm-example iPhone

android: build ane
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



