require 'rails'
require 'dd_wrapper/generators'

namespace :dd_wrapper do
  desc 'Generates dd_wrapper.rb inside initializer config/initializers'
  task setup: :environment do |_t, args|
    # initializer 'dd_wrapper.rb' do
    #   "puts 'this is the beginning'"
    # end
    # # create_file "config/initializers/dd_wrapper.rb", "# Add initialization content here"

    # class MyRailtie < Rails::Railtie
    #   initializer "my_railtie.configure_rails_initialization" do
    #     # some initialization behavior
    #   end
    # end
    DdWrapper::Generators.gen
  end
end
