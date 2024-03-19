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
            ${tableExist}                                           Run Keyword And Return Status
            ...                                                     Wait Until Screen Contain
            ...                                                     ${tables}\\${elements}
            ...                                                     5
            IF        ${tableExist}
                Set Min Similarity                                  0.86
                Click                                               ${tables}\\${elements}
                BREAK
            ELSE
                Click Region                                        ${Lobby}[center]
                Wheel Down                                          6
                IF    ${count} > 9
                    Skip                                            Table ${elements} was not found.
                    ${count}                                        Evaluate    
                    ...                                             ${count}+1
                END
            END
        END    
            ${table}                                                Evaluate    
            ...                                                     "${elements}".split('.png')[0]
            Wait Until Betting Opens
            Bet All-in                                              ${table}
            Capture Page Screenshot
            Click                                                   ${EXECDIR}${ImagePath.Main}home.png
            Wait Until Screen Contain                               ${EXECDIR}${ImagePath.Main}live.png
            ...                                                     15
    END
    
Bet All-in
    [Documentation]                                                 Betting All-in
    [Arguments]                                                     ${table}
    FOR    ${counter}    IN RANGE    1000
        Set Move Mouse Delay                                        0.0
        Run Keyword                                                 Bet On Region
        ${contains}                                                 Get Digital Message Text
        ...                                                         Insufficient Balance!
        IF    ${contains}
            Click Region                                            ${Buttons}[confirm]
            Sleep                                                   2.5s
            ${data}                                                 Read Text From Region
            ...                                                     ${InGame}[balance]
            Validate Region                                         ${table}  
            ...                                                     ${data}   
            ...                                                     0.00
            ...                                                     All-in Bet ${data}

            ${status}                                               Run Keyword And Return Status
            ...                                                     Wait Until Screen Contain
            ...                                                     ${EXECDIR}${ImagePath.Main}result.png
            ...                                                     30

            IF    ${status}
                Wait Until Digital Results
                BREAK
            END             
        END
    END
