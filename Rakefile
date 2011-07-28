require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/**/*_spec.rb'
end
task :spec

namespace :features do
  Cucumber::Rake::Task.new(:watir, "Run features with Watir") do |t|
    t.profile = "watir"
  end

  Cucumber::Rake::Task.new(:selenium, "Run features with Selenium") do |t|
    t.profile = "selenium"
  end

  desc 'Run all features'
  task :all => [:watir, :selenium]
end

desc 'Run all specs and cukes'
task :test => ['spec', 'features:all']

task :lib do
  $LOAD_PATH.unshift(File.expand_path("lib", File.dirname(__FILE__)))
end

task :default => :spec
