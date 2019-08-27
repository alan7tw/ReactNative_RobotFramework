*** Settings ***
Library     ../../Script/Customize.py

*** Keywords ***
Clear Text
    [Arguments]	    ${locator}
    Input Text  ${locator}	\

    ${result} =	    Run Keyword And Return Status   Element Should Be Visible	accessibility_id=delete    
    Run Keyword If  ${result}==${True}	    Long Press	    accessibility_id=delete	5000
    ${result} =	    Run Keyword And Return Status   Element Should Be Visible	accessibility_id=Delete    
    Run Keyword If  ${result}==${True}	    Long Press	    accessibility_id=Delete	5000

Start Webview Debug
    ${id} =	    Start Process	    ios_webkit_debug_proxy  -c	${UDID}:27753

Hide Keyboard
    Click Position  350	    300

Scroll Up
    Swipe	200	250	200	500	300

Scroll Down
    Swipe       200     500    200     250    300

Scroll horizontal
    Swipe       100     300     300     300     300
