# pip install selenium

from selenium import webdriver
from selenium.webdriver.common.by import By
import json, sys, html2text

options = webdriver.FirefoxOptions()
options.add_argument("-headless")
options.set_preference('javascript.enabled', False)

# make sure you have no other instance of firefox running that uses this profile or it will throw an error without a helpful message
#options.add_argument('-profile')
#options.add_argument('/home/dns/.mozilla/firefox/dfpyhtbw.DNS')
#options.profile = '/home/dns/.mozilla/firefox/dfpyhtbw.DNS'

#options.set_preference('devtools.jsonview.enabled', False)
'''
# rest
fp = webdriver.FirefoxProfile('/home/dns/.mozilla/firefox/dfpyhtbw.DNS')
options.FirefoxProfile = fp
driver = webdriver.Firefox(options=options)
#driver.get(f'{sys.argv[1]}')
driver.get(f'view-source:https://www.idx.co.id/primary/helper/GetStockChart?indexCode=BUMI&period=1Y')
content = driver.find_element(By.TAG_NAME, 'pre').text
#content = driver.find_element(By.XPATH, "//div[@id='json']").text
parsed_json = json.loads(content)
print(parsed_json)
'''


#fp = webdriver.FirefoxProfile('/home/dns/.mozilla/firefox/dfpyhtbw.DNS')
#options.FirefoxProfile = fp
driver = webdriver.Firefox(options=options)
#driver.get(f'{sys.argv[1]}')
driver.get(sys.argv[1])
content = driver.page_source

h = html2text.HTML2Text()
h.wrap_links = False
txt = h.handle(content)
print(txt)




driver.close()
driver.quit()




