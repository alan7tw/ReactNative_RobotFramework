*** Settings ***
Library     ../../Script/Customize.py

*** Keywords ***
### View Operation
Scroll Up
    Swipe	500	1000	500	1300	300

Scroll Down
    Swipe       500     1300    500     1000    300

Scroll horizontal
    Swipe       900     750     200     750     300
