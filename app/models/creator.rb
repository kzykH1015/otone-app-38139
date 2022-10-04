class Creator < ApplicationRecord
  has_many :content_creator_relations
  has_many :content, through: :content_creator_relations
end
