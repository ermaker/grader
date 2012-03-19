Given /^a Grader$/ do
  @grader = Grader.new
end

When /^Grader gets the path of the zip file "(.+)"$/ do |path|
  @grader.path = path
end

Then /^Grader should get (.+) "(.+)"$/ do |method,expected|
  @grader.send(method).to_s.should == expected
end
