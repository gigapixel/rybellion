require 'uri'
require 'yaml'
require 'watir-webdriver'

require 'timeout'

require_relative './TestLogger'

class Element
	attr_accessor :name, :xpath

	def initialize(page, object)
		@page = page
		@name = object['name']
		@xpath = object['xpath']
	end

	##
	## Basic element properties
	##

	def get
		return @page.browser.element(:xpath => @xpath)
	end

	def value
		element = self.get
		
		if element.tag_name == 'select'
			select = self.get_select

			text = []
			for option in select.selected_options
				text << option.text
			end

			return text.join('\n')
		elsif ['input', 'button'].include? element.tag_name
			return element.value
		else
			return element.text
		end
	end

	def exists
		element = self.get
		
		if element.exists?
			return true
		else
			return false
		end
	end

	def enabled
		return false
	end

	def get_checkbox
		element = self.get

		if element.tag_name == 'input' and element.attribute_value('type') == 'checkbox'
			checkbox = @page.browser.checkbox(:xpath => @xpath)
			return checkbox
		end

		Log.Failed("The element '#{@name}' is not type 'checkbox'\n")
		return nil
	end

	def get_radio
		element = self.get

		if element.tag_name == 'input' and element.attribute_value('type') == 'radio'
			radio = @page.browser.radio(:xpath => @xpath)
			return radio
		end

		Log.Failed("The element '#{@name}' is not type 'radio'\n")
		return nil
	end

	def get_select
		element = self.get

		if element.tag_name == 'select'
			select = @page.browser.select_list(:xpath => @xpath)
			return select
		end

		Log.Failed("The element '#{@name}' is not type 'select'\n")
		return nil
	end

	##
	## Action methods
	##

	def SendKeys(value)
		element = self.get
		element.send_keys(value)
		return true
	end

	def Click()
		element = self.get
		element.click
		return true
	end

	#def Select() ## for radio button
	#	radio = self.get_radio
	#	radio.set
	#	return true
	#end

	def SelectItem(value) ## for select list
		select = self.get_select
		select.select(value)
		return true
	end

	def Check()
		checkbox = self.get_checkbox
		checkbox.set
		return true
	end

	def Uncheck()
		checkbox = self.get_checkbox
		checkbox.clear
		return true
	end

	##
	## Verification methods will raise error if failed, don't use for check condition logic
	##

	def Exists()
		if self.exists
			return true
		end

		Log.Failed("Value not matched", '<not exists>', '<exists>')
		return false
	end

	def NotExists()
		if not self.exists
			return true
		end

		Log.Failed("Value not matched", '<exists>', '<not exists>')
		return false
	end

	def ValueIsEmpty()
		if self.value == ''
			return true
		end

		Log.Failed("Value not matched", self.value, '<empty>')
		return false
	end

	def ValueIsNotEmpty()
		if self.value != ''
			return true
		end

		Log.Failed("Value not matched", '<empty>', '<not empty>')
		return false
	end

	def ValueIs(value)
		if self.value == value
			return true
		end

		Log.Failed("Value not matched", self.value, value)
		return false
	end

	def ValueIsNot(value)
		if self.value != value
			return true
		end

		Log.Failed("Value not matched", self.value, value)
		return false
	end

	def ValueContains(value)
		if self.value.include? value
			return true
		end

		Log.Failed("Value not matched", self.value, value)
		return false
	end

	def ValueIsMoreThan(value)
		if self.value > value
			return true
		end

		Log.Failed("Value not matched", self.value, "( x > #{value} )")
		return false
	end

	def ValueIsMoreThanOrEqual(value)
		if self.value >= value
			return true
		end

		Log.Failed("Value not matched", self.value, "( x >= #{value} )")
		return false
	end

	def ValueIsLessThan(value)
		if self.value < value
			return true
		end

		Log.Failed("Value not matched", self.value, "( x < #{value} )")
		return false
	end

	def ValueIsLessThanOrEqual(value)
		if self.value <= value
			return true
		end

		Log.Failed("Value not matched", self.value, "( x <= #{value} )")
		return false
	end

	def ValueIsBetween(value1, value2)
		if value1 < value2
			if self.value >= value1 and self.value <= value2
				return true
			end
		else
			if self.value <= value1 and self.value >= value2
				return true
			end
		end

		Log.Failed("Value not matched", self.value, " x in (#{value1} - #{value2})")
		return false
	end

	def HasItem(value)
		select = self.get_select

		options = []
		for option in select.options
			options << option.text
		end

		if options.include? value
			return true
		end

		Log.Failed("Item not found in list", "\n\t" + options.join("\n\t"), value)
		return false
	end

	def IsSelected()
		radio = self.get_radio

		if radio.set?
			return true
		end

		Log.Failed("Value not matched", '<not selected>', '<selected>')
		return false
	end

	def IsNotSelected()
		radio = self.get_radio

		if not radio.set?
			return true
		end

		Log.Failed("Value not matched", '<selected>', '<not selected>')
		return false
	end

	def IsChecked()
		checkbox = self.get_checkbox

		if checkbox.set?
			return true
		end

		Log.Failed("Value not matched", '<not checked>', '<checked>')
		return false
	end

	def IsUnchecked()
		checkbox = self.get_checkbox

		if not checkbox.set?
			return true
		end

		Log.Failed("Value not matched", 'checked>', '<unchecked>')
		return false
	end
end


class Page
	attr_accessor :name, :url, :title, :elements, :browser

	def initialize(browser, pageobject)
		@browser = browser
		@name = pageobject['page']['name']
		@url = pageobject['page']['url']
		@title = pageobject['page']['title']

		@elements = Hash.new

		if pageobject.key? 'elements'
			for object in pageobject['elements']
				element = Element.new(self, object)

				if @elements.key? element.name
					Log.Info "#{@name}\nDuplicate element name: '#{element.name}'"
				else
					@elements[element.name] = element
				end
			end
		end
	end

	def Go()
		begin
			@browser.goto @url
		rescue Timeout::Error
			raise "Page load timeout\nURL: #{@url} (15 sec)\n"
		end

		return true
	end

	def FindElement(name)
		if @elements.key? name
			return @elements[name]
		end

		raise "Element not found in list: '#{name}'\n"
		return nil
	end

	def VerifyTitle()
		@browser.windows.last.use

		if @title == @browser.title
			return true
		end

		Log.Failed("Title not matched", @browser.title, @title)
		return false
	end
	
	def VerifyURL()
		@browser.windows.last.use

		uri = URI(@url)
		url = "#{uri.scheme}://#{uri.host}#{uri.path}"
		
		begin
			Watir::Wait.until(15) { browser.url.include? url }
			return true
		rescue
			Log.Failed("URL not matched", @browser.url, url)
			return false
		end
	end
end
