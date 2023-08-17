*** Settings ***
Library    RPA.Robocorp.Vault
Library    RPA.FileSystem
Library    RPA.Browser.Playwright

*** Variables ***
${URL}      %{WEBSITE_URL}
${source_folder}    schema/stream1
${destination_folder}    output/data/stream1
${URL}            https://www.example.com

*** Tasks ***
Minimal task
    New Browser     headless=${False}  # starts in headless in Control Room
    New Page    https://robocorp.com/docs/development-guide/browser/playwright

    ${secret}=    Get Secret    default
    Log    ${URL}
    Log    ${secret}[WEBSITE_URL]
    ${output}    Set Variable    This is the data output.
    Create file    output/newfile.html    content=${output}
        ...    overwrite=${True}
    ${file_list}    List Files In Directory    ${source_folder}
    FOR    ${file}    IN    @{file_list}
        ${source_path}    Join Path    ${source_folder}    ${file}
        ${destination_path}    Join Path    ${destination_folder}    ${file.name}
        ${destination_dir}    Evaluate    os.path.dirname($destination_path)
        Create Directory    ${destination_dir}    recursive=True
        Copy File    ${source_path}    ${destination_path}
    END