class Content < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category

  has_many :content_genre_relations
  has_many :genre, through: :content_genre_relations
  has_many :content_creator_relations
  has_many :creator, through: :content_creator_relations
  has_many :likes, dependent: :destroy

  def liked?(user)
    likes.where(user_id: user.id).exists?
  end
end
