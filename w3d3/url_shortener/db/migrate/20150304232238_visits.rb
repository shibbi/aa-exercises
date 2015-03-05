class Visits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.integer :visited_url_id

      t.timestamps
    end

    add_index :visits, :visitor_id, unique: true
    add_index :visits, :visited_url_id, unique: true
  end
end
