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

Get Digital Message Text
    [Documentation]                                         Get the string from screen region
    [Arguments]                                             ${text}
    ...                                                     ${region}
    ${result}=                                              Read Text From Region
    ...                                                     ${region}

    ${contains}=                                            Run Keyword And Return Status
    ...                                                     Should Contain
    ...                                                     ${result}
    ...                                                     ${text}

    RETURN                                                  ${contains}
