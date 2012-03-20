Given /^a Grader$/ do
  @grader = Grader.new
end

When /^Grader gets the path of the zip file "(.+)"$/ do |path|
  @grader.path = path
end

When /^Grader runs homework with "(.+)"$/ do |wldfilename|
  @result = @grader.run(wldfilename)
end

When /^Grader runs homework with "(.+)" in the zip file$/ do |wldfilename_in_zipfile|
  @result = @grader.run(wldfilename_in_zipfile, :in => :zip)
end

Then /^Grader should get (.+) "(.+)"$/ do |method,expected|
  @grader.send(method).to_s.should == expected
end

Then /^The result should be "(.+)"$/ do |expected|
  @result.to_s.should == expected
end
