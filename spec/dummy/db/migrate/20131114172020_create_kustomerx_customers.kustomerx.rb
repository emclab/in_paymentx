# This migration comes from kustomerx (originally 20131013205152)
class CreateKustomerxCustomers < ActiveRecord::Migration
  def change
    create_table :kustomerx_customers do |t|
      t.string :name
      t.string :short_name
      t.date :since_date
      t.text :shipping_instruction
      t.integer :zone_id
      t.integer :customer_status_category_id
      t.string :phone
      t.string :fax
      t.integer :sales_id
      t.boolean :active, :default => true
      t.integer :last_updated_by_id
      t.integer :quality_system_id
      t.string :employee_num
      t.string :revenue
      t.text :customer_eval
      t.text :main_biz
      t.text :customer_specific
      t.text :note
      t.string :web

      t.timestamps
    end
    
    add_index :kustomerx_customers, :name
    add_index :kustomerx_customers, :since_date
    add_index :kustomerx_customers, :sales_id
    add_index :kustomerx_customers, :zone_id
    add_index :kustomerx_customers, :active
  end
end
