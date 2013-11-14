# This migration comes from fixed_task_projectx (originally 20131101022142)
class CreateFixedTaskProjectxProjects < ActiveRecord::Migration
  def change
    create_table :fixed_task_projectx_projects do |t|
      t.string :name
      t.string :project_num
      t.integer :task_template_id
      t.integer :customer_id
      t.text :project_desp
      t.integer :sales_id
      t.date :start_date
      t.date :end_date
      t.date :delivery_date
      t.date :est_delivery_date
      t.text :instruction
      t.integer :project_manager_id
      t.boolean :cancelled
      t.boolean :completed
      t.integer :last_updated_by_id
      t.boolean :expedite
      t.integer :status_id

      t.timestamps
    end
    
    add_index :fixed_task_projectx_projects, :name
    add_index :fixed_task_projectx_projects, :start_date
    add_index :fixed_task_projectx_projects, :customer_id
    add_index :fixed_task_projectx_projects, :sales_id
    add_index :fixed_task_projectx_projects, :status_id
    add_index :fixed_task_projectx_projects, :project_manager_id
    add_index :fixed_task_projectx_projects, :task_template_id
    
  end
end
