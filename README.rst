======================
SessionM for Adobe AIR
======================

Unofficial Adobe AIR Native Extension for the SessionM SDKs (iOS & Android).
License : MIT

#####
Usage
#####

Please see http://air-sessionm.readthedocs.org/en/latest/#api-usage

##################
Build dependencies
##################

In order to build this extension, the following programs must be available :

* A copy of the Adobe AIR SDK (Tested with Adobe Air 14)
* XCode (Tested on XCode 5.1.1)
* Android SDK (can be specified with ``android.sdk`` Java options)
* SessionM iOS and Android SDK. Available for download from: http://www.sessionm.com/documentation/downloads.php
 
Edit the provided Makefile.config, including setting your iOS certificate and mobile provision profile. In addition, the following files must be edited to reflect changes to settings such as the Adobe AIR SDK version and the application ID:
 
* sessionm-ane/extension.xml 
* sessionm-ane/iPhone-ARM/platform.xml 
* sessionm-example/src/main/resources/app-descriptor.xml
 
Otherwise it's a regular build process : ::
    make

When done: ::
    make clean

Note: The XCode build in sessionm-ios may fail the first time around after retriving the repository with the following error:

xcodebuild: error: The workspace 'sessionm-ios' does not contain a scheme named 'sessionm-ios'.

A workaround is simply to load the  sessionm-ios/src/xcode/sessionm-ios.xcodeproj project in XCode and save it.
