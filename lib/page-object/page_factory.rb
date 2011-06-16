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
  module PageFactory
    
    #
    # Create and navigate to a page object.  The navigation will only work if the
    # 'page_url' method was call on the page object.
    #
    # @param [PageObject] a class that has included the PageObject module
    # @param an optional block to be called
    # @return [PageObject] the newly created page object
    #
    def visit_page(page_class, &block)
      on_page page_class, true, &block
    end
    
    #
    # Create a page object.
    #
    # @param [PageObject]  a class that has included the PageObject module
    # @param [Boolean]  a boolean indicating if the page should be visited?  default is false.
    # @param [block]  an optional block to be called
    # @return [PageObject] the newly created page object
    #
    def on_page(page_class, visit=false, &block)
      page = page_class.new(@browser, visit)
      block.call page if block
      page
    end
    
  end
end