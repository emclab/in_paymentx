# This migration comes from fixed_task_projectx (originally 20131106045340)
class CreateFixedTaskProjectxContracts < ActiveRecord::Migration
  def change
    create_table :fixed_task_projectx_contracts do |t|
      t.integer :project_id
      t.decimal :contract_amount, :precision => 10, :scale => 2
      t.decimal :other_charge, :precision => 10, :scale => 2
      t.text :payment_agreement
      t.boolean :paid_out, :default => false
      t.boolean :signed, :default => false
      t.date :sign_date
      t.integer :signed_by_id
      t.boolean :contract_on_file
      t.integer :last_updated_by_id

      t.timestamps
    end
    
    add_index :fixed_task_projectx_contracts, :project_id
  end
end
