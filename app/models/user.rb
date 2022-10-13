class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :email
    validates :password, on: :create
    validates :self_introduction
  end

  has_many :likes, dependent: :destroy

  has_many :follow_relations, class_name: 'FollowRelation', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_follow_relations, class_name: 'FollowRelation', foreign_key: 'followed_id', dependent: :destroy

  has_many :followings, through: :follow_relations, source: :followed
  has_many :followers, through: :reverse_follow_relations, source: :follower

  has_many :recommends, class_name: 'Recommend', foreign_key: 'recommended_id', dependent: :destroy
  has_many :for_recommends, class_name: 'Recommend', foreign_key: 'recommender_id', dependent: :destroy

  has_many :comments, dependent: :destroy
  has_one :spoiler, dependent: :destroy

  def follow(user_id)
    follow_relations.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follow_relations.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def recommendation(user_id)
    recommends.create(recommender_id: user_id)
  end
end
