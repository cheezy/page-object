# A sample Guardfile
# More info at https://github.com/guard/guard#readme

features_to_run = 'features'

guard 'rspec', :cli => '--color --format Fuubar' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/page-object/platforms/(.+)/.+\.rb$}) do |m|
    ["spec/page-object/platforms/#{m[1]}/", "spec/page-object/page-object_spec.rb"]
  end
  watch('spec/spec_helper.rb')  { "spec" }
end

guard 'cucumber', :notification => true, :all_after_pass => false, :all_on_start => false, :cli => '--profile default'  do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { features_to_run }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  watch(%r{^lib/.+\.rb$})                   { features_to_run }
  watch(%r{^cucumber.yml$})                 { features_to_run }
end
