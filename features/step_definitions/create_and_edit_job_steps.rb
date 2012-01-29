When /^I create a new job$/ do
  visit new_job_path
  fill_in "Name", :with => "Test Job"
  click_button "Create job"
end

Then /^I should be able to edit my job$/ do
  visit jobs_path
  click_on "Test Job"
  fill_in "Name", :with => "Changed Job"
  click_button "Edit job"
end