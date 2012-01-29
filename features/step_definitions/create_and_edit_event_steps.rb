When /^I create a new event$/ do
  visit new_event_path
  fill_in "Name", :with => "Test Event"
  click_button "Create event"
end

Then /^I should be able to edit my event$/ do
  visit events_path
  click_on "Test Event"
  fill_in "Name", :with => "Changed Event"
  click_button "Edit event"
end