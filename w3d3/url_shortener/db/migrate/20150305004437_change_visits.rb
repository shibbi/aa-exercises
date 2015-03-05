class ChangeVisits < ActiveRecord::Migration
  def change
    remove_index :visits, :visitor_id
    add_index :visits, :visitor_id
    remove_index :visits, :visited_url_id
    add_index :visits, :visited_url_id
  end
end
