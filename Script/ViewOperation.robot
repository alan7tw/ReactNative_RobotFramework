*** Settings ***
Library	    Customize.py

*** Keywords ***
Scroll Down Until Show 
    [Arguments]		${Target}
    Sleep   2s
    :FOR    ${i}    IN RANGE    30
    \	${State} =	Run Keyword And Return Status	Element Should Be Visible   ${Target}
    \	Exit For Loop If    ${State}==${TRUE}
    \	Scroll Down
    Element Should Be Visible   ${Target}

Scroll Up Until Show 
    [Arguments]		${Target}
    :FOR    ${i}    IN RANGE    30
    \	${State} =	Run Keyword And Return Status	Element Should Be Visible   ${Target}
    \	Exit For Loop If    ${State}==${TRUE}
    \	Scroll Up
    Element Should Be Visible   ${Target}

