*** Settings ***
Resource	    ../Script/Common.robot
Suite Setup	    SuiteSetup
Suite Teardown	    SuiteTeardown

*** Keywords ***

*** Test cases ***
Launch
    [tags]  RAT
    Launch By ReactNative
    Launch App
    Log Source    
