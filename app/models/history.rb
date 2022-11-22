class History < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :content, optional: true

  with_options presence: true do
    validates :user_id
    validates :content_id
    validates :message
  end

  class << self
    def create_log(content_id, user_id, message)
      @user = User.find(user_id)
      History.create(content_id: content_id, user_id: user_id,
                     message: "#{@user.nickname}が#{message}を編集しました")
    end
  end
end
