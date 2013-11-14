# This migration comes from simple_typex (originally 20131101175402)
class CreateSimpleTypexTypes < ActiveRecord::Migration
  def change
    create_table :simple_typex_types do |t|
      t.string :name
      t.boolean :active, :default => true
      t.text :brief_note
      t.integer :last_updated_by_id
      t.integer :ranking_order

      t.timestamps
    end
    
    add_index :simple_typex_types, :name
    add_index :simple_typex_types, :active
    add_index :simple_typex_types, :ranking_order
  end
end
