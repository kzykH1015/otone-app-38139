class RecommendsController < ApplicationController
  def new
    @contents = Content.all
    @user = User.find(params[:user_id])
  end

  def create
    @recommend = Recommend.new(recommend_params)
    redirect_to root_path if @recommend.save
  end

  def destroy
    @recommend = Recommend.find(params[:id])
    @recommend.destroy
    redirect_to root_path
  end

  private

  def recommend_params
    params.permit(:recommended_id, :recommender_id, :content_id)
  end
end
