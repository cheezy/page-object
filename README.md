# page-object

[![Build Status](http://travis-ci.org/cheezy/page-object.png)](http://travis-ci.org/cheezy/page-object)


A simple gem that assists in creating flexible page objects for testing browser based appications.  The goal is to facilitate creating abstraction layers in your tests to decouple the tests from the item they are testing and to provide a simple interface to the elements on a page.  It works with both watir-webdriver and selenium-webdriver.

### Defining your page object

You define a new page object by including the PageObject module:

    class LoginPage
      include PageObject
    end
    
When you include this module numerous methods are added to your class that allow you to easily define your page.  For the login page you might add the following:

    class LoginPage
      include Page Object
      
      text_field(:username, :id => 'username')
      text_field(:password, :id => 'password')
      button(:login, :id => 'login')
    end

Calling the _text_field_ and _button_ methods adds several methods to our page object that allow us to interact with the items on the page.  To login using this page we could simply write the following code:

    login_page.username = 'cheezy'
    login_page.password = 'secret'
    login_page.login
    
Another approach might be to create higher level methods on our page object that hide the implementation details even further.  Our page object might look like this:

    class LoginPage
      include Page Object
  
      text_field(:username, :id => 'username')
      text_field(:password, :id => 'password')
      button(:login, :id => 'login')
  
      def login_with(username, password) do
        self.username = username
        self.password = password
        login
      end
    end

and your usage of the page would become:

    login_page.login_with 'cheezy', 'secret'

### Creating your page object
page-object supports both [watir-webdriver](https://github.com/jarib/watir-webdriver) and [selenium-webdriver](http://seleniumhq.org/docs/03_webdriver.html).  The one used will be determined by which driver you pass into the constructor of your page object.  The page object can be create like this:

    browser = Watir::Browser.new :firefox
    my_page_object = MyPageObject.new(browser)

or

    browser = Selenium::WebDriver.for :firefox
    my_page_object = MyPageObject.new(browser)

## Documentation

The project [wiki](https://github.com/cheezy/page-object/wiki/page-object) is the first place to go to learn about how to use page-object.

The rdocs for this project can be found at [rubydoc.info](http://rubydoc.info/github/cheezy/page-object/master/frames).

If you wish to view the current tracker board you can view it on [Pivotal Tracker](https://www.pivotaltracker.com/projects/289099)

## Known Issues

See [http://github.com/cheezy/page-object/issues](http://github.com/cheezy/page-object/issues)

## Contribute
 
* Fork the project.
* Test drive your feature addition or bug fix.  Adding specs is important and I will not accept a pull request that does not have tests
* Make sure you describe your new feature with a cucumber feature.
* Make sure you provide RDoc comments for any new public method you add.  Remember, others will be using this gem.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Jeffrey S. Morgan. See LICENSE for details.
