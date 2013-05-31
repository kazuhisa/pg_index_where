class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :code

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
