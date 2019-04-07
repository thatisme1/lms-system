# This file is used by Rack-based servers to start the application.
#comment in naster
require ::File.expand_path('../config/environment',  __FILE__)
run Lms::Application
