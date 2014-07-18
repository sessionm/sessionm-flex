# Build Main.swf and SessionmAirExample #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)

IOS_IPA = ../build/$(APP-NAME).ipa
ANDROID_APK = ../build/$(APP-NAME).apk

## Build rules and recipes
build: iPhone android

iPhone: $(IOS_IPA)

$(IOS_IPA): Main.swf
	cd src/main/flex
	$(AIR-SDK)/bin/adt -package -target ipa-test -keystore $(IOS-CERTIFICATE) \
	-storetype pkcs12 -provisioning-profile $(PROVISION) \
	$(IOS_IPA) src/main/resources/app-descriptor.xml \
	Main.swf -extdir ../build

android-certificate:
	$(AIR-SDK)/bin/adt -certificate -validityPeriod 25 -cn SelfSigned 1024-RSA ../build/androidCert.pfx p

install-android: $(ANDROID_APK)
	$(ANDROID-SDK)/platform-tools/adb install -r $(ANDROID_APK)

uninstall-android:
	$(ANDROID-SDK)/platform-tools/adb uninstall $(ANDROID_APK)

android: $(ANDROID_APK)

$(ANDROID_APK): Main.swf
	cd src/main/flex
	$(AIR-SDK)/bin/adt -package -target apk-captive-runtime -keystore $(ANDROID-CERTIFICATE) -storetype pkcs12 $(ANDROID_APK) src/main/resources/app-descriptor.xml Main.swf -extdir ../build

Main.swf:
	cd src/main/flex
	$(AIR-SDK)/bin/amxmlc src/main/flex/Main.as -include-libraries=../build/sessionm.ane -output Main.swf

clean:
	rm -f Main.swf
	rm -f ../build/SessionmAirExample.ipa
	rm -f ../build/SessionmAirExample.apk





