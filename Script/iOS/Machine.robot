*** Settings ***
Library           Collections
Library           Process
Library           String

*** Keywords ***
#### App Operation ####
Launch App
    Open Application	${REMOTE_APPIUM_SERVER}   alias=IDSafe      platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    udid=${UDID}    app=${App}    useNewWDA=${TRUE}    automationName=${AUTOMATION_NAME}	xcodeConfigFile=../.xcconfig	newCommandTimeout=120	waitForQuiescence=${FALSE}  wdaEventloopIdleDelay=3

Launch Browser
    Open Application	${REMOTE_APPIUM_SERVER}   alias=Browser     platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    udid=${UDID}    browserName=Safari

Launch Settings
    [Arguments]	    ${name}=.Settings
    Open Application	${REMOTE_APPIUM_SERVER}   platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    udid=${UDID}    app=Settings    useNewWDA=${TRUE}    automationName=${AUTOMATION_NAME}
    
#### Machine Operation ####
Shutdown Simulator
    Run Process   xcrun     simctl  shutdown    ${UDID} 

Clean Simulator Machine
    Run Process   xcrun     simctl  shutdown   ${UDID}  
    Sleep   10s
    Run Process   xcrun     simctl  erase   ${UDID}  

Uninstall Build
    Run Keyword If  "${machine_type}"=="Simulator"  Run Process   xcrun     simctl  uninstall   ${UDID}     ${APP}
    ...	    ELSE IF	"${machine_type}"=="Real"	    Run Process	  ios-deploy	--id	${UDID}	    --uninstall_only	--bundle_id	${APP}

Install Build
    [Arguments]    ${BUILD_PATH}
    
    Run Process	 ideviceinstaller   -i	${BUILD_PATH}
    ${Result} =     Run Process     ideviceinstaller    -l      |   grep    ${APP}      shell=True
    Should Not Be Equal     '${Result.stdout}'      ''       Install Fail

Install Simulator Machine
    Run Process   xcrun     simctl  install    ${UDID}  ${BuildPosition}
    Sleep   ${SLEEP_1}

Boot Simulator Machine
    #Clean Simulator Machine
    Run Process   xcrun     simctl  boot    ${UDID}  
    Run Process   open      ${SimulatorPosition}
    Sleep   10s

Check is Boot Ready
    Log	    'Just By Pass'

Reset Simulator
    Clean Simulator Machine
    Boot Simulator Machine
    Install Simulator Machine

#### React Native ####

Launch By ReactNative
    Log	    ${machine_type}
    ${result} =	    Run Process	    ps	aux	|   grep    [c]li.js start	|   awk	    \'{print \$2}]\'	    shell=True
    Run Process	    kill    -9	    ${result.stdout}
    Run Keyword If  "${machine_type}"=="Real"	Run Process	    react-native    run-ios	--udid	${UDID}	    --configuration	Release    cwd=${Source_Path}    	stdout=./stdout.txt	
    ...		ELSE IF    "${machine_type}"=="Simulator"  	    Run Process	    react-native    run-ios	--simulator	${DEVICE_NAME}	    --configuration	Release    cwd=${Source_Path}    stdout=./stdout.txt

Resume React
    Log     Just By Pass


