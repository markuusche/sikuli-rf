*** Settings ***
Resource                                                            core.robot

*** Keywords ***
Start Playing
    [Documentation]                                                 Game Start here
    [Arguments]                                                     ${category}
    Log To Console                                                  \n==============================================================================
    ${tables}                                                       Set Variable
    ...                                                             ${EXECDIR}${ImagePath.Table}\\${category}
    Click                                                           ${EXECDIR}${ImagePath.Nav}\\${category}.png
    ${items}                                                        List Files In Directory
    ...                                                             ${tables}

    FOR    ${elements}    IN    @{items}
        Modidy User Balance
        ${count}                                                    Evaluate
        ...                                                         0

        WHILE    True
            Set Move Mouse Delay                                    0.5
            Set Min Similarity                                      0.86
            ${tableExist}                                           Run Keyword And Return Status
            ...                                                     Wait Until Screen Contain
            ...                                                     ${tables}\\${elements}
            ...                                                     1.5
            IF        ${tableExist}
                Click                                               ${tables}\\${elements}
                ${table}                                            Evaluate
                ...                                                 "${elements}".split('.png')[0]
                Sleep                                               7s
                Wait Until Message                                  Place
                Bet All-in                                          ${table}
                Capture Page Screenshot
                Click                                               ${EXECDIR}${ImagePath.Main}home.png
                Set Min Similarity                                  0.7
                Wait Until Screen Contain                           ${EXECDIR}${ImagePath.Main}live.png
                ...                                                 15
                BREAK
            ELSE
                Click Region                                        ${Lobby}[center]
                Wheel Down                                          6
                IF    ${count} > 5
                    ${FAILED}                                       Evaluate
                    ...                                             "\\033[91mFAILED\\033[0m"
                    ${table}                                        Evaluate
                    ...                                             "${elements}".split('.png')[0]
                    Log To Console                                  ${FAILED} Table: ${table} was not found.
                    BREAK
                END
                ${count}                                            Evaluate
                ...                                                 ${count}+1
            END
        END

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
