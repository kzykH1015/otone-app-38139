class Recommend < ApplicationRecord
  belongs_to :content, class_name: "Content"
  belongs_to :recommended, class_name: "User"
  belongs_to :recommender, class_name: "User"
end
