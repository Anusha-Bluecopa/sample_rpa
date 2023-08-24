from selenium import webdriver

chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument("--disable-dev-shm-usage")
driver = webdriver.Chrome(options=chrome_options)

# Open Google's homepage
driver.get("https://www.google.com")

# Print the page title to verify
print("Page title:", driver.title)

# Close the browser
driver.quit()