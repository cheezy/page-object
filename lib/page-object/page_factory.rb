module PageObject
  #
  # Module to facilitate to creating of page objects in step definitions.  You
  # can make the methods below available to all of your step definitions by adding
  # this module to World.  This idea was first discussed in Alister Scott's blog
  # entry http://watirmelon.com/2011/06/07/removing-local-page-references-from-cucumber-steps/.
  #
  # @example Making the PageFactory available to your step definitions
  #   World PageObject::PageFactory
  #
  # @example Visiting a page for the first time in a Scenario
  #   visit_page MyPageObject do |page|
  #     page.name = 'Cheezy'
  #   end
  #
  # @example using a page that has already been visited in a Scenario
  #   on_page MyPageObject do |page|
  #     page.name.should == 'Cheezy'
  #   end
  #
  # If you plan to use the navigate_to method you will need to ensure
  # you setup the possible routes ahead of time.  You must always have
  # a default route in order for this to work.  Here is an example of
  # how you can setup routes:
  #
  # @example Example routes defined in env.rb
  #   PageObject::PageFactory.routes = {
  #     :default => [PageOne, PageTwoA, PageThree, PageFour],
  #     :another_route => [PageOne, PageTwoB, PageThree, PageFour]
  #   }
  # You must also call the navigation_method method on each page.
  # 
  module PageFactory

    #
    # Create and navigate to a page object.  The navigation will only work if the
    # 'page_url' method was call on the page object.
    #
    # @param [PageObject] a class that has included the PageObject module
    # @param an optional block to be called
    # @return [PageObject] the newly created page object
    #
    def visit_page(page_class)
      on_page page_class, true
    end

    #
    # Create a page object.
    #
    # @param [PageObject]  a class that has included the PageObject module
    # @param [Boolean]  a boolean indicating if the page should be visited?  default is false.
    # @param [block]  an optional block to be called
    # @return [PageObject] the newly created page object
    #
    def on_page(page_class, visit=false)
      @current_page = page_class.new(@browser, visit)
      yield @current_page if block_given?
      @current_page
    end

    #
    # Navigate to a specific page following a predefined path.
    #
    # This method requires a lot of setup.  See the documentation for
    # this class.  Once the setup is complete you can navigate to a
    # page traversing through all other pages along the way.  It will
    # call the method you specified in the navigation_method for each
    # page as it navigates.  Using the example setup defined in the
    # documentation above you can call the method two ways:
    #
    # @example
    #   page.navigate_to(PageThree)  # will use the default path
    #   page.navigate_to(PageThree, :using => :another_route)
    #
    # @param [PageObject]  a class that has included the PageObject
    # module and which has the navigation_method defined
    # @param [Hash] a hash that contains an element with the key
    # :using.  This will be used to lookup the route.  It has a
    # default value of :default.
    # @param [block]  an optional block to be called
    # @return [PageObject] the page you are navigating to
    #
    def navigate_to(page_cls, how = {:using => :default})
      path = PageObject::PageFactory.page_object_routes[how[:using]]
      fail("PageFactory route :#{how[:using].to_s} not found") unless path
      path[0..path.index(page_cls)-1].each do |cls|
        page = on_page(cls)
        method = cls.page_object_navigation_method
        fail("Navigation method not specified on #{cls}.  Please call the ") unless page.respond_to? method
        page.send method
      end
      on_page(page_cls)
    end


    class << self
      attr_accessor :page_object_routes
      
      def routes=(routes)
        raise("You must provide a :default route for PageFactory routes") unless routes[:default]
        @page_object_routes = routes
      end
    end

  end
end
