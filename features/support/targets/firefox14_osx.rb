require 'selenium-webdriver'
require 'selenium/webdriver/remote/http/persistent'
require 'watir-webdriver'

module Target
  def desired_capabilities
    capabilities(:firefox, '14', 'Mac 10.6', 'Testing page-object with Firefox 14 on OS X')
  end
end

