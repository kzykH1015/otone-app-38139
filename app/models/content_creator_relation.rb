class ContentCreatorRelation < ApplicationRecord
  belongs_to :content
  belongs_to :creator
end
