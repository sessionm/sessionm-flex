###############################
 SessionM AIR Native Extension
###############################

The library can be added to your Maven POM file : ::

    <dependencies>
        [...]
        <dependency>
            <groupId>com.ludia.client</groupId>
            <artifactId>sessionm</artifactId>
            <version>${version}</version>
            <type>ane</type>
        </dependency>
    </dependencies>

where ``${version}`` is valid release number (current is |release|).

Under the hood, this extension uses the SessionM iOS SDK v1.9.3 and Android
SDK v1.8.1.

Source code is hosted at https://bitbucket.org/Ludia/air-sessionm.

===============
Getting started
===============

First you may want to read what `SessionM`_ is and how it will interact with
your application.

Then, you need to create or retrieve a developer account in order to access
the `Developer portal`_. Create one application per supported platform
(iOS and Android) and get their application IDs.

Finally, learn what `Custom achievements`_ are and create some for your
application.

.. _SessionM: http://www.sessionm.com/developers-publishers/
.. _Developer portal: https://developer.sessionm.com/
.. _Custom achievements: http://www.sessionm.com/documentation/achievement-placement.php

=======================
Integration in your app
=======================

AIR Descriptor
--------------

The following lines should be added in the ``<manifestAdditions>`` node of
your AIR descriptor.

.. code-block:: xml

    <manifest android:installLocation="auto">
        <!-- SessionM NOTE: These permissions are required for SessionM -->
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <!-- SessionM NOTE: These permissions are optional -->
        <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
        <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
        <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
        <uses-permission android:name="android.permission.READ_PHONE_STATE" />

        <uses-feature android:required="true" android:name="android.hardware.touchscreen.multitouch"/>
        <application android:enabled="true" android:debuggable="true" >
            <activity android:excludeFromRecents="false">
                <intent-filter>
                    <action android:name="android.intent.action.MAIN"/>
                    <category android:name="android.intent.category.LAUNCHER"/>
                </intent-filter>
            </activity>
            <activity android:theme="@android:style/Theme.Translucent"
                android:name="ludia.sessionm.PresentActivityActivity">
            </activity>
            <activity android:name="com.sessionm.ui.SessionMActivity"
                android:configChanges="keyboard|orientation|screenSize"
                android:theme="@android:style/Theme.Black.NoTitleBar.Fullscreen"
                android:windowSoftInputMode="adjustPan" >
           </activity>
           <receiver android:name="com.sessionm.api.ConnectionReceiver">
             <intent-filter>
               <action android:name="android.net.conn.CONNECTIVITY_CHANGE">
               </action>
             </intent-filter>
           </receiver>
        </application>
    </manifest>


API Usage
---------

Here is a quick explanation of how to use the ``SessionM`` class :

* First of all, check for ``SesionM.isSupported``
* Then, ou can construct a ``SessionM`` instance. At that point you should
  only try to call methods that don't require a session to be started, such as
  ``getSDKVersion()``, ``getExtensionVersion()`` or ``isSupportedPlatform()``.
* When required, call the ``startSession()`` method with your SessionM
  application ID.

.. warning:: This application ID is different on Android and iOS. Thus, you
             will need to check for the platform in order to pass the correct
             value. Not using the correct ID will not generate any error but
             will lead to missing functionality.

* Use methods such as ``presentActivity()`` and ``logAction()`` to finish
  SessionM integration within your application.

Please read through the example to see a concret usage of the extension.
You may also want to read the native SDKs `API References`_ to gain a better
understanding of what the extension is doing.

.. literalinclude:: ../../sessionm-example/src/main/flex/Main.as
    :start-after: /*doc-start
    :end-before: /*doc-end
    :append: }

.. _API References: http://www.sessionm.com/documentation/api-references.php
