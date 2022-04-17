# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true
  validates :short_url, uniqueness: true
  validate :no_spamming, :nonpremium_max
  
  def no_spamming
    recently_created = ShortenedUrl.all
    .where('user_id = ?', user_id)
    .where('created_at > ?', 1.minutes.ago)
    .count
    
    (errors.add 'More than 5 URLs under a minute!') if recently_created >= 5
  end

  def nonpremium_max
    url_count = User.find_by(id: user_id).submitted_urls.count
    if url_count >= 5
      errors.add 'You need premium membership to create more than 5 URLs.'
    end
  end

  def self.random_code
    url = nil
    until url
      url = SecureRandom.urlsafe_base64
      url = nil if ShortenedUrl.exists?(short_url: url)
    end
    url
  end

  def self.create_from_url(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(short_url: short_url, long_url: long_url, user_id: user.id)
  end

  # First filter: If premium == false and created_at <= n.minutes.ago
  # Second filter: If visited at <= n.minutes ago, if never visited, include.
  # E.g, just replacing the NULL with a workable value.
  def self.prune(n)
    to_prune = ShortenedUrl
    .joins('LEFT JOIN visits ON shortened_urls.id = visits.shortened_url_id')
    .joins('JOIN users ON shortened_urls.user_id = users.id')
    .where('users.premium = false AND shortened_urls.created_at <= ?', n.minutes.ago)
    .group('shortened_urls.id')
    .having('COALESCE(MAX(visits.created_at), ?) <= ?', n.hours.ago, n.minutes.ago)
    .select('shortened_urls.*')
    .destroy_all
  end

  # Whitespace doesn't matter
  # Parentheses matter in SQL
  # For two conditions, use the good ol' IN trick
  def self.prune2(n)
    ShortenedUrl
      .joins(:submitter)
      .joins('LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id')
      .where("(shortened_urls.id IN (
        SELECT shortened_urls.id
        FROM shortened_urls
        JOIN visits
        ON visits.shortened_url_id = shortened_urls.id
        GROUP BY shortened_urls.id
        HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
      ) OR (
        visits.id IS NULL and shortened_urls.created_at < \'#{n.minutes.ago}\'
      )) AND users.premium = \'f\'")
      .destroy_all
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where("visits.created_at > ?", 10.minutes.ago).count
  end

  belongs_to(
    :submitter, 
    class_name: :User, 
    foreign_key: :user_id
  )

  has_many(
    :visits,
    dependent: :destroy
  )

  has_many :visitors,
  Proc.new { distinct },
  through: :visits,
  source: :user

  has_many(
    :taggings,
    dependent: :destroy
  )
end
