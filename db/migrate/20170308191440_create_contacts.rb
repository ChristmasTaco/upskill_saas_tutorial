class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      # Each of these are columns in our DB table
      t.string :name
      t.string :email
      t.text :comments
      t.timestamps
    end
  end
end



