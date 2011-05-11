require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern   = 'spec/**/*_spec.rb'
end

task :spec

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :lib do
  $LOAD_PATH.unshift(File.expand_path("lib", File.dirname(__FILE__)))
end

task :default => :spec

begin
  require 'yard'
  Rake::Task[:lib].invoke
  require "yard/handlers/page-object"
  YARD::Rake::YardocTask.new do |task|
    task.options = %w[--debug] # this is pretty slow, so nice with some output
  end
rescue LoadError
  task :yard do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end


