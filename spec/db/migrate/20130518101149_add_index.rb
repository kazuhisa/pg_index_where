class AddIndex < ActiveRecord::Migration
  def up
    add_index :customers, :code, :name => 'customers_idx01', :unique => true, :where => 'deleted_at IS NULL'
  end

  def down
    remove_index :customers, :name => 'customers_idx01'
  end
end
