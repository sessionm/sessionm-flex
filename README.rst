======================
SessionM for Adobe AIR
======================

Unofficial Adobe AIR Native Extension for the SessionM SDKs (iOS & Android).
License : MIT

##################
Build dependencies
##################

In order to build this extension, the following programs must be available :

* XCode 5.0.2 (requires MacOSX 10.8+)
* CocoaPods (gem install cocoapods)
* Android SDK (can be specified with ``android.sdk`` Java options)
* Maven 3.0.5

With the current configuration, the project can only be built from inside
Ludia, as it depends on various artifacts only deployed inside our internal
Nexus repository. You will need to deploy these artifacts before being able
to build the project. The downloads section contains the final ANE file that
you can use freely.

Otherwise it's just a regular Maven build : ::

    mvn install
