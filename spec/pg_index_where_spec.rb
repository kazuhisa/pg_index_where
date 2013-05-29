require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'ActiveRecord::ConnectionAdapters::SchemaStatements.add_index' do
  before do
    ActiveRecord::Migrator.migrate(%w(spec/db/migrate), nil)
  end
  context 'migration is performed.' do
    subject do
      sql = "select pg_get_indexdef(relfilenode) from pg_class where relname = 'customers_idx01'"
      ActiveRecord::Base.connection.execute(sql)[0]
    end
    its(['pg_get_indexdef']){should =~ /where.+deleted_at IS NULL/i}
  end

  describe 'Tests for acts_as_paranoid' do
    context 'Insertion on a table' do
      it do
        expect do
          Customer.create(:code => '001', :name => 'Yukari Tamura')
          Customer.create(:code => '002', :name => 'Nana Mizuki')
        end.to change{Customer.scoped.size}.from(0).to(2)
      end
    end
    context 'When a deleted code is inserted.' do
      before do
        Customer.destroy_all(:code => '001')
      end
      it do
        expect do
          Customer.create(:code => '001', :name => 'Yui Horie')
        end.to change{Customer.scoped.size}.from(1).to(2)
      end

      context 'When the duplicate code is inserted.' do
        before do
          Customer.create(:code => '001', :name => 'Yui Horie')
        end
        it do
          expect do
            Customer.create!(:code => '001', :name => 'Yukari Tamura')
          end.to raise_error(ActiveRecord::RecordNotUnique)
        end
      end
    end
  end

  describe 'ActiveRecord::SchemaDumper.dump' do
    before do
      filename = 'spec/db/schema.rb'
      File.open(filename, 'w:utf-8') do |file|
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
    subject{open('spec/db/schema.rb','r').read}
    it{should =~ /:where => "\(deleted_at IS NULL\)"/}
  end
end

