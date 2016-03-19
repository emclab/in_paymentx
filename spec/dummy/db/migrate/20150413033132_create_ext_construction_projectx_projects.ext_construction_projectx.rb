# This migration comes from ext_construction_projectx (originally 20140402171404)
class CreateExtConstructionProjectxProjects < ActiveRecord::Migration
  def change
    create_table :ext_construction_projectx_projects do |t|
      t.string :name
      t.text :project_desp
      t.integer :customer_id
      t.integer :status_id
      t.integer :category_id
      t.text :construction_address
      t.text :customer_contact
      t.text :construction_spec
      t.text :other_spec
      t.text :turn_over_requirement
      t.boolean :completed, :default => false
      t.boolean :awarded, :default => false
      t.date :construction_start_date
      t.date :construction_finish_date
      t.date :turn_over_date
      t.string :project_num
      t.boolean :cancelled, :default => false
      t.integer :last_updated_by_id
      t.text :note
      t.timestamps
      t.integer :sales_id
      t.integer :project_coordinator_id
      t.string :fort_token
    end
    
    add_index :ext_construction_projectx_projects, :customer_id
    add_index :ext_construction_projectx_projects, :status_id
    add_index :ext_construction_projectx_projects, :project_num
    add_index :ext_construction_projectx_projects, :completed
    add_index :ext_construction_projectx_projects, :cancelled
    add_index :ext_construction_projectx_projects, :awarded
    add_index :ext_construction_projectx_projects, :name
    add_index :ext_construction_projectx_projects, :sales_id
    add_index :ext_construction_projectx_projects, :project_coordinator_id, :name => :ext_construction_projectx_coordinator
  end
end
