*** Settings ***
Resource                                                    core.robot

*** Keywords ***
Generate random username
    [Documentation]                                         Generates random username
    ${username}                                             FakerLibrary.User Name                               
    ${number}                                               FakerLibrary.Random Digit Above Two 
    RETURN                                                  ${username}${username}${number}

Validate Region
    [Documentation]                                         Check if the data if correct?
    [Arguments]                                             ${table}
    ...                                                     ${data}
    ...                                                     ${second}
    ...                                                     ${message}
    ${PASSED}                                               Evaluate    
    ...                                                     "\\x1b[32mPASSED\\033[0m"
    ${FAILED}                                               Evaluate
    ...                                                     "\\033[91mFAILED\\033[0m"

    ${result}                                               Run Keyword And Return Status
    ...                                                     Should Be Equal   
    ...                                                     ${data}    
    ...                                                     ${second}
    
    IF    ${result}
        Log To Console                                      [${PASSED}] Table: ${table} - ${message}
    ELSE
        Log To Console                                      [${FAILED}] Table: ${table} - ${message}
    END
