# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    class_name: :User,
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: :Visit,
    foreign_key: :visited_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: :Tagging,
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(short_url: short_url,
                         long_url: long_url,
                         submitter_id: user.id)
  end

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while self.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end

    code
  end

  def num_clicks
    Visit.select('visitor_id').where('visited_url_id = ?', self.id).count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visitors.where('visits.created_at > ?', 1.hour.ago).count
  end
end
