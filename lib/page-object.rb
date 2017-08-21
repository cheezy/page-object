require 'watir'
require 'page-object/version'
require 'page-object/accessors'
require 'page-object/element_locators'
require 'page-object/nested_elements'
require 'page-object/page_factory'
require 'page-object/page_populator'
require 'page-object/javascript_framework_facade'
require 'page-object/indexed_properties'
require 'page-object/section_collection'
require 'page-object/widgets'

require 'page-object/platforms/watir'
require 'page-object/platforms/watir/page_object'

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
  include ElementLocators
  include PagePopulator

  def method_missing(method, *args, &block)
    @root_element.send(method, *args, &block)
  end

  def respond_to_missing?(method, include_all = false)
    @root_element && @root_element.respond_to?(method) || super
  end

  # @return the platform browser passed to the constructor
  attr_reader :browser
  # @return [PageObject::WatirPageObject] the platform page object
  attr_reader :platform

  #
  # Construct a new page object.  Prior to browser initialization it will call
  # a method named initialize_accessors if it exists. Upon initialization of
  # the page it will call a method named initialize_page if it exists.
  #
  # @param [Watir::Browser, Watir::HTMLElement or Selenium::WebDriver::Driver, Selenium::WebDriver::Element] the platform browser/element to use
  # @param [bool] open the page if page_url is set
  #
  def initialize(root, visit=false)
    initialize_accessors if respond_to?(:initialize_accessors)
    initialize_browser(root)
    goto if visit && self.class.instance_methods(false).include?(:goto)
    initialize_page if respond_to?(:initialize_page)
  end

  def initialize_browser(root)
    @root_element = PageObject::Platforms::Watir.root_element_for root
    @browser = root 
    @platform = PageObject::Platforms::Watir.create_page_object @browser
  end

  # @private
  def self.included(cls)
    cls.extend PageObject::Accessors
  end

  #
  # Set the default timeout for page level waits
  #
  def self.default_page_wait=(timeout)
    @page_wait = timeout
  end

  #
  # Returns the default timeout for page lavel waits
  #
  def self.default_page_wait
    @page_wait ||= 30
  end

  #
  # Sets the default timeout for element level waits
  #
  def self.default_element_wait=(timeout)
    @element_wait = timeout
  end

  #
  # Returns the default timeout for element level waits
  #
  def self.default_element_wait
    @element_wait ||= 5
  end

  #
  # Set the javascript framework to use when determining number of
  # ajax requests.  Valid frameworks are :jquery, :prototype, :yui,
  # and :angularjs
  #
  def self.javascript_framework=(framework)
    PageObject::JavascriptFrameworkFacade.framework = framework
  end

  #
  # Add a new javascript framework to page-object.  The module passed
  # in must adhere to the same prototype as the JQuery and Prototype
  # modules.
  #
  # @param [Symbol] the name used to reference the framework in
  # subsequent calls
  # @param [Module] a module that has the necessary methods to perform
  # the required actions.
  #
  def self.add_framework(key, framework)
    PageObject::JavascriptFrameworkFacade.add_framework(key, framework)
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
  def wait_until(timeout = PageObject.default_page_wait, message = nil, &block)
    platform.wait_until(timeout, message, &block)
  end


  #
  # Wait until there are no pending ajax requests.  This requires you
  # to set the javascript framework in advance.
  #
  # @param [Numeric] the amount of time to wait for the block to return true.
  # @param [String] the message to include with the error if we exceed
  # the timeout duration.
  #
  def wait_for_ajax(timeout = 30, message = nil)
    end_time = ::Time.now + timeout
    until ::Time.now > end_time
      return if browser.execute_script(::PageObject::JavascriptFrameworkFacade.pending_requests) == 0
      sleep 0.5
    end
    message = "Timed out waiting for ajax requests to complete" unless message
    raise message
  end

  #
  # Override the normal alert popup so it does not occur.
  #
  # @example
  #   message = @page.alert do
  #     @page.button_that_causes_alert
  #   end
  #
  # @param frame optional parameter used when alert is nested within a frame
  # @param block a block that has the call that will cause the alert to display
  # @return [String] the message that was contained in the alert
  #
  def alert(frame=nil, &block)
    platform.alert(frame, &block)
  end

  #
  # Override the normal confirm popup so it does not occur.
  #
  # @example
  #   message = @popup.confirm(true) do
  #     @page.button_that_causes_confirm
  #   end
  #
  # @param [bool] what response you want to return back from the confirm popup
  # @param frame optional parameter used when the confirm is nested within a frame
  # @param block a block that has the call that will cause the confirm to display
  # @return [String] the message that was prompted in the confirm
  #
  def confirm(response, frame=nil, &block)
    platform.confirm(response, frame, &block)
  end

  #
  # Override the normal prompt popup so it does not occur.
  #
  # @example
  #   message = @popup.prompt("Some Value") do
  #     @page.button_that_causes_prompt
  #   end
  #
  # @param [string] the value returned to the caller of the prompt
  # @param frame optional parameter used with the prompt is nested within a frame
  # @param block a block that has the call that will cause the prompt to display
  # @return [Hash] A has containing two keys - :message contains the prompt message and
  # :default_value contains the default value for the prompt if provided
  #
  def prompt(answer, frame=nil, &block)
    platform.prompt(answer, frame, &block)
  end

  #
  # Execute javascript on the browser
  #
  # @example Get inner HTML of element
  #   span = @page.span_element
  #   @page.execute_script "return arguments[0].innerHTML", span
  #   #=> "Span innerHTML"
  #
  def execute_script(script, *args)
    args.map! { |e| e.kind_of?(PageObject::Elements::Element) ? e.element : e }
    platform.execute_script(script, *args)
  end

  #
  # Identify an element as existing within a frame.  A frame parameter
  # is passed to the block and must be passed to the other calls to PageObject.
  # You can nest calls to in_frame by passing the frame to the next level.
  #
  # @example
  #   in_frame(:id => 'frame_id') do |frame|
  #     text_field_element(:id => 'fname', :frame => frame)
  #   end
  #
  # @param [Hash] identifier how we find the frame.  The valid keys are:
  #   * :id
  #   * :index
  #   * :name
  #   * :class
  # @param frame passed from a previous call to in_frame.  Used to nest calls
  # @param block that contains the calls to elements that exist inside the frame.
  #
  def in_frame(identifier, frame=nil, &block)
    platform.in_frame(identifier, frame, &block)
  end

  # Identify an element as existing within an iframe.  A frame parameter
  # is passed to the block and must be passed to the other calls to PageObject.
  # You can nest calls to in_iframe by passing the frame to the next level.
  #
  # @example
  #   in_iframe(:id => 'iframe_id') do |iframe|
  #     text_field_element(:id => 'ifname', :frame => iframe)
  #   end
  #
  # @param [Hash] identifier how we find the iframe.  The valid keys are:
  #   * :id
  #   * :index
  #   * :name
  #   * :class
  # @param frame passed from a previous call to in_iframe.  Used to nest calls
  # @param block that contains the calls to elements that exist inside the iframe.
  #
  def in_iframe(identifier, frame=nil, &block)
    platform.in_iframe(identifier, frame, &block)
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
  # the window's title or url.  If it fails to connect to a window it will
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
  # Find the element that has focus on the page
  #
  def element_with_focus
    platform.element_with_focus
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

  def self.register_widget(widget_tag, widget_class, base_element_tag)
    Widgets.register_widget(widget_tag, widget_class, base_element_tag)
  end

  private

  def root
    @root_element || PageObject::Platforms::Watir.browser_root_for(browser)
  end

  def call_block(&block)
    block.arity == 1 ? block.call(self) : self.instance_eval(&block)
  end
end
