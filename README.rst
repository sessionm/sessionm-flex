======================
SessionM for Adobe AIR
======================

Adobe AIR Native Extension for the SessionM SDKs (iOS & Android).
License: MIT

Based on an initial version created by Ludia, inc. and available at: http://air-sessionm.readthedocs.org/en/latest/

#####
Usage
#####

Please see  http://www.sessionm.com/documentation/adobeair-integration.php

Full online API documentation is also available at  http://devdoc.sessionm.com/adobeair/index.html

##################
Build dependencies
##################

In order to build this extension, the following programs must be available:

* A copy of the Adobe AIR SDK (Tested with Adobe Air 14)
* XCode (Tested on XCode 5.1.1)
* Java JDK 6.0
* Android SDK (can be specified with ``android.sdk`` Java options)
* SessionM iOS and Android SDKs. Available for download from: http://www.sessionm.com/documentation/downloads.php

Note:
    The suggested version for developers using Adobe Flash Builder is Flash Builder 4.7. There is a bug in Flash Builder 4.6 where the compiler warns about not being able to find the SessionM class after linking the extension.
 
Create a Makefile.config file based on the provided Makefile.config.example. This includes setting your certificates for iOS and Android and your iOS mobile provisioning profile. 

If you do not have an iOS certificate or provisioning profile, follow the instructions for setting up the iOS development environment at https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ProvisioningDevelopment.html. 

If you do not have an Android certificate, follow the instructions for the Android application signing process at http://developer.android.com/tools/publishing/app-signing.html, or create a default certificate by running ``make android-certificate`` in the top-level directory. 

Once you have finished editing your Makefile.config, running ``make`` in the top-level directory will reflect the changes made to settings such as the Adobe AIR SDK version and the application ID.

 
Otherwise it's a regular build process:
    make

When done:
    make clean

The following files are created during the build process and can be found in the build directory:

* The Adobe AIR native extension package (sessionm.ane)
* The ActionScript library (sessionm-actionscript.swc)
* The Android & iOS sample applications (SessionmAirExample.apk & SessionmAirExample.ipa)

Note:
    The XCode build in sessionm-ios may fail the first time around after retrieving the repository with the following error: "xcodebuild: error: The workspace 'sessionm-ios' does not contain a scheme named 'sessionm-ios'."

A workaround is simply to load the  sessionm-ios/src/xcode/sessionm-ios.xcodeproj project in XCode and save it.
