class Content < ApplicationRecord
  belongs_to :user

  has_many :content_genre_relations
  has_many :genre, through: :content_genre_relations
  has_many :content_creator_relations
  has_many :creator, through: :content_creator_relations
end
