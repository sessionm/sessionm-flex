# Build sessionm-actionscript.swc #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)
include ../Makefile.extversion

## Build rules and recipes
build: ../build/sessionm-actionscript.swc

../build/sessionm-actionscript.swc: src/main/flex/sessionm/flex/SessionM.as
	rm -f ../sessionm-ane/library.swf
	rm -f ../sessionm-ane/catalog.xml
	$(AIR-SDK)/bin/acompc -source-path src/main/flex/ \
	-include-classes sessionm.flex.ISessionM sessionm.flex.SessionM \
	sessionm.flex.ActivityType sessionm.flex.FallbackLogger \
	sessionm.flex.data.Achievement sessionm.flex.data.State \
	sessionm.flex.data.User sessionm.flex.data.UserAction \
	sessionm.flex.event.AchievementEvent \
	sessionm.flex.event.ActivityEvent \
	sessionm.flex.event.SessionEvent \
	sessionm.flex.event.UserEvent -output \
	../build/sessionm-actionscript.swc
	unzip ../build/sessionm-actionscript.swc -d ../sessionm-ane/
	cp ../build/sessionm-actionscript.swc ../sessionm-ane/default/sessionm.swc
	cp ../sessionm-ane/library.swf ../sessionm-ane/iPhone-ARM/library.swf 
	cp ../sessionm-ane/library.swf ../sessionm-ane/default/library.swf 
	cp ../sessionm-ane/library.swf ../sessionm-ane/Android-ARM/library.swf

src/main/flex/sessionm/flex/SessionM.as:
	sed -e 's/$$(EXT-VERSION)/$(EXT-VERSION)/g' src/main/flex/sessionm/flex/SessionM.as.in > src/main/flex/sessionm/flex/SessionM.as

clean:
	rm -f ../sessionm-ane/library.swf
	rm -f ../sessionm-ane/iPhone-ARM/library.swf
	rm -f ../sessionm-ane/default/library.swf
	rm -f ../sessionm-ane/Android-ARM/library.swf
	rm -f ../sessionm-ane/catalog.xml
	rm -f ../sessionm-ane/default/sessionm.swc
	rm -f ../build/sessionm-actionscript.swc
	rm -f src/main/flex/sessionm/flex/SessionM.as
