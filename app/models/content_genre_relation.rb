class ContentGenreRelation < ApplicationRecord
  belongs_to :content
  belongs_to :genre
end
