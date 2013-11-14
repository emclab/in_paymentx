# This migration comes from kustomerx (originally 20131013212912)
class CreateKustomerxContacts < ActiveRecord::Migration
  def change
    create_table :kustomerx_contacts do |t|
      t.integer :customer_id
      t.string :name
      t.string :position
      t.string :phone
      t.string :cell_phone
      t.string :email
      t.text :brief_note

      t.timestamps
    end
    
    add_index :kustomerx_contacts, :customer_id
  end
end
