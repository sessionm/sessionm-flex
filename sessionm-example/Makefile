# Build Main.swf and SessionmAirExample #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build: iPhone android

iPhone: Main.swf
	cd src/main/flex
	$(AIR-SDK)/bin/adt -package -target ipa-test -keystore $(CERTIFICATE) \
	-storetype pkcs12 -provisioning-profile $(PROVISION) \
	../build/SessionmAirExample.ipa src/main/resources/app-descriptor.xml \
	Main.swf -extdir ../build

android: Main.swf androidCert.pfx
	cd src/main/flex
	$(AIR-SDK)/bin/adt -package -target apk-captive-runtime -keystore androidCert.pfx -storetype pkcs12 ../build/SessionmAirExample.apk src/main/resources/app-descriptor.xml Main.swf -extdir ../build

androidCert.pfx: 
	$(AIR-SDK)/bin/adt -certificate -validityPeriod 25 -cn SelfSigned 1024-RSA androidCert.pfx p

Main.swf:
	cd src/main/flex
	$(AIR-SDK)/bin/amxmlc src/main/flex/Main.as -include-libraries=../build/sessionm.ane -output Main.swf

clean:
	rm -f Main.swf
	rm -f androidCert.pfx
	rm -f ../build/SessionmAirExample.ipa
	rm -f ../build/SessionmAirExample.apk





