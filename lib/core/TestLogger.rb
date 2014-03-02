module Log
	def self.Info(message)
		puts message
	end

	def self.Failed(message, actual="---", expect="---")
		details = message
		
		if actual != "---" and expect != "---"
			details = "#{message}\nactual: '#{actual}'\nexpect: '#{expect}'\n"
		end

		raise details
	end
end