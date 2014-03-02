require_relative './TestEngine'

## ------------------------------------------------------
##  Given steps definition
## ------------------------------------------------------

Given "User has [$page_name] page open" do |page_name|
	page = TestEngine.FindPage(page_name)
 	page.Go()
end

## ------------------------------------------------------
##  When steps definition
## ------------------------------------------------------

When "User enters '$value' to the [$element_name]" do |value, element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.SendKeys(value)
end

When "User clicks the [$element_name]" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.Click
end

When "User selects the [$element_name]" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.Click
end

When "User selects '$value' on the [$element_name]" do |value, element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.SelectItem(value)
end

When "User checks the [$element_name]" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.Check
end

When "User unchecks the [$element_name]" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.Uncheck
end

## ------------------------------------------------------
##  Then steps definition
## ------------------------------------------------------

Then "The browser shows [$page_name] page" do |page_name|
	page = TestEngine.FindPage(page_name)
	page.VerifyURL
end

Then "The [$element_name] exists" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.Exists
end

Then "The [$element_name] does not exist" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.NotExists
end

Then "The [$element_name] value is empty" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsEmpty
end

Then "The [$element_name] value is not empty" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsNotEmpty
end

Then "The [$element_name] value is '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIs(value)
end

Then "The [$element_name] value is not '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsNot(value)
end

Then "The [$element_name] value contains '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueContains(value)
end

Then "The [$element_name] value is more than '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsMoreThan(value)
end

Then "The [$element_name] value is more than or equal '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsMoreThanOrEqual(value)
end

Then "The [$element_name] value is less than '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsLessThan(value)
end

Then "The [$element_name] value is less than or equal '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsLessThanOrEqual(value)
end

Then "The [$element_name] value is between '$value1' and '$value2'" do |element_name, value1, value2|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.ValueIsBetween(value1, value2)
end

Then "The [$element_name] has item '$value'" do |element_name, value|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.HasItem(value)
end

Then "The [$element_name] is selected" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.IsSelected
end

Then "The [$element_name] is not selected" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.IsNotSelected
end

Then "The [$element_name] is checked" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.IsChecked
end

Then "The [$element_name] is unchecked" do |element_name|
	element = TestEngine.CurrentPage.FindElement(element_name)
	element.IsUnchecked
end
