# A sample Guardfile
# More info at https://github.com/guard/guard#readme


guard :rspec, cmd: 'rspec --color --format documentation' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/page-object/platforms/(.+)/.+\.rb$}) do |m|
    ["spec/page-object/platforms/#{m[1]}/", "spec/page-object/page-object_spec.rb"]
  end
  watch('spec/spec_helper.rb')  { "spec" }
end

guard 'cucumber', notification: true, all_after_pass: false, cli: '--profile focus'  do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { "features" }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  watch(%r{^lib/.+\.rb$})                   { "features" }
  watch(%r{^cucumber.yml$})                 { "features" }
end
