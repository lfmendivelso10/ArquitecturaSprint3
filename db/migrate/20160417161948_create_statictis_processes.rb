class CreateStatictisProcesses < ActiveRecord::Migration
  def change
    create_table :statictis_processes do |t|
      t.string :collarId
      t.string :d_unmarshaller_begin
      t.string :d_unmarshaller_end
      t.string :d_businesslogic_begin
      t.string :d_businesslogic_end
      t.string :d_output_begin
      t.string :d_output_end
      t.integer :notify
      t.integer :t_unmarshaller
      t.integer :t_inredis_queue
      t.integer :t_businesslogic
      t.integer :t_insqs_queue
      t.integer :t_output
      t.integer :t_process
      t.integer :t_perception

      t.timestamps null: false
    end
  end
end
