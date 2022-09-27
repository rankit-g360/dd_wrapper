require 'dd_wrapper'
require 'rails/generators'

module DdWrapper
  class Generators < Rails::Generators::Base
    def self.gen
      create_file "config/initializers/dd_wrapper.rb", "# Add initialization content here"
    end
  end
end
