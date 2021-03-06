Rybellion Framework
===================
A tester-friendly web automated testing framework.

About
-----
Rybellion framework provide easier way to write your web automation tests, no coding skills required, just focus on your test scenario.

Prerequisite
------------
1. Ensure your test machine has Firefox installed.
2. Ensure your test machine has Ruby installed and available to use gem command.
   * For ruby installation, please check: https://www.ruby-lang.org/en/installation/
   * For Windows user, you need to install DevKit for build cucumber, download from: http://rubyinstaller.org/downloads/

Installation
------------
You can install required gem pacakages by following command:
```
  gem update --system
  gem install selenium-webdriver
  gem install watir-webdriver
  gem install cucumber
  gem install rybellion
```
For Windows user you need to install ansicon to make color on console for cucumber.
* You can download ansicon here: [adoxa/ansicon](https://github.com/adoxa/ansicon/downloads)
* Installation instructions see: [ANSI escape sequence support with ansicon](http://www.kevwebdev.com/blog/in-search-of-a-better-windows-console-using-ansicon-console2-and-git-bash.html#ansicon)

Dependencies
------------
* [cucumber](http://rubygems.org/gems/cucumber) (tested on v1.3.10)
* [watir-webdriver](http://rubygems.org/gems/watir-webdriver) (tested on v0.6.8)
* [selenium-webdriver](http://rubygems.org/gems/selenium-webdriver) (tested on v2.40.0)

How to use it
-------------
Please see demo project on [rybellion-test](https://github.com/gigapixel/rybellion-test)
