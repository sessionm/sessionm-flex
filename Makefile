# Build LudiaTest.ipa

## Variables
air-bin = ~/Downloads/air14_sdk_mac/bin
APP_DESC = sessionm-example/src/main/resources/app-descriptor.xml
ANE_DIR = META-INF/ANE
FLEX = sessionm-example/src/main/flex
MAIN_SWF = Main.swf
CERT = $(FLEX)/Certificates.p12
PROV = $(FLEX)/Ludia_Test_Profile.mobileprovision

## Build rules and recipe
LudiaTest.ipa : | $(MAIN_SWF)
	cd $(FLEX)
	$(air-bin)/adt -package -target ipa-test -keystore $(CERT) \
	-storetype pkcs12 -provisioning-profile $(PROV) \
	LudiaTest.ipa $(APP_DESC) $(MAIN_SWF) -extdir $(ANE_DIR)

$(MAIN_SWF) :
	$(MAKE) -C $(ANE_DIR)
	cd $(FLEX)
	$(air-bin)/amxmlc $(FLEX)/Main.as -include-libraries=$(ANE_DIR)/ludiaTest.ane \
	-output $(MAIN_SWF)

clean :
	rm -f LudiaTest.ipa
	rm -f Main.swf
	rm -f META-INF/ANE/library.swf
	rm -f META-INF/ANE/catalog.xml
	rm -f META-INF/ANE/default/*.swc

