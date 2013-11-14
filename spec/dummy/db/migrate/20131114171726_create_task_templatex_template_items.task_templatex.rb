# This migration comes from task_templatex (originally 20131102234001)
class CreateTaskTemplatexTemplateItems < ActiveRecord::Migration
  def change
    create_table :task_templatex_template_items do |t|
      t.integer :template_id
      t.integer :task_definition_id
      t.integer :execution_order
      t.integer :execution_sub_order
      t.boolean :start_before_previous_completed, :default => false
      t.text :brief_note
      t.boolean :need_request, :default => false

      t.timestamps
    end
    
    add_index :task_templatex_template_items, :template_id
    add_index :task_templatex_template_items, :task_definition_id
  end
end
