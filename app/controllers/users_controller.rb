class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @contents = Content.where(user_id: @user.id)
  end
end
