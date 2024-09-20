*** Settings ***
Resource                                                    core.robot

*** Keywords ***
Generate random username
    [Documentation]                                         Generates random username
    ${username}                                             FakerLibrary.User Name
    ${number}                                               FakerLibrary.Random Digit Above Two
    RETURN                                                  ${username}${username}${number}

Assert
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
        Log To Console                                      ${PASSED} Table: ${table} - ${message}
    ELSE
        Log To Console                                      ${FAILED} Table: ${table} - ${message}
    END

Bet All-in
    [Documentation]                                                 Betting All-in
    [Arguments]                                                     ${table}
    WHILE    True
        Set Move Mouse Delay                                        0.0
        Run Keyword                                                 Bet On Region
        ${contains}                                                 Get Digital Message Text
        ...                                                         Insufficient Balance!
        ...                                                         ${InGame}[digitalmsg]
        IF    ${contains}
            Click Region                                            ${Buttons}[confirm]
            Sleep                                                   2.5s
            ${data}                                                 Read Text From Region
            ...                                                     ${InGame}[balance]
            Assert                                                  ${table}
            ...                                                     ${data}
            ...                                                     0.00
            ...                                                     All-in Bet ${data}

            Wait Until Message                                      Place
            BREAK
        END
    END
    
Chat Functionality
    [Documentation]                                                  Chatbox and Emojis Execution
    Click Region                                                     ${InGame}[chat-input]
    ${text}                                                          FakerLibrary.Paragraph
    Send Keys                                                        ${text}
    Press Special Key                                                ENTER
    Click Region                                                     ${InGame}[follow]    
    Click Region                                                     ${InGame}[follow]
    Click Region                                                     ${InGame}[emoji icon]
    ${emojis}                                                        Set Variable
    ...                                                              ${InGame}[emojis]

    ${item}                                                          Evaluate
    ...                                                              random.choice(${emojis})
    Click Region                                                     ${item}
    
Sidebet Checking
    [Documentation]                                                  To check if surfing sidebet does not freeze the UI
    Click Region                                                     ${InGame}[sidebet panel]
    Wait Until Screen Contain                                        ${EXECDIR}${ImagePath.Main}goodtips.png
    ...                                                              10
    Sleep                                                            2s

    ${sidebet tabs}                                                  Set Variable
    ...                                                              ${InGame}[sidebet]

    FOR    ${item}    IN    @{sidebet tabs}
        Click Region                                                 ${item}
        Sleep                                                        1.5s
    END
    