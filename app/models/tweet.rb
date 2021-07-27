class Tweet < ApplicationRecord
  validates :content, presence: true, length: { maximum: 500 }

  belongs_to :user
end
