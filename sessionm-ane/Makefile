# Build sessionm.ane #

## Configuration
CONFIG_FILE = ../Makefile.config
include $(CONFIG_FILE)

## Build rules and recipes
sessionm.ane: 
	$(air-bin)/adt -package -target ane ../Build/sessionm.ane \
	extension.xml -swc ../Build/$(SWC) -platform iPhone-ARM -C \
	iPhone-ARM library.swf libsessionm-ios.a -platformoptions \
	iPhone-ARM/platform.xml -platform default -C default . -platform \
	Android-ARM -C Android-ARM .

clean:
	rm -R -f Build
	rm -R -f Logs

