class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :last_name
      t.string :documentId
      t.string :phone
      t.string :cellphone
      t.references :nation, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
