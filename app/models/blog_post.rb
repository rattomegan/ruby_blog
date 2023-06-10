class BlogPost < ApplicationRecord
  # This goes in a separate database table and it sets up association between the two tables
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

# second argument is secondary sorting
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_last).order(updated_at: :desc)}
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def format_date
    published_at? ? published_at.strftime('%m.%d.%Y') : ''
  end
end
