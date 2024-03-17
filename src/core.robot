*** Settings ***
Library                                                        SikuliLibrary
Library                                                        SeleniumLibrary
Library                                                        RequestsLibrary
Library                                                        FakerLibrary
Library                                                        OperatingSystem
Library                                                        Collections
Library                                                        String
Library                                                        pyhelpers/helpers.py

Resource                                                       request.robot
Resource                                                       keywords.robot
Resource                                                       helpers.robot
Resource                                                       main.robot

Variables                                                      ../resources/config.yaml
