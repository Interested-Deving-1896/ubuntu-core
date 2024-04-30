#!/usr/bin/env python3

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2016 Microsoft Corporation. All rights reserved.
# SPDX-FileCopyrightText: 2021-2022 Harald Sitter <sitter@kde.org>

# Source: https://invent.kde.org/sdk/selenium-webdriver-at-spi/-/blob/master/examples/calculatortest.py?ref_type=heads
# Errors:
# - `org.kde.kcalc.desktop` cannot be started (GIO constructor returns null), `/snap/bin/kcalc` needs to be used instead
# Changes for kcalc 24.02 (from kcalc 23.08):
# - The input and result are now split in different fields, which means chaining a result with a followup operation is
#    no longer possible, and the result field requires a '=' press to be updated.
#   => `test_initialize()` needs an extra `=` press to display the result
#   => `test_combination()` is disabled as combination no longer works

import unittest
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from appium.options.common.base import AppiumOptions
import selenium.common.exceptions
from selenium.webdriver.support.ui import WebDriverWait


class SimpleCalculatorTests(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        options = AppiumOptions()
        # The app capability may be a command line or a desktop file id.
        options.set_capability("app", "/snap/bin/kcalc")  # 'org.kde.kcalc.desktop' does not work
        # Boilerplate, always the same
        self.driver = webdriver.Remote(command_executor='http://127.0.0.1:4723', options=options)
        # Set a timeout for waiting to find elements. If elements cannot be found
        # in time we'll get a test failure. This should be somewhat long so as to
        # not fall over when the system is under load, but also not too long that
        # the test takes forever.
        self.driver.implicitly_wait = 10

    @classmethod
    def tearDownClass(self):
        # Make sure to terminate the driver again, lest it dangles.
        self.driver.quit()

    def setUp(self):
        self.driver.find_element(by=AppiumBy.NAME, value="AC").click()
        wait = WebDriverWait(self.driver, 20)
        wait.until(lambda x: self.getresults() == '0')

    def getresults(self):
        displaytext = self.driver.find_element(by='description', value='Result Display').text
        return displaytext

    def assertResult(self, actual, expected):
        wait = WebDriverWait(self.driver, 20)
        try:
            wait.until(lambda x: self.getresults() == expected)
        except selenium.common.exceptions.TimeoutException:
            pass
        self.assertEqual(self.getresults(), expected)

    def test_initialize(self):
        self.driver.find_element(by=AppiumBy.NAME, value="AC").click()
        self.driver.find_element(by=AppiumBy.NAME, value="7").click()
        self.driver.find_element(by=AppiumBy.NAME, value="=").click()
        self.assertResult(self.getresults(), "7")

    def test_addition(self):
        self.driver.find_element(by=AppiumBy.NAME, value="1").click()
        self.driver.find_element(by=AppiumBy.NAME, value="+").click()
        self.driver.find_element(by=AppiumBy.NAME, value="7").click()
        self.driver.find_element(by=AppiumBy.NAME, value="=").click()
        self.assertResult(self.getresults(), "8")

    @unittest.skip("Results are not re-usable as inputs in kcalc 24.02.1, so this scenario no longer works")
    def test_combination(self):
        self.driver.find_element(by=AppiumBy.NAME, value="7").click()
        self.driver.find_element(by=AppiumBy.NAME, value="×").click()
        self.driver.find_element(by=AppiumBy.NAME, value="9").click()
        self.driver.find_element(by=AppiumBy.NAME, value="+").click()
        self.driver.find_element(by=AppiumBy.NAME, value="1").click()
        self.driver.find_element(by=AppiumBy.NAME, value="=").click()
        self.driver.find_element(by=AppiumBy.NAME, value="÷").click()  # in kcalc 24, the input is not `64/8` but `/8`
        self.driver.find_element(by=AppiumBy.NAME, value="8").click()
        self.driver.find_element(by=AppiumBy.NAME, value="=").click()
        self.assertResult(self.getresults(), "8")

    def test_division(self):
        # Using find element by name twice risks the driver finding the
        # result display text rather than finding the button. To avoid
        # that, execute the call once and store that as a local value.
        button8 = self.driver.find_element(by=AppiumBy.NAME, value="8")
        button8.click()
        button8.click()
        self.driver.find_element(by=AppiumBy.NAME, value="÷").click()
        button1 = self.driver.find_element(by=AppiumBy.NAME, value="1")
        button1.click()
        button1.click()
        self.driver.find_element(by=AppiumBy.NAME, value="=").click()
        self.assertResult(self.getresults(), "8")

    def test_multiplication(self):
        self.driver.find_element(by=AppiumBy.NAME, value="9").click()
        self.driver.find_element(by=AppiumBy.NAME, value="×").click()
        self.driver.find_element(by=AppiumBy.NAME, value="9").click()
        self.driver.find_element(by=AppiumBy.NAME, value="=").click()
        self.assertResult(self.getresults(), "81")

    def test_subtraction(self):
        self.driver.find_element(by=AppiumBy.NAME, value="9").click()
        self.driver.find_element(by=AppiumBy.NAME, value="−").click()
        self.driver.find_element(by=AppiumBy.NAME, value="1").click()
        self.driver.find_element(by=AppiumBy.NAME, value="=").click()
        self.assertResult(self.getresults(), "8")


if __name__ == '__main__':
    unittest.main()
