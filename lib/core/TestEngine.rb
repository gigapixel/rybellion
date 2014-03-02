require 'yaml'
require 'watir-webdriver'

require_relative './PageObject'


module TestEngine

	@@browser = nil
	@@current_page = nil

	@@pages = Hash.new

	def self.OpenBrowser(browser="default")
		if browser.downcase == 'chrome'
			@@browser = Watir::Browser.new :chrome
		elsif browser.downcase == 'firefox'
			@@browser = Watir::Browser.new :firefox
		else
			@@browser = Watir::Browser.new
		end
	end

	def self.CloseBrowser()
		@@browser.close
	end

	def self.LoadPageDefinitions(path)
		if not @@pages.empty?
			return true
		end

		for filename in Dir.glob(path)
			pageobject = YAML.load_file(filename)
			page = Page.new(@@browser, pageobject)
			
			if @@pages.key? page.name
				raise "Duplicate page name: '#{page.name}'\n"
			else
				@@pages[page.name] = page
			end
		end
	end

	def self.FindPage(name)
		if @@pages.key? name
			@@current_page = @@pages[name]
			return @@current_page
		end

		raise "Page not found in list: '#{name}'\n"
		return nil
	end

	def self.CurrentPage
		return @@current_page
	end

end
