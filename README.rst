======================
SessionM for Adobe AIR
======================

Unofficial Adobe AIR Native Extension for the SessionM SDKs (iOS & Android).
License: MIT

#####
Usage
#####

Please see http://air-sessionm.readthedocs.org/en/latest/#api-usage

##################
Build dependencies
##################

In order to build this extension, the following programs must be available:

* A copy of the Adobe AIR SDK (Tested with Adobe Air 14)
* XCode (Tested on XCode 5.1.1)
* Java JDK 6.0
* Android SDK (can be specified with ``android.sdk`` Java options)
* SessionM iOS and Android SDKs. Available for download from: http://www.sessionm.com/documentation/downloads.php
 
Create a Makefile.config file based on the provided Makefile.config.example. This includes setting your certificates for iOS and Android and your iOS mobile provisioning profile. If you do not have an iOS certificate or provisioning profile, follow the instructions for setting up the iOS development environment at https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ProvisioningDevelopment.html. If you do not have an Android certificate, you can create one by running ``make android-certificate`` in the top-level directory. 

In addition, run ``make config`` in the top-level directory to edit the following files, reflecting changes to settings such as the Adobe AIR SDK version and the application ID:
 
* sessionm-actionscript/src/main/flex/ludia/sessionm/SessionM.as
* sessionm-ane/extension.xml
* sessionm-ane/iPhone-ARM/platform.xml
* sessionm-example/src/main/flex/Main.as
* sessionm-example/src/main/resources/app-descriptor.xml

 
Otherwise it's a regular build process: ::
    make

When done: ::
    make clean

Note: The XCode build in sessionm-ios may fail the first time around after retrieving the repository with the following error:

xcodebuild: error: The workspace 'sessionm-ios' does not contain a scheme named 'sessionm-ios'.

A workaround is simply to load the  sessionm-ios/src/xcode/sessionm-ios.xcodeproj project in XCode and save it.

Note: There is also a known issue where the Android application loses focus after exiting from the rewards portal. The application can be brought back into focusing by pressing the  device's back button.
