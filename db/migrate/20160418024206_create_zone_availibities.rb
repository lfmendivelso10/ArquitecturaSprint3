class CreateZoneAvailibities < ActiveRecord::Migration
  def change
    create_table :zone_availibities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
