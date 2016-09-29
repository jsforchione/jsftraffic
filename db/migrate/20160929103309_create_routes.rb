class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :origin 
      t.string :destination
      t.string :duration_text
      t.integer :duration_value
      t.string :distance_text
      t.integer :distance_value 

      t.timestamps
    end 
  end
end