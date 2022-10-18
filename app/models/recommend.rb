class Recommend < ApplicationRecord
  with_options presence: true do
    validates :content_id
    validates :recommended_id
    validates :recommender_id
  end

  belongs_to :recommended, class_name: 'User'
  belongs_to :recommender, class_name: 'User'
end
