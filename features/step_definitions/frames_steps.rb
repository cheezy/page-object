class FramePage
  include PageObject
  
  in_frame(:index => 1) do |frame|
    text_field(:text_field_2_index, :name => 'recieverElement', :frame => frame)
  end
  in_frame(:index => 0) do |frame|
    text_field(:text_field_1_index, :name => 'senderElement', :frame => frame)
  end

  in_frame(:id => 'frame_two_2') do |frame|
    text_field(:text_field_2_id, :name => 'recieverElement', :frame => frame)
  end
  in_frame(:id => 'frame_one_1') do |frame|
    text_field(:text_field_1_id, :name => 'senderElement', :frame => frame)
  end

  in_frame(:name => 'frame2') do |frame|
    text_field(:text_field_2_name, :name => 'recieverElement', :frame => frame)
  end
  in_frame(:name => 'frame1') do |frame|
    text_field(:text_field_1_name, :name => 'senderElement', :frame => frame)
  end

  in_frame(:id => /frame_two_\d+/) do |frame|
    text_field(:text_field_2_regex, :name => 'recieverElement', :frame => frame)
  end
  
end

class IFramePage
  include PageObject

  in_iframe(:id => 'frame_two_2') do |frame|
    text_field(:text_field_2_id, :name => 'recieverElement', :frame => frame)
  end
  in_iframe(:id => 'frame_one_1') do |frame|
    text_field(:text_field_1_id, :name => 'senderElement', :frame => frame)
  end

  in_iframe(:name => 'frame2') do |frame|
    text_field(:text_field_2_name, :name => 'recieverElement', :frame => frame)
  end
  in_iframe(:name => 'frame1') do |frame|
    text_field(:text_field_1_name, :name => 'senderElement', :frame => frame)
  end

  in_iframe(:index => 1) do |frame|
    text_field(:text_field_2_index, :name => 'recieverElement', :frame => frame)
  end
  in_iframe(:index => 0) do |frame|
    text_field(:text_field_1_index, :name => 'senderElement', :frame => frame)
  end

end


Given /^I am on the frame elements page$/ do
  @page = FramePage.new(@browser)
  @page.navigate_to(UrlHelper.frame_elements)
end

Given /^I am on the iframe elements page$/ do
  @page = IFramePage.new(@browser)
  @page.navigate_to(UrlHelper.iframe_elements)
end

When /^I type "([^\"]*)" into the text field for frame 2 using "([^\"]*)"$/ do |text, arg_type|
  @page.send "text_field_2_#{arg_type}=".to_sym, text
end

Then /^I should verify "([^\"]*)" is in the text field for frame 2 using "([^\"]*)"$/ do |text, arg_type|
  result = @page.send "text_field_2_#{arg_type}".to_sym
  result.should == text
end

#Then /^I should be able to get the text fields text from frame 2 using "([^\"]*)"$/ do |arg_type|
#  @page.send("text_field_2_#{arg_type}_element").text
#end

When /^I type "([^\"]*)" into the text field from frame 1 using "([^\"]*)"$/ do |text, arg_type|
  @page.send "text_field_1_#{arg_type}=".to_sym, text
end

Then /^I should verify "([^\"]*)" is in the text field for frame 1 using "([^\"]*)"$/ do |text, arg_type|
  result = @page.send "text_field_1_#{arg_type}".to_sym
  result.should == text
end

class NestedFramePage
  include PageObject
  
  in_frame(:id => 'two') do |frame|
    in_iframe({:id => 'three'}, frame) do |nested_frame|
      link(:nested_link, :id => 'four', :frame => nested_frame)
    end
  end
end

Given /^I am on the nested frame elements page$/ do
  @page = NestedFramePage.new(@browser)
  @page.navigate_to(UrlHelper.nested_frame_elements)
end

Then /^I should be able to click the link in the frame$/ do
  @page.nested_link
  @page.text.should include "Success"
end

When /^I type "([^\"]*)" into the text field from frame 1 identified dynamically$/ do |value|
  @page.in_frame(:id => 'frame_one_1') do |frame|
    @page.text_field_element(:name => 'senderElement', :frame => frame).value = value
  end
end

Then /^I should verify "([^\"]*)" in the text field for frame 1 identified dynamically$/ do |value|
  @page.in_frame(:id => 'frame_one_1') do |frame|
    @page.text_field_element(:name => 'senderElement', :frame => frame).value.should == value
  end
end

When /^I trigger an alert within a frame$/ do
  @page.in_frame(:id => 'frame_three_3') do |frame|
    @msg = @page.alert(frame) do
      @page.button_element(:id => 'alert_button', :frame => frame).click
    end
  end
end

When /^I trigger a confirm within a frame$/ do
  @page.in_frame(:id => 'frame_three_3') do |frame|
    @msg = @page.confirm(true, frame) do
      @page.button_element(:id => 'confirm_button', :frame => frame).click
    end
  end
end

When /^I trigger a prompt within a frame$/ do
  @page.in_frame(:id => 'frame_three_3') do |frame|
    @msg = @page.prompt("Cheezy", frame) do
      @page.button_element(:id => 'prompt_button', :frame => frame).click
    end
  end
end
