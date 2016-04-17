class CreateTransactionLogs < ActiveRecord::Migration
  def change
    create_table :transaction_logs do |t|
      t.string :component
      t.text :data
      t.string :status

      t.timestamps null: false
    end
  end
end
