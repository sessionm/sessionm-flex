# Top level Makefile for SessionmAirExample.ipa #

## Configuration
CONFIG_FILE = Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
default : build
	$(MAKE) -C sessionm-actionscript
	$(MAKE) -C sessionm-ios/src/xcode
	$(MAKE) -C sessionm-ane
	$(MAKE) -C sessionm-example

build:
	mkdir build

clean:
	$(MAKE) -C sessionm-actionscript
	$(MAKE) -C sessionm-ios/src/xcode
	rm -f build/$(SWC)
	rm -f build/sessionm.ane
	rm -f build/SessionmAirExample.ipa
	rm -f sessionm-example/Main.swf
	rm -R -f build/*.tmp
	rm -R -f build/SessionM\ AIR\ Example.app.dSYM
	xcodebuild -workspace $(XCODE) -scheme sessionm-ios -configuration Release clean


