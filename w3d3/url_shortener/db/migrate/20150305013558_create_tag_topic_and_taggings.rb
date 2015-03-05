class CreateTagTopicAndTaggings < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic

      t.timestamp
    end

    create_table :taggings do |t|
      t.integer :topic_id
      t.integer :url_id

      t.timestamp
    end
  end
end
