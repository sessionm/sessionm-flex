# Build ludiaTest.ane

## Variables
air-bin = ~/Downloads/air14_sdk_mac/bin
ANE_DIR = .
IPHONE = $(ANE_DIR)/iPhone-ARM
IOS_LIB = libsessionm-ios.a
SWF = library.swf
ANDROID = $(ANE_DIR)/Android-ARM
DEFAULT = $(ANE_DIR)/default
VERSION = 1.0.1
SWC = $(DEFAULT)/sessionm-actionscript-$(VERSION).swc
XCODE = ../../sessionm-ios/src/xcode/sessionm-ios.xcodeproj/project.xcworkspace

## Build rules and recipes
ludiaTest.ane : | $(SWC) $(SWF) $(IOS_LIB)
	$(air-bin)/adt -package -target ane ludiaTest.ane \
	$(ANE_DIR)/extension.xml -swc $(SWC) -platform iPhone-ARM -C \
	$(IPHONE) $(SWF) $(IOS_LIB) -platformoptions \
	$(IPHONE)/platform.xml -platform default -C $(DEFAULT) . -platform \
	Android-ARM -C $(ANDROID) .

$(SWC) :
	$(air-bin)/acompc -source-path ../../sessionm-actionscript/src/main/flex/ \
	-include-classes ludia.sessionm.ISessionM ludia.sessionm.SessionM \
	ludia.sessionm.ActivityType ludia.sessionm.FallbackLogger \
	ludia.sessionm.data.Achievement ludia.sessionm.data.State \
	ludia.sessionm.data.User ludia.sessionm.data.UserAction \
	ludia.sessionm.event.AchievementEvent \
	ludia.sessionm.event.ActivityEvent \
	ludia.sessionm.event.SessionEvent \
	ludia.sessionm.event.UserEvent -output \
	sessionm-actionscript-$(VERSION).swc
	cp sessionm-actionscript-$(VERSION).swc $(SWC)


$(SWF) : | $(SWC)
	unzip $(SWC)
	cp library.swf $(IPHONE)/library.swf 
	cp library.swf $(DEFAULT)/library.swf 
	cp library.swf $(ANDROID)/library.swf

$(IOS_LIB) :
	xcodebuild -workspace $(XCODE) -scheme sessionm-ios -configuration Release clean
	xcodebuild -workspace $(XCODE) -scheme sessionm-ios -configuration Release build \
	-derivedDataPath .
	cp BUILD/PRODUCTS/Release-iphoneos/libsessionm-ios.a $(IPHONE)/libsessionm-ios.a

