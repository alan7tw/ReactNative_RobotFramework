import time
from AppiumLibrary import AppiumLibrary
from appium.webdriver.common.touch_action import TouchAction

class Customize(AppiumLibrary):

    def back_key(self):
        driver = self._current_application()
        driver.back()
        time.sleep(2)

    def switch_to_webview(self, text):
        driver = self._current_application()
        driver.switch_to.context(text)

    def switch_to_frame(self, text):
        driver = self._current_application()
        driver.switch_to.frame(text)

    def switch_to_native(self):
        driver = self._current_application()
        driver.switch_to.context('NATIVE_APP')

    def print_status(self):
        driver = self._current_application()
        print(driver.current_activity)
        print(driver.context)
        print(driver.contexts)
    
    def click_position(self, x, y):
	driver = self._current_application()
	TouchAction(driver).tap(x=x,y=y).perform()

    def find_for_element_id(self, text):
        driver = self._current_application()
        wait_second = 0
        if text == '':
            return False

        while wait_second >= 0:

            try:
                if text != '':
                    element = driver.find_element_by_id(text)
                if element:
                    is_find = 1
                    break
                else:
                    is_find = 0
                    break

            except:
                element = None
                print('element = none!')
                is_find = 0
                break

        print('Find for element id finished!')

        if is_find == 1:
            return 1
        else:
            return 0

    def find_for_element_xpath(self, text):

        driver = self._current_application()

        wait_second = 0

        if text == '':
            return False

        while wait_second >= 0:

            try:
                if text != '':
                    element = driver.find_element_by_xpath(text)
                if element:
                    is_find = 1
                    break
                else:
                    is_find = 0
                    break

            except:
                element = None
                print('element = none!')
                is_find = 0
                break

        print('Find for element xpath finished!')

        if is_find == 1:
            return 1
        else:
            return 0

    def Go_To(self,url):
	driver = self._current_application()
	driver.get(url)

    def click_element_by_text(self, text):
	driver = self._current_application()
	driver.find_element_by_xpath("//*[contains(@text,'"+text+"')]")

    def click_element_by_link_text(self, text):
	driver = self._current_application()
	driver.find_element_by_link_text(text).click()

    def click_element_by_class_name(self,name):
	driver = self._current_application()
	driver.find_element_by_class_name(name).click()
  
    def wait_until_page_does_not_contain_element_and_ignore_timeout(self, locator, timeout=None, error=None):

        def check_present():
            present = self._is_element_present(locator)
            if not present:
                return
            else:
                return
                print("Ignore Timeout")
        
        self._wait_until_no_error(timeout, check_present)
