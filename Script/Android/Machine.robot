*** Settings ***
Library           Collections
Library           Process
Library           String

*** Variables ***
${Retry_Limit}			5

*** Keywords ***
#### App Operation ####
Launch App
    Open Application	${REMOTE_APPIUM_SERVER}   alias=IDSafe    platformName=${PLATFORM_NAME}  deviceName=${DEVICE_NAME}  appActivity=${APP_ACTIVITY}	appPackage=${APP_PACKAGE}   noReset=${TRUE}  automationName=${AUTOMATION_NAME}	useNewWDA=${TRUE}   newCommandTimeout=120

Launch Browser
    [Arguments]	    ${browserName}=Chrome
    Open Application	${REMOTE_APPIUM_SERVER}   alias=Browser     platformName=${PLATFORM_NAME}  deviceName=${DEVICE_NAME}  browserName=${browserName}   noReset=${TRUE}

Launch Settings 
    [Arguments]	    ${name}=.Settings
    Open Application	${REMOTE_APPIUM_SERVER}   platformName=${PLATFORM_NAME}  deviceName=${DEVICE_NAME}  appActivity=${name}	appPackage=com.android.settings   noReset=${TRUE}  automationName=${AUTOMATION_NAME}	useNewWDA=${TRUE}   newCommandTimeout=120
    
#### Machine Operation ####
Shutdown Simulator
    Run Process   ${ANDROID_SDK}/platform-tools/adb    emu     kill
    Check is Shutdown

Uninstall Build
    Run Process   ${ANDROID_SDK}/platform-tools/adb  uninstall  ${APP_PACKAGE}

Install Build
    [Arguments]    ${BUILD_PATH}
    ${Result} =     Run Process   ${ANDROID_SDK}/platform-tools/adb  install    ${BUILD_PATH}
    Should Be Equal     '${Result.stdout}'    'Success'     Install Fail

Check is Shutdown
    ${State} =     Get machine State 
    Log     ${State}
    Run Keyword If  "${State}"!="None"     Run Keywords
    ...     Sleep   2s
    ...     AND     Check is Shutdown

Get machine State 
    ${Result} =     Run Process   ${ANDROID_SDK}/platform-tools/adb    devices
    @{Lines} = 	Split String	${Result.stdout}    ${\n}
    Log     ${Lines[1]}
    ${len} =    Get Length  ${Lines[1]}
    Log     ${len}
    @{words} = 	Split String	${Lines[1]} 
    ${State} =  Set Variable If     ${len}!=0   ${words[1]}     
    [return]  ${State}

Check is Boot Ready 
    [Arguments]   ${retry}=0
    ${State} =     Get machine State 
    Log     ${State}
    Run Keyword If     "${State}"!="device" and ${retry}<${Retry_Limit}     Run Keywords
    ...     Sleep   10s 
    ...     AND     Check is Boot Ready	    ${retry}+1

Boot Clean Machine 
    ${emulatorID} =   Start Process   ${ANDROID_SDK}/emulator/emulator    -avd    ${DEVICE_NAME}     -wipe-data
    ${isRunning} =   Is Process Running  ${emulatorID}
    Run Keyword If     ${isRunning} == False  Boot Simulator Machine

Boot Simulator Machine
    ${emulatorID} =   Start Process   ${ANDROID_SDK}/emulator/emulator    -avd    ${DEVICE_NAME}    
    ${isRunning} =   Is Process Running  ${emulatorID}
    Run Keyword If     ${isRunning} == False  Boot Simulator Machine

Reset Simulator
    Boot Simulator Machine
    Install Build

#### React Native ####
Launch By ReactNative
    ${result} =	    Run Process	    ps	aux	|   grep    [c]li.js start	|   awk	    \'{print \$2}]\'	    shell=True
    Run Process	    kill    -9	    ${result.stdout}
    ${Result} =	    Run Process	    react-native    run-android    cwd=${Source_Path}
    Log	    ${Result.stdout}


Resume React
    Run Process	    ${ANDROID_SDK}/platform-tools/adb	shell	input	keyevent    63
    Sleep   1s
    Click Position   100    100

