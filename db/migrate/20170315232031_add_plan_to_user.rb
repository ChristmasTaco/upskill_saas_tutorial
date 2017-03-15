class AddPlanToUser < ActiveRecord::Migration[5.0]
  def change
    # Adds a column to the Users table called plan_id, which is an integer 
    add_column :users, :plan_id, :integer
  end
end
