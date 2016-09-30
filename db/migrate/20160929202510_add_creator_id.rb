class AddCreatorId < ActiveRecord::Migration
  def change
    change_table :routes do |t|
      t.column :creator_id, :integer
    end
  end
end
