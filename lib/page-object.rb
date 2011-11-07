require 'page-object/version'
require 'page-object/accessors'
require 'page-object/platforms'
require 'page-object/element_locators'
require 'page-object/nested_elements'

#
# Module that when included adds functionality to a page object.  This module
# will add numerous class and instance methods that you use to define and
# interact with web pages.
#
# If we have a login page with a username and password textfield and a login
# button we might define our page like the one below.  We can then interact with
# the object using the generated methods.
#
# @example Login page example 
#   class LoginPage
#     include PageObject
#
#     text_field(:username, :id => 'user')
#     text_field(:password, :id => 'pass')
#     button(:login, :value => 'Login')
#   end
#
#   ...
#
#   browser = Watir::Browser.new :firefox
#   login_page = LoginPage.new(browser)
#   login_page.username = 'cheezy'
#   login_page.password = 'secret'
#   login_page.login
#
# @see PageObject::Accessors to see what class level methods are added to this module at runtime.
#
module PageObject
  include LoadsPlatform
  include ElementLocators
  
  # @return [Watir::Browser or Selenium::WebDriver::Driver] the platform browser passed to the constructor
  attr_reader :browser
  # @return [PageObject::WatirPageObject or PageObject::SeleniumPageObject] the platform page object
  attr_reader :platform

  #
  # Construct a new page object.  Upon initialization of the page it will call a method named
  # initialize_page if it exists.
  #
  # @param [Watir::Browser or Selenium::WebDriver::Driver] the platform browser to use
  # @param [bool] open the page if page_url is set
  #
  def initialize(browser, visit=false)
    @browser = browser
    include_platform_driver(browser)
    initialize_page if respond_to?(:initialize_page)
    goto if visit && respond_to?(:goto)
  end

  # @private
  def self.included(cls)
    cls.extend PageObject::Accessors
  end

  #
  # get the current page url
  #
  def current_url
    platform.current_url
  end

  #
  # navigate to the provided url
  #
  # @param [String] the full url to navigate to
  #
  def navigate_to(url)
    platform.navigate_to(url)
  end

  #
  # Returns the text of the current page
  #
  def text
    platform.text
  end

  #
  # Returns the html of the current page
  #
  def html
    platform.html
  end

  #
  # Returns the title of the current page
  #
  def title
    platform.title
  end

  #
  # Wait until the block returns true or times out
  #
  # @example
  #   @page.wait_until(5, 'Success not found on page') do
  #     @page.text.include? 'Success'
  #   end
  #
  # @param [Numeric] the amount of time to wait for the block to return true.
  # @param [String] the message to include with the error if we exceed the timeout duration.
  # @param block the block to execute.  It should return true when successful.
  #
  def wait_until(timeout = 30, message = nil, &block)
    platform.wait_until(timeout, message, &block)
  end

  #
  # Override the normal alert popup so it does not occurr.
  #
  # @example
  #   message = @page.alert do
  #     @page.button_that_causes_alert
  #   end
  #
  # @param block a block that has the call that will cause the alert to display
  # @return [String] the message that was contained in the alert
  #
  def alert(&block)
    platform.alert(&block)
  end

  #
  # Override the normal confirm popup so it does not occurr.
  #
  # @example
  #   message = @popup.confirm(true) do
  #     @page.button_that_causes_confirm
  #   end
  #
  # @param [bool] what response you want to return back from the confirm popup
  # @param block a block that has the call that will cause the confirm to display
  # @return [String] the message that was prompted in the confirm
  #
  def confirm(response, &block)
    platform.confirm(response, &block)
  end

  #
  # Override the normal promp popup so it does not occurr.
  #
  # @example
  #   message = @popup.prompt("Some Value") do
  #     @page.button_that_causes_prompt
  #   end
  #
  # @param [string] the value returned to the caller of the prompt
  # @param block a block that has the call that will cause the prompt to display
  # @return [Hash] A has containing two keys - :message contains the prompt message and
  # :default_value contains the default value for the prompt if provided
  #
  def prompt(answer, &block)
    platform.prompt(answer, &block)
  end
  
  #
  # Identify an element as existing within a frame or iframe.  A frame parameter
  # is passed to the block and must be passed to the other calls to PageObject.
  # You can nest calls to in_frame by passing the frame to the next level.
  #
  # @example
  #   in_frame(:id => 'frame_id') do |frame|
  #     text_field_element(:id => 'fname', :frame => frame)
  #   end
  #
  # @param [Hash] identifier how we find the frame.  The valid keys are:
  #   * :id => Watir and Selenium
  #   * :index => Watir and Selenium
  #   * :name => Watir and Selenium
  # @param frame passed from a previous call to in_frame.  Used to nest calls
  # @param block that contains the calls to elements that exist inside the frame.
  #
  def in_frame(identifier, frame=nil, &block)
    frame = [] if frame.nil?
    frame << identifier
    block.call(frame)
  end

  #
  # Override the normal showModalDialog call is it opens a window instead
  # of a dialog.  You will need to attach to the new window in order to
  # continue.
  #
  # @example
  #   @page.modal_dialog do
  #     @page.action_that_spawns_the_modal
  #   end
  #
  # @param block a block that contains the call that will cause the modal dialog.
  #
  def modal_dialog(&block)
    script =
    %Q{
      window.showModalDialog = function(sURL, vArguments, sFeatures) {
        window.dialogArguments = vArguments;
        modalWin = window.open(sURL, 'modal', sFeatures);
        return modalWin;
      }
    }
    browser.execute_script script
    yield if block_given?
  end
  
  #
  # Attach to a running window.  You can locate the window using either
  # the window's title or url.  If it failes to connect to a window it will
  # pause for 1 second and try again.
  #
  # @example
  #     page.attach_to_window(:title => "other window's title")
  #
  # @param [Hash] either :title or :url of the other window.  The url does not need to
  # be the entire url - it can just be the page name like index.html
  # @param block if present the block is executed and then execution is returned to the
  # calling window
  #
  def attach_to_window(identifier, &block)
    begin
      platform.attach_to_window(identifier, &block)
    rescue
      sleep 1
      platform.attach_to_window(identifier, &block)
    end
  end
  
  #
  # Refresh to current page
  #
  def refresh
    platform.refresh
  end
  
  #
  # Go back to the previous page
  #
  def back
    platform.back
  end
  
  #
  # Go forward to the next page
  #
  def forward
    platform.forward
  end
  
  #
  # Clear the cookies from the browser
  #
  def clear_cookies
    platform.clear_cookies
  end
  
  #
  # Save the current screenshot to the provided url.  File
  # is saved as a png file.
  #
  def save_screenshot(file_name)
    platform.save_screenshot file_name
  end

  private

  def include_platform_driver(browser)
    @platform = load_platform(browser, PageObject::Platforms.get)
  end
  
  def call_block(&block)
      block.arity == 1 ? block.call(self) : self.instance_eval(&block)      
  end
end
