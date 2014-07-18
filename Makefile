# Top level Makefile for SessionmAirExample #

## Configuration
CONFIG_FILE = Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
.PHONY: default build/sessionm.ane iPhone android 

default: build build/sessionm.ane iPhone android

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
	rm -R -f build

config:
	sed -e 's/$$(AIR-VERSION)/$(AIR-VERSION)/g' -e 's/$$(EXT-ID)/$(EXT-ID)/g' -e 's/$$(EXT-VERSION)/$(EXT-VERSION)/g' sessionm-ane/extension.xml.in > sessionm-ane/extension.xml

	sed -e 's/$$(AIR-VERSION)/$(AIR-VERSION)/g' sessionm-ane/iPhone-ARM/platform.xml.in > sessionm-ane/iPhone-ARM/platform.xml

	sed -e 's/$$(AIR-VERSION)/$(AIR-VERSION)/g' -e 's/$$(APP-ID)/$(APP-ID)/g' -e 's/$$(APP-NAME)/$(APP-NAME)/g' -e 's/$$(APP-VERSION)/$(APP-VERSION)/g' -e 's/$$(EXT-ID)/$(EXT-ID)/g' -e 's/$$(ANDROID-APP-ID)/$(ANDROID-APP-ID)/g' sessionm-example/src/main/resources/app-descriptor.xml.in > sessionm-example/src/main/resources/app-descriptor.xml

	sed -e 's/$$(IOS-APP-ID)/$(IOS-APP-ID)/g' -e 's/$$(ANDROID-APP-ID)/$(ANDROID-APP-ID)/g' sessionm-example/src/main/flex/Main.as.in > sessionm-example/src/main/flex/Main.as

	sed -e 's/$$(EXT-VERSION)/$(EXT-VERSION)/g' sessionm-actionscript/src/main/flex/ludia/sessionm/SessionM.as.in > sessionm-actionscript/src/main/flex/ludia/sessionm/SessionM.as
