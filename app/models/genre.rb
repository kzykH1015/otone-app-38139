class Genre < ApplicationRecord
  has_many :content_genre_relations
  has_many :contents, through: :content_genre_relations

  validates :genre_name, uniqueness: true
end
