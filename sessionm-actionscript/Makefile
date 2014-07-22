# Build sessionm-actionscript.swc #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
build: ../build/sessionm-actionscript.swc

../build/sessionm-actionscript.swc: src/main/flex/ludia/sessionm/SessionM.as
	rm -f ../sessionm-ane/library.swf
	rm -f ../sessionm-ane/catalog.xml
	$(AIR-SDK)/bin/acompc -source-path src/main/flex/ \
	-include-classes ludia.sessionm.ISessionM ludia.sessionm.SessionM \
	ludia.sessionm.ActivityType ludia.sessionm.FallbackLogger \
	ludia.sessionm.data.Achievement ludia.sessionm.data.State \
	ludia.sessionm.data.User ludia.sessionm.data.UserAction \
	ludia.sessionm.event.AchievementEvent \
	ludia.sessionm.event.ActivityEvent \
	ludia.sessionm.event.SessionEvent \
	ludia.sessionm.event.UserEvent -output \
	../build/sessionm-actionscript.swc
	unzip ../build/sessionm-actionscript.swc -d ../sessionm-ane/
	cp ../sessionm-ane/library.swf ../sessionm-ane/iPhone-ARM/library.swf 
	cp ../sessionm-ane/library.swf ../sessionm-ane/default/library.swf 
	cp ../sessionm-ane/library.swf ../sessionm-ane/Android-ARM/library.swf

src/main/flex/ludia/sessionm/SessionM.as:
	sed -e 's/$$(EXT-VERSION)/$(EXT-VERSION)/g' src/main/flex/ludia/sessionm/SessionM.as.in > src/main/flex/ludia/sessionm/SessionM.as

clean:
	rm -f ../sessionm-ane/library.swf
	rm -f ../sessionm-ane/catalog.xml
	rm -f ../build/sessionm-actionscript.swc
	rm -f src/main/flex/ludia/sessionm/SessionM.as
