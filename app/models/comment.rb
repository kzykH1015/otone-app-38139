class Comment < ApplicationRecord
  validates :comment_text, presence: true

  belongs_to :user
  belongs_to :content
end
