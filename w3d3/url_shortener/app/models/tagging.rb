class Tagging < ActiveRecord::Base
  validates :topic_id, presence: true, uniqueness: true
  validates :url_id, presence: true, uniqueness: true

  belongs_to(
    :tag_topic,
    class_name: :TagTopic,
    foreign_key: :topic_id,
    primary_key: :id
  )

  belongs_to(
    :shortened_url,
    class_name: :ShortenedUrl,
    foreign_key: :url_id,
    primary_key: :id
  )
end
