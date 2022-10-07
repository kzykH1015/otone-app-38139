class RecommendsController < ApplicationController
  def new
    @contents = Content.all
    @user = User.find(params[:user_id])
  end
  
  def create
    @recommend = Recommend.new(recommend_params)
    if @recommend.save
      redirect_to root_path
    end
  end

  def destroy
  end

  private
  def recommend_params
    params.permit(:recommended_id, :recommender_id, :content_id)
  end

end
