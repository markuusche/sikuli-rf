*** Settings ***
Resource                                            core.robot

*** Keywords ***
Launch Game
    [Documentation]                                 Connect to Portal
    ${URL}                                          Get Play URL
    ${options}                                      Evaluate
    ...                                             sys.modules['selenium.webdriver'].EdgeOptions()
    ...                                             sys, selenium.webdriver
    Call Method                                     ${options}   
    ...                                             add_argument    
    ...                                             InPrivate
    Create WebDriver                                Edge    
    ...                                             options=${options}
    Maximize Browser Window
    Go To                                           ${URL}
    Elements Should Exists on the Screen            live.png

GET Token
    [Documentation]                                 GET marshall token key
    ${headers}                                      Create Dictionary
    ...                                             %{Ops}=%{XOp}
    ...                                             %{querKey}=%{Xkey}
    
    ${res}                                          Get Request JSON    
    ...                                             %{base}%{desc}    
    ...                                             200
    ...                                             ${headers}
    RETURN                                          ${headers}
    ...                                             ${res}[data][token]  
    
Get Game Key
    [Documentation]                                 GET gamekey from user
    ${token}                                        GET Token
    ${headers}                                      Set To Dictionary
    ...                                             ${token}[0]
    ...                                             %{Tk}=${token}[1]
    
    ${data}                                         GET
    ...                                             url=%{base}%{key}?username=%{username}
    ...                                             expected_status=200
    ...                                             headers=${headers}
    RETURN                                          ${headers}
    ...                                             ${data.json()}
    
Get Play URL
    [Documentation]                                 Obtain Game URL
    ${gameKey}                                      Get Game Key
    ${data}                                         Get Request JSON    
    ...                                             %{base}%{play}?key=${gameKey}[1][data][key]    
    ...                                             200
    RETURN                                          ${data}[data][url]
    
Add Balance
    [Documentation]                                 Adds user balance
    [Arguments]                                     ${amount}
    ...                                             ${entry}
    ${fetch}                                        GET Token
    ${Id}                                           Generate random username
    ${header}                                       Create Dictionary
    ...                                             %{Tk}=${fetch}[1]
    ${body}                                         Create Dictionary
    ...                                             username=%{username}
    ...                                             balance=${amount}
    ...                                             action=${entry}
    ...                                             transferId=${Id}
    
    ${response}                                     POST
    ...                                             %{base}%{balance}
    ...                                             headers=${header}
    ...                                             data=${body}
    ...                                             expected_status=200
    RETURN                                          ${response.json()}[data][balance]
    
Modidy User Balance
    [Documentation]                                 Change user balance
    [Arguments]                                     ${amount}=1759.38
    ${getBalance}                                   Add Balance
    ...                                             ${amount}    
    ...                                             %{add}
    Add Balance                                     ${getBalance}
    ...                                             %{deduc}
    Add Balance                                     ${amount}    
    ...                                             %{add}
    
    Reload Page
    Wait Until Screen Contain                       ${EXECDIR}${ImagePath.Main}live.png
    ...                                             10
