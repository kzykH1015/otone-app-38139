class CreatorCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '監督' },
    { id: 2, name: '脚本' },
    { id: 3, name: '著者' },
    { id: 4, name: '原作' },
    { id: 5, name: '制作会社' },
    { id: 6, name: '俳優・声優' }
  ]
  include ActiveHash::Associations
  has_many :content
end
