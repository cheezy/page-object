# page-object

[![Build Status](http://travis-ci.org/cheezy/page-object.png)](http://travis-ci.org/cheezy/page-object)


A simple gem that assists in creating flexible page objects for testing browser based appications.  It works with both watir-webdriver and selenium-webdriver.

You define a new page object by including the PageObject module:

    class MyPageObject
      include PageObject
    end

Including this module adds an initialize method that takes either a Watir::Browser or Selenium::WebDriver::Driver object.  You create your object like this:

    browser = Watir::Browser.new :firefox
    my_page_object = MyPageObject.new(browser)

or
    browser = Selenium::WebDriver.for :firefox
    my_page_object = MyPageObject.new(browser)

## Note on Patches/Pull Requests
 
* Fork the project.
* Test drive your feature addition or bug fix.  Adding specs is important so I don't break it in a future version unintentionally.
* Make sure you describe your new feature with a cucumber feature.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Jeffrey S. Morgan. See LICENSE for details.
