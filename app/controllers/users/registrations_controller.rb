# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user]["password"]
    @spoiler = @user.build_spoiler
    render :new_spoiler
  end
  
  def create_spoiler
    @user = User.new(session["devise.regist_data"]["user"])
    @spoiler = Spoiler.new(spoiler_params)
    unless @spoiler.valid?
      render :new_spoiler and return
    end
    @user.build_spoiler(@spoiler.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end

  
  
  # GET /resource/edit
  def edit
    @user = User.find(current_user.id)
  end
  
  # PUT /resource
  def update
    @user = User.find(current_user.id)
    @user.update(update_params)
    unless @user.valid?
      render :edit and return
    end
    @spoiler = Spoiler.find_by(user_id: current_user.id)
    render :edit_spoiler
  end
  
  def update_spoiler
    @user = User.find(current_user.id)
    @spoiler = Spoiler.find_by(user_id: @user.id)
    @spoiler.update(spoiler_params)
    unless @spoiler.valid?
      render :edit_spoiler and return
    end
    @spoiler.update(spoiler_params.merge(user_id: current_user.id))
    redirect_to user_path(current_user.id)
  end
  
  private

  def spoiler_params
    params.require(:spoiler).permit(
      :genre_spoiler_id, :creator_spoiler_id, :story_line_spoiler_id, :release_date_spoiler_id, :comment_spoiler_id
    )
  end

  def update_params
    params.require(:user).permit(:nickname, :email, :self_introduction)
  end


  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_resource(resource, params)
    resource.upddate_without_password(params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
