*** Settings ***
Resource                                  core.robot

Suite Setup                               Run Keywords
...                                       Launch Game
...    AND                                Start Sikuli Process

Suite Teardown                            Close All Browsers