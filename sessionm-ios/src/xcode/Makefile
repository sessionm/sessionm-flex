# Build sessionm.ane #

## Configuration
CONFIG_FILE = ../../../Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build:
	xcodebuild -workspace ../../../$(XCODE) -scheme sessionm-ios -configuration \
	Release build -derivedDataPath .
	#cp Build/Products/Release-iphoneos/libsessionm-ios.a iPhone-ARM/libsessionm-ios.a
	mkdir -p ../../../sessionm-ane/iPhone-ARM/
	cp build/Products/Release-iphoneos/libsessionm-ios.a ../../../build/iPhone-ARM/libsessionm-ios.a


clean:	
	rm -R -f build
	rm -R -f Logs