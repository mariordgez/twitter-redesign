class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 20 }
  validates :username, presence: true, length: { maximum: 20 }
  has_many :tweets
  has_many :followings
  has_many :inverse_followings,
           class_name: 'Following',
           foreign_key: 'following_id'
  def follows
    follows_array = followings.map(&:following)
    follows_array.compact
  end

  def inverse_follows
    inverse_follows_array = inverse_followings.map(&:user)
    inverse_follows_array.compact
  end

  def following?(user)
    follows.include?(user)
  end

  def followed?(user)
    inverse_follows.include?(user)
  end
end
