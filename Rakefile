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

Cucumber::Rake::Task.new(:features, "Run the cucumber features")


desc 'Run all specs and cukes'
task :test => ['spec', 'features']

task :lib do
  $LOAD_PATH.unshift(File.expand_path("lib", File.dirname(__FILE__)))
end

task :test_with_coveralls => [:test, 'coveralls:push']

task :default => :test_with_coveralls
