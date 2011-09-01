class ModalPage
  include PageObject

  button(:launch_modal, :id => 'launch_modal_button')
end

class ModalDialog
  include PageObject

  button(:close_window, :id => 'close_window')
  button(:close_window_with_delay, :id => 'delayed_close')
  button(:launch_another_modal, :id => 'launch_modal_button')
end

class AnotherModalDialog
  include PageObject

  button(:close_window, :id => 'close_window2')
  button(:close_window_with_delay, :id => 'delayed_close2')
end


Given /^I am on the modal page$/ do
  ModalPage.new(@browser).navigate_to(UrlHelper.modal)  
end

When /^I open a modal dialog$/ do
  page = ModalPage.new(@browser)
  page.modal_dialog do
    page.launch_modal
  end
end

Then /^I should be able to close the modal$/ do
  dialog = ModalDialog.new(@browser)
  dialog.attach_to_window(:title => 'Modal 1') do
    dialog.close_window
  end
end

When /^I open another modal dialog from that one$/ do
  dialog = ModalDialog.new(@browser)
  dialog.attach_to_window(:title => 'Modal 1') #do
    dialog.modal_dialog #do
#      dialog.launch_another_modal
#    end
    dialog.launch_another_modal
#  end
end

Then /^I should be able to close both modals$/ do
  pending
  # another = AnotherModalDialog.new(@browser)
  # another.attach_to_window(:title => 'Modal 2') do
  #   another.close_window
  # end

  # dialog = ModalDialog.new(@browser)
  # dialog.attach_to_window(:title => 'Modal 1') do
  #   dialog.close_window
  # end
end
