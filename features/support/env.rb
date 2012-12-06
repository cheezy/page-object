$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec/expectations'
require 'watir-webdriver'
require 'selenium-webdriver'
require 'page-object'
require_relative '../../extension/widgets'
require_relative 'Widgets/gxt_table'

Widgets::register_widget :gxt_table, GxtTable