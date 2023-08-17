*** Settings ***
Library    RPA.Robocorp.Vault
Library    RPA.FileSystem
#Library    RPA.Browser.Playwright
Library    RPA.Excel.Files
Library    RPA.Browser.Selenium

*** Variables ***
${URL}      %{WEBSITE_URL}
${source_folder}    schema/stream1
${destination_folder}    output/data/stream1

*** Tasks ***
Minimal task
#    New Browser   headless=${True}  # starts in headless in Control Room
#    New Page    https://google.com
    RPA.Browser.Selenium.Open Browser  https://www.google.com  headlesschrome
    Create Workbook  my_new_excel.xlsx
    FOR    ${index}    IN RANGE    20
        &{row}=       Create Dictionary
        ...           Row No   ${index}
        ...           Amount   ${index * 25}
        Append Rows to Worksheet  ${row}  header=${TRUE}
    END
    Save Workbook
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