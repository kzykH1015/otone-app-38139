class SpoilerSelect < ActiveHash::Base
  self.data = [
    { id: 1, name: '表示しない' },
    { id: 2, name: '表示する' }
  ]
  include ActiveHash::Associations
  has_many :users
end
