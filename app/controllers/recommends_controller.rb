class RecommendsController < ApplicationController
  before_action :find_item, only: [:new, :create]

  def new
    @user = User.find(params[:user_id])
    @contents = Content.all
    @recommend = Recommend.new
  end
  
  def create
    @recommend = Recommend.new(recommend_params)
    if @recommend.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  
  def destroy
    @recommend = Recommend.find(params[:id])
    @recommend.destroy
    redirect_to user_path(@recommend.recommended_id)
  end
  
  private
  
  def find_item
    @user = User.find(params[:user_id])
    @contents = Content.all
  end

  def recommend_params
    params.require(:recommend).permit(:recommended_id, :recommender_id, :content_id)
  end
end
