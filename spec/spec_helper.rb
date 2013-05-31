$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rails'
require 'rspec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
require File.join(File.dirname(__FILE__), 'fake_app')

require 'rspec/rails'

RSpec.configure do |config|
  config.before :all do
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Migrator.rollback(%w(spec/db/migrate), 2)
  end
end
