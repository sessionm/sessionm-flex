# Build libsessionm-ios.a #
ROOT = ../../..

## Configuration
CONFIG_FILE = $(ROOT)/Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build: libsessionm-ios.a

libsessionm-ios.a:
	xcodebuild -workspace sessionm-ios.xcodeproj/project.xcworkspace -scheme sessionm-ios -configuration Release build -derivedDataPath . OTHER_LDFLAGS="$(IOS-SDK)/libSessionM.$(IOS-SDK-VERSION).a" HEADER_SEARCH_PATHS="$(IOS-SDK)/API"
	mkdir -p $(ROOT)/sessionm-ane/iPhone-ARM/
	cp build/Products/Release-iphoneos/libsessionm-ios.a $(ROOT)/sessionm-ane/iPhone-ARM/libsessionm-ios.a

clean:	
	xcodebuild -workspace sessionm-ios.xcodeproj/project.xcworkspace -scheme sessionm-ios -configuration Release clean	
	rm -R -f Build
	rm -R -f Logs
	rm -f $(ROOT)/sessionm-ane/iPhone-ARM/libsessionm-ios.a
