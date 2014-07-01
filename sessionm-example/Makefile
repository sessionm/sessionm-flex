# Build Main.swf and SessionmAirExample.ipa #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
SessionmAirExample.ipa : | Main.swf
	cd src/main/flex
	$(air-bin)/adt -package -target ipa-test -keystore $(CERTIFICATE) \
	-storetype pkcs12 -provisioning-profile $(PROVISION) \
	../build/SessionmAirExample.ipa src/main/resources/app-descriptor.xml \
	Main.swf -extdir ../build

Main.swf : 
	cd src/main/flex
	$(air-bin)/amxmlc src/main/flex/Main.as -include-libraries=../build/sessionm.ane \
	-output Main.swf





