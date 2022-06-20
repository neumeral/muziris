class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :transaction_id
      t.string :order_id, null: false
      t.string :status, null: false
      t.string :payment_gateway, null: false

      t.timestamps
    end
  end
end
