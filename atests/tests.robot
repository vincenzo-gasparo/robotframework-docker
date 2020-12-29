***Settings****
Library         SeleniumLibrary     run_on_failure=None
Suite Teardown  Close All Browsers  

***Test Cases***
Tests Firefox
  Open Firefox browser   http://example.com/
  Page Should Contain    Example Domain

Tests Chrome
  Open Chrome browser   http://example.com/
  Page Should Contain   Example Domain

***Keywords***
Open Chrome browser
  [Arguments]    ${url}
  Open Browser   ${url}  browser=chrome  options=add_argument("--disable-gpu");add_argument("--no-sandbox")

Open Firefox browser
  [Arguments]    ${url}
  Open Browser   ${url}  browser=firefox  options=add_argument("--disable-gpu");add_argument("--no-sandbox")
