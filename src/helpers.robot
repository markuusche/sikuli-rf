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
	FOR    ${element}    IN    @{elements}
		${status}                                           Run Keyword and Return Status                                                      
        ...                                                 Wait Until Screen Contain
        ...                                                 ${EXECDIR}${ImagePath.Main}${element}                                                 
        ...                                                 80
	END

Wait Until Betting Opens
    [Documentation]                                         Waits until Betting opens for Betting Area
    ${betting}=                                             Set Variable                                                                       
    ...                                                     False
    Sleep                                                   7s
    WHILE    not ${betting}
        ${result}=                                          Read Text From Region                                                               
        ...                                                 ${InGame}[digitalmsg]
        ${contains}=                                        Run Keyword And Return Status                                                       
        ...                                                 Should Contain
        ...                                                 ${result}                                                                           
        ...                                                 Place
        ${betting}=                                         Set Variable If                                                                     
        ...                                                 ${contains}
        ...                                                 True
    END

Wait Until Digital Results
    [Documentation]                                         Waits until digital results
    WHILE    True
        ${result}                                           Read Text From Region                                                              
        ...                                                 ${InGame}[result]
        
        ${texts}                                            Create List
        ...                                                 WIN
        ...                                                 TIE

        ${win}                                              Run Keyword And Return Status
        ...                                                 Should Contain Any  
        ...                                                 ${result}
        ...                                                 @{texts}
        
        IF    ${win}
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
