# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      flash[:notice] = @user.errors.messages
      redirect_to new_user_registration_path
    end
  end

  # GET /resource/edit
  def user_edit
    @user = User.find(current_user.id)
    if @user.philosopher
    else
      @user.build_user_profile unless @user.user_profile
      render :user_edit
    end
  end

  # PUT /resource
  def update
    @user = User.find(current_user.id)
    if @user.update(account_update_params)
      redirect_to user_path(current_user)
    else
      flash[:notice] = @user.errors.messages
      redirect_to edit_user_path
    end
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

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :gender])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :gender, user_profile_attributes: [:profile, :kleshas]])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
