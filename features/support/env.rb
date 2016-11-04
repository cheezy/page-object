$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec'
require 'watir-webdriver'
require 'selenium-webdriver'
require 'page-object'

World(PageObject::PageFactory)
