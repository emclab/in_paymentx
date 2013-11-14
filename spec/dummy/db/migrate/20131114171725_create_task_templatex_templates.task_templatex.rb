# This migration comes from task_templatex (originally 20131101211957)
class CreateTaskTemplatexTemplates < ActiveRecord::Migration
  def change
    create_table :task_templatex_templates do |t|
      t.string :name
      t.integer :type_id
      t.boolean :active, :default => true
      t.integer :last_updated_by_id
      t.text :instruction
      t.integer :ranking_order

      t.timestamps
    end
    
    add_index :task_templatex_templates, :type_id
    add_index :task_templatex_templates, :active
  end
end
