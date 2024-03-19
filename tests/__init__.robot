*** Settings ***
Resource                                  core.robot

Suite Setup                               Run Keywords
...                                       Start Sikuli Process
...    AND                                Launch Game
...    AND                                Set Screenshot Directory    results

Suite Teardown                            Close All Browsers