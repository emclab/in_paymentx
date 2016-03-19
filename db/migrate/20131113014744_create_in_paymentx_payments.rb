class CreateInPaymentxPayments < ActiveRecord::Migration
  def change
    create_table :in_paymentx_payments do |t|
      t.integer :contract_id
      t.decimal :paid_amount, :precision => 10, :scale => 2
      t.date :received_date
      t.integer :received_by_id
      t.text :brief_note
      t.string :payment_via
      t.integer :last_updated_by_id
      t.timestamps
      t.integer :project_id
      t.integer :category_id
      t.integer :bank_acct_id
      t.integer :payer_id
      t.string :fort_token
      
    end
    
    add_index :in_paymentx_payments, :contract_id
    add_index :in_paymentx_payments, :project_id
    add_index :in_paymentx_payments, :received_by_id
    add_index :in_paymentx_payments, :payment_via
    add_index :in_paymentx_payments, :received_date
    add_index :in_paymentx_payments, :category_id
    add_index :in_paymentx_payments, :bank_acct_id
    add_index :in_paymentx_payments, :payer_id
    add_index :in_paymentx_payments, :fort_token
  end
end
