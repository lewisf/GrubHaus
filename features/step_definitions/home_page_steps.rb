Given /^I am on the home page$/ do
  visit "/"
end

And /^I am not a user$/ do
  page.should have_content "Sign up"
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content text
end
