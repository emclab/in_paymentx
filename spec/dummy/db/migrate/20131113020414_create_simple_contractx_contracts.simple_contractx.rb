# This migration comes from simple_contractx (originally 20131106193937)
class CreateSimpleContractxContracts < ActiveRecord::Migration
  def change
    create_table :simple_contractx_contracts do |t|
      t.integer :project_id
      t.string :contract_num
      t.decimal :contract_total, :precision => 10, :scale => 2
      t.text :payment_agreement
      t.integer :payment_term
      t.boolean :paid_out, :default => false
      t.boolean :signed, :default => false
      t.date :sign_date
      t.integer :signed_by_id
      t.boolean :contract_on_file, :default => false
      t.boolean :void, :default => false
      t.integer :last_updated_by_id
      t.text :note

      t.timestamps
    end
    
    add_index :simple_contractx_contracts, :project_id
    add_index :simple_contractx_contracts, :void
    add_index :simple_contractx_contracts, :contract_num
  end
end
