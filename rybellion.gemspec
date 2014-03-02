Gem::Specification.new do |s|
	s.name        = "rybellion"
	s.version     = "0.0.1"
	s.summary     = "Initial version"
	s.date        = "2014-03-02"
	s.description = "A tester-friendly web automated testing framework."
	s.license     = "MIT"
	s.homepage    = "https://github.com/gigapixel/rybellion"
	s.authors     = ["Peerapat Sungkasem"]
	s.email       = ["gigapixel7@gmail.com"]
	s.files       = [
		"lib/rybellion.rb", 
		"lib/core/TestEngine.rb", 
		"lib/core/TestLogger.rb",
		"lib/core/PageObject.rb",
		"lib/core/CommonSteps.rb"
	]
end