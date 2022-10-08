class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @contents = Content.where(user_id: @user.id)
    @recommends = Recommend.where(recommended_id: @user.id)
  end
end
