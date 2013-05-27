require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'ActiveRecord::ConnectionAdapters::SchemaStatements.add_index' do
  before do
    ActiveRecord::Migrator.migrate(%w(spec/db/migrate), nil)
  end
  it {1.should == 1}

  describe 'ActiveRecord::SchemaDumper.dump' do
    before do
      filename = 'spec/db/schema.rb'
      File.open(filename, 'w:utf-8') do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
    it {1.should == 1}
  end
end

