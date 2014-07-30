# Build Main.swf and SessionmAirExample #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)
include ../Makefile.extversion

IOS_IPA = ../build/$(APP-NAME).ipa
ANDROID_APK = ../build/$(APP-NAME).apk

## Build rules and recipes
build: iPhone android

iPhone: $(IOS_IPA)

$(IOS_IPA): Main.swf src/main/resources/app-descriptor.xml
	cd src/main/flex
	$(AIR-SDK)/bin/adt -package -target ipa-test -keystore $(IOS-CERTIFICATE) \
	-storetype pkcs12 -provisioning-profile $(PROVISION) \
	$(IOS_IPA) src/main/resources/app-descriptor.xml \
	Main.swf -extdir ../build

android-certificate:
	$(AIR-SDK)/bin/adt -certificate -validityPeriod 25 -cn SelfSigned 1024-RSA ../androidCert.pfx p

install-android: $(ANDROID_APK)
	$(ANDROID-SDK)/platform-tools/adb install -r $(ANDROID_APK)

uninstall-android:
	$(ANDROID-SDK)/platform-tools/adb uninstall air.$(APP-ID)

android: $(ANDROID_APK)

$(ANDROID_APK): Main.swf src/main/resources/app-descriptor.xml
	cd src/main/flex
	$(AIR-SDK)/bin/adt -package -target apk-captive-runtime -keystore $(ANDROID-CERTIFICATE) -storetype pkcs12 $(ANDROID_APK) src/main/resources/app-descriptor.xml Main.swf -extdir ../build

Main.swf: src/main/flex/Main.as
	cd src/main/flex
	$(AIR-SDK)/bin/amxmlc src/main/flex/Main.as -include-libraries=../build/sessionm.ane -output Main.swf

src/main/flex/Main.as:
	sed -e 's/$$(IOS-APP-ID)/$(IOS-APP-ID)/g' -e 's/$$(ANDROID-APP-ID)/$(ANDROID-APP-ID)/g' src/main/flex/Main.as.in > src/main/flex/Main.as

src/main/resources/app-descriptor.xml:
	sed -e 's/$$(AIR-VERSION)/$(AIR-VERSION)/g' -e 's/$$(APP-ID)/$(APP-ID)/g' -e 's/$$(APP-NAME)/$(APP-NAME)/g' -e 's/$$(APP-VERSION)/$(APP-VERSION)/g' -e 's/$$(EXT-ID)/$(EXT-ID)/g' -e 's/$$(ANDROID-APP-ID)/$(ANDROID-APP-ID)/g' src/main/resources/app-descriptor.xml.in > src/main/resources/app-descriptor.xml

clean:
	rm -f Main.swf
	rm -f ../build/$(APP-NAME).ipa
	rm -f ../build/$(APP-NAME).apk
	rm -f src/main/flex/Main.as
	rm -f src/main/resources/app-descriptor.xml
