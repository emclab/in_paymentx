# This migration comes from kustomerx (originally 20131013212837)
class CreateKustomerxAddresses < ActiveRecord::Migration
  def change
    create_table :kustomerx_addresses do |t|
      t.string :province
      t.string :city_county_district
      t.string :add_line
      t.integer :customer_id

      t.timestamps
    end
    
    add_index :kustomerx_addresses, :customer_id
  end
end
