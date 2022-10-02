class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: "アニメ"},
    { id: 2, name: "漫画"},
    { id: 3, name: "ゲーム"},
    { id: 4, name: "小説"},
    { id: 5, name: "ライトノベル"},
    { id: 6, name: "映画"}
  ]
  include ActiveHash::Associations
  has_many :content
end