require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern   = 'spec/**/*_spec.rb'
end

namespace :spec do
  RSpec::Core::RakeTask.new(:html) do |spec|
    spec.ruby_opts  = "-I lib:spec"
    spec.pattern    = 'spec/**/*_spec.rb'
    spec.rspec_opts = "--format html --out #{ENV["SPEC_REPORT"] || "specs.html"}"
  end

end

task :spec

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


