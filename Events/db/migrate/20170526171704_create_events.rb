class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :kind

      t.timestamps
    end
  end
end
