*** Settings ***
Library    RPA.Robocorp.Vault
Library    RPA.FileSystem

*** Variables ***
${URL}      %{WEBSITE_URL}

*** Tasks ***
Minimal task
    ${secret}=    Get Secret    default
    Log    ${URL}
    Log    ${secret}[WEBSITE_URL]
    ${output}    Set Variable    This is the data output.
    Create file    output/newfile.html    content=${output}
        ...    overwrite=${True}