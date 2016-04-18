class CreateStatictisJournalers < ActiveRecord::Migration
  def change
    create_table :statictis_journalers do |t|
      t.string :collarId
      t.string :d_unmarshaller_begin
      t.string :d_unmarshaller_end
      t.string :d_journaler_begin
      t.string :d_journaler_end
      t.integer :t_unmarshaller
      t.integer :t_inredis_queue
      t.integer :t_journaler
      t.integer :t_process
      t.integer :t_perception

      t.timestamps null: false
    end
  end
end
