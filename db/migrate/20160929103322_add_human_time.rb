class AddHumanTime < ActiveRecord::Migration
  def change
    change_table :routes do |i|
      i.column :departure_time, :string
    end
  end
end
