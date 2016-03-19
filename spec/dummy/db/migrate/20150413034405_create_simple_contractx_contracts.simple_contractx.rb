# This migration comes from simple_contractx (originally 20131106193937)
class CreateSimpleContractxContracts < ActiveRecord::Migration
  def change
    create_table :simple_contractx_contracts do |t|
      t.integer :project_id      
      t.decimal :contract_total, :precision => 10, :scale => 2
      t.decimal :other_charge, :precision => 10, :scale => 2
      t.integer :payment_term
      t.text :payment_agreement
      t.boolean :paid_out, :default => false
      t.boolean :signed, :default => false
      t.date :sign_date
      t.integer :signed_by_id
      t.boolean :contract_on_file, :default => false
      t.integer :last_updated_by_id     
      t.timestamps
      t.string :contract_num
      t.boolean :void, :default => false
      t.text :note
      t.decimal :executed_contract_total, :precision => 10, :scale => 2
      t.string :fort_token
    end
    
    add_index :simple_contractx_contracts, :project_id
    add_index :simple_contractx_contracts, :void
    add_index :simple_contractx_contracts, :contract_num
  end
end
