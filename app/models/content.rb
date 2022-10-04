class Content < ApplicationRecord
  belongs_to :user

  has_many :content_genre_relations
  has_many :genre, through: :content_genre_relations
end
