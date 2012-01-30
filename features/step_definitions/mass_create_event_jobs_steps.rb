Given /^An event$/ do
  @event = Factory(:event)
end

When /^I go to the create event jobs page$/ do
  visit event_path(@event)
  click_link "Create event jobs"
end

When /^Change some details and submit the form$/ do
  # expect a table with a list of new jobs to be created, each with a field for expected time
  within page.find(:xpath, "//div[contains(.//span/text(), \"Erect a flag pole\")]") do
    fill_in "Expected time", :with => "4.00"
  end
  within page.find(:xpath, "//div[contains(.//span/text(), \"Raise the flag\")]") do
    fill_in "Expected time", :with => "2.00"
  end

  click_button "Initialise jobs"
end

Then /^All those jobs should be created with my changes$/ do
  visit jobs_path
  page.should have_content "Raise the flag"
  page.should have_content "2.00"
  page.should have_content "Erect a flag pole"
  page.should have_content "4.00"
end

Then /^The event should be marked that the jobs are finalized$/ do
  visit event_path(@event)
  page.should_not have_content "Create event jobs"
end