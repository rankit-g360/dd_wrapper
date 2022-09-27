require 'dd_wrapper'
require 'rails'

module DdWrapper
  class Railtie < Rails::Railtie
    railtie_name :dd_wrapper

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }      
    end
  end
end
