# Build sessionm-actionscript.swc #

## Configuration
CONFIG_FILE = ../Makefile.config.example
include $(CONFIG_FILE)

## Build rules and recipes
$(SWC):
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
	../build/$(SWC)
	unzip ../Build/$(SWC) -d ../sessionm-ane/
	cp ../sessionm-ane/library.swf ../sessionm-ane/iPhone-ARM/library.swf 
	cp ../sessionm-ane/library.swf ../sessionm-ane/default/library.swf 
	cp ../sessionm-ane/library.swf ../sessionm-ane/Android-ARM/library.swf

clean:
	rm -f ../sessionm-ane/library.swf
	rm -f ../sessionm-ane/catalog.xml

