class Tweet < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favoriters, through: :favorites, source: :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
