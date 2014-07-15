# Build libsessionm-ios.a #

## Configuration
CONFIG_FILE = ../../../Makefile.config.example
include $(CONFIG_FILE)

## Build rules and recipes
build:
	xcodebuild -workspace sessionm-ios.xcodeproj/project.xcworkspace -scheme sessionm-ios -configuration Release build -derivedDataPath . OTHER_LDFLAGS="$(IOS-SDK)/libSessionM.1.11.4.a" HEADER_SEARCH_PATHS="$(IOS-SDK)/API"
	mkdir -p ../../../sessionm-ane/iPhone-ARM/
	cp build/Products/Release-iphoneos/libsessionm-ios.a ../../../sessionm-ane/iPhone-ARM/libsessionm-ios.a

clean:	
	xcodebuild -workspace sessionm-ios.xcodeproj/project.xcworkspace -scheme sessionm-ios -configuration Release clean	
	rm -R -f Build
	rm -R -f Logs
