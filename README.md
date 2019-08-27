# ReactNative_RobotFramework

for Testing **React-Native** App on **Robot Framework** with **Python**

requirement
-----------
1. node
> Appium : 
><code>npm install -g appium </code>
2. python
> appium Client :
> <code>pip install Appium-Python-Client </code>
> robotframework :
> <code>pip install robotframework </code>
> robotframework-appiumlibrary :
> <code>pip install robotframework-appiumlibrary </code>
> robotframework-requests :
> <code>pip install robotframework-requests </code>

\* for support iOS real machine , please install following library with brew with latest version
> ideviceinstaller
> libimobiledevice
> usbmuxd
> ios-webkit-debug-proxy

make sure you can execute following command
<code>idevicename</code>
<code>idevice_id -l</code>

configuration
-------------
before you start testing , please modify config in **Config/**

> **Android**
<code>Config/Android/Config.robot</code>

| Variable | Type |  Desc |
|---|---|---|
|DEVICE_NAME|String|Target Andorid Device Name ,for Simulator , use <code>emulator -list-avds</code> to check device name , for real machine , use <code>adb device</code>|
|APP_ACTIVITY|String|Target App MainActivity Name|
|APP_PACKAGE|String| Target App Package Name|

> **iOS**
<code>Config/iOS/Config.robot</code>

| Variable | Type |  Desc |
|---|---|---|
|DEVICE_NAME|String|Target iOS Deivce Name, Simulator:<code>xcrun simctl list</code> ,real:<code>idevicename</code> |
|APP |String| Target App Bundle Identity|

> **envConfig.robot**

| Variable | Type |  Desc |
|---|---|---|
|Source_Path|String|the path to react native source

Start Testing 
-------------
- for Android: <code> robot --variable PLATFORM:Android Testcase/launch.robot</code>
- for iOS: <code> robot --variable PLATFORM:iOS Testcase/launch.robot</code>


----
if you encounter any issue , send me mail: alan_hsueh@trendmicro.com

