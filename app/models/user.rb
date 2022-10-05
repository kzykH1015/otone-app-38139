class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    :nikname
    :email
    :password
    :self_introduction
  end

  has_many :likes, dependent: :destroy

  has_many :follow_relations, class_name: 'FollowRelation', foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_follow_relations, class_name: 'FollowRelation', foreign_key: 'follower_id', dependent: :destroy

  has_many :followings, through: :follow_relations, source: :followed
  has_many :followers, through: :reverse_follow_relations, source: :follower

  def follow(user_id)
    follow_relations.create(follower_id: user_id)
  end

  def unfolloew(user_id)
    follow_relations.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
