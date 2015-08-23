require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'coveralls/rake/task'

Coveralls::RakeTask.new
Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/**/*_spec.rb'
end
task :spec

namespace :features do
  Cucumber::Rake::Task.new(:watir_webdriver, "Run features with Watir") do |t|
    t.profile = "watir_webdriver"
  end

  Cucumber::Rake::Task.new(:selenium_webdriver, "Run features with Selenium") do |t|
    t.profile = "selenium_webdriver"
  end

  desc 'Run all features'
  task :all => [:watir_webdriver, :selenium_webdriver]
end

desc 'Run all specs and cukes'
task :test => ['spec', 'features:all']

task :lib do
  $LOAD_PATH.unshift(File.expand_path("lib", File.dirname(__FILE__)))
end

task :test_with_coveralls => [:test, 'coveralls:push']

task :default => :test_with_coveralls
