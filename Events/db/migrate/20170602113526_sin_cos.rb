class SinCos < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :cos_lat, :float
    add_column :events, :sin_lat, :float
    add_column :events, :cos_lng, :float
    add_column :events, :sin_lng, :float
  end
end
