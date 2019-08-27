*** Settings ***
Library           Collections
Library           String
Library           OperatingSystem
Library           Screenshot
Resource	  ../Config/envConfig.robot
Resource          ../Config/Locator.robot
Resource	  ../Config/TestData.robot
Resource          ../Config/screenshot.robot
Resource	  Device.robot
Resource	  ViewOperation.robot
####Load By Different Platform
Resource          ../Config/${PLATFORM}/Config.robot
Resource          ${PLATFORM}/Machine.robot
Resource          ${PLATFORM}/Script.robot

*** Keywords ***
Start Appium
    Run Keyword If	'${PLATFORM}'=='iOS' and '${machine_type}'=='Real'	Start Webview Debug
    #force terminate appium first
    ${result} =  Run Process     lsof    -t  -i  tcp:4723
    Run Process     kill    -9  ${result.stdout}    

    Run Process   rm    -rf     ${APPIUM_LOG_FILE}
    #Run Process   export    "ANDROID_HOME=${ANDROID_SDK}"
    ${AppiumID} =   Start Process   appium  --address	127.0.0.1   --port  ${REMOTE_APPIUM_PORT}    --log-timestamp     --log   ${APPIUM_LOG_FILE}     --log-level     info   env:ANDROID_HOME=${ANDROID_SDK} 
    :FOR    ${i}    IN RANGE	1   999
    \	Sleep	6s
    \	${isRunning} =   Is Process Running  ${AppiumID}
    \	Exit For Loop If     ${isRunning} == True  

SuiteSetup
    Run Keyword If	"${machine_type}"=="Simulator"
    ...	    Boot Simulator Machine
    #Check is Boot Ready 
    Start Appium

CaseTeardown
    Quit Application

SuiteTeardown
    Close All Applications
    Run Keyword If	"${machine_type}"=="Simulator"
    ...	    Shutdown Simulator
    terminate All Processes    kill=True

