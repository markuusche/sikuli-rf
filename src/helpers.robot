*** Settings ***
Resource                                                    core.robot

*** Keywords ***
Get Request JSON
    [Documentation]                                         API Request for Get Data
    [Arguments]                                             ${url}
    ...                                                     ${expected_status}
    ...                                                     ${headers}=${EMPTY}
    ${headers}                                              Create Dictionary
    ...                                                     x-operator=%{XOp}
    ...                                                     x-key=%{Xkey}
    ${response}                                             GET
    ...                                                     ${url}
    ...                                                     expected_status=${expected_status}
    ...                                                     headers=${headers}
    RETURN                                                  ${response.json()}
    
Elements Should Exists on the Screen
	[Documentation]                                         Check if elements exists on the screen
	[Arguments]                                             @{elements}
	FOR    ${element}                                       IN          @{elements}
		${status}                                           Run Keyword and Return Status                                                      
        ...                                                 Wait Until Screen Contain
        ...                                                 ${EXECDIR}${ImagePath.Main}${element}                                                 
        ...                                                 80
	END

Image Should Exists on the Screen
	[Documentation]                                         Check if elements exists on the screen
	[Arguments]                                             @{elements}
	FOR    ${element}                                       IN          @{elements}
        Set Min Similarity                                  0.90
		${status}                                           Run Keyword and Return Status                                                       
        ...                                                 Wait Until Screen Contain
        ...                                                 ${EXECDIR}${ImagePath.Main}${element}                                            
        ...                                                 60
	END

Wait Until Visible
    [Documentation]                                         Waits until Betting opens for Betting Area
    [Arguments]                                             ${text}
    ${betting}=                                             Set Variable                                                                        
    ...                                                     False
    Sleep                                                   7s
    WHILE    not ${betting}
        ${contains}                                         Get Digital Message Text                                                                          
        ...                                                 ${text}
        ${betting}=                                         Set Variable If                                                                     
        ...                                                 ${contains}
        ...                                                 True
    END

Wait Betting Timer CLOSED
    [Documentation]                                         Waits until Betting opens for Betting Area
    WHILE    True
        ${image}                                            Run Keyword And Return Status
        ...                                                 Wait Until Screen Contain                               
        ...                                                 ${EXECDIR}${ImagePath.Main}result.png    
        ...                                                 
        
        IF    ${image}
            BREAK
        END
    END

Get Digital Message Text
    [Documentation]                                         Get the string from screen region
    [Arguments]                                             ${text}
    ${result}=                                              Read Text From Region                                                              
    ...                                                     ${InGame}[digitalmsg]

    ${contains}=                                            Run Keyword And Return Status
    ...                                                     Should Contain    
    ...                                                     ${result}
    ...                                                     ${text}
    
    RETURN                                                  ${contains}
