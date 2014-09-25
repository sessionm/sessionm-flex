# Build libsessionm-ios.a #
ROOT = ../../..

## Configuration
CONFIG_FILE = $(ROOT)/Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build: $(ROOT)/sessionm-ane/iPhone-ARM/libsessionm-ios.a

# Note, this is for XCode 6, for XCode 5, change OTHER_LIBTOOLFLAGS to OTHER_LDFLAGS
$(ROOT)/sessionm-ane/iPhone-ARM/libsessionm-ios.a: sessionm-ios/*.h sessionm-ios/*.m
	xcodebuild -workspace sessionm-ios.xcodeproj/project.xcworkspace -scheme sessionm-ios -configuration Release -destination 'generic/platform=iOS' -derivedDataPath . build OTHER_LIBTOOLFLAGS="$(IOS-SDK)/libSessionM.$(IOS-SDK-VERSION).a" HEADER_SEARCH_PATHS="$(IOS-SDK)/API"
	mkdir -p $(ROOT)/sessionm-ane/iPhone-ARM/
	cp Build/Products/Release-iphoneos/libsessionm-ios.a $(ROOT)/sessionm-ane/iPhone-ARM/libsessionm-ios.a


clean:	
	xcodebuild -workspace sessionm-ios.xcodeproj/project.xcworkspace -scheme sessionm-ios -configuration Release -derivedDataPath .  clean	
	rm -R -f Build
	rm -R -f Logs
	rm -f $(ROOT)/sessionm-ane/iPhone-ARM/libsessionm-ios.a
