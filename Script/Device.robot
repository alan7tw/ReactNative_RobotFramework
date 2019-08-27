*** Settings ***
Library	    Customize.py

*** Keywords ***
Relaunch App
    Quit Application
    Launch App       

Quit Browser
    Switch Application  Browser
    Quit Application

Launch App If Need
    ${state} =	Get Variable Value	${Ever_Start}
    Run Keyword If	${state} == None    Run Keywords     
    ...     Launch App
    ...     AND     Set Suite Variable      ${Ever_Start}       ${TRUE}
    ${State}	${Value}	Run Keyword And Ignore Error	    Get Contexts
    Run Keyword If  '${State}' == 'FAIL'	Run Keywords
    ...	    Launch App
    ...	    AND	    Sleep   5s

