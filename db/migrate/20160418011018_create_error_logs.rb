class CreateErrorLogs < ActiveRecord::Migration
  def change
    create_table :error_logs do |t|
      t.string :worker
      t.text :data

      t.timestamps null: false
    end
  end
end
