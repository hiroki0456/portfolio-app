# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    super
  end

  def new_philosopher
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      flash[:notice] = @user.errors.messages
      if (Rails.application.routes.recognize_path(request.referrer)[:action] == "new_philosopher")
        redirect_to new_philosopher_path
      else
        redirect_to new_user_registration_path
      end
    end
  end

  # GET /resource/edit
  def user_edit
    @profile = Profile.find_by(user_id: current_user.id)
  end

  # PUT /resource
  def update
    if @user.update(account_update_params)
      profile_update
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
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :gender, :philosopher, :image])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :gender, :image])
  end

  def profile_update
    if current_user.philosopher
      profile = Profile.find_or_initialize_by(user_id: current_user)
      philosopher_profile = PhilosopherProfile.find_or_initialize_by(id: profile.profile_id)
      philosopher_profile.update(
        affiliation: params[:user][:profile][:affiliation],
        research: params[:user][:profile][:research]
      )
      profile.update(
        content: params[:user][:profile][:content],
        user_id: current_user.id,
        profile_type: "PhilosopherProfile",
        profile_id: philosopher_profile.id
      )
    else
      profile = Profile.find_or_initialize_by(user_id: current_user)
      general_profile = GeneralProfile.find_or_initialize_by(id: profile.profile_id)
      general_profile.update(kleshas: params[:user][:profile][:kleshas])
      profile.update(
        content: params[:user][:profile][:content],
        user_id: current_user.id,
        profile_type: "GeneralProfile",
        profile_id: general_profile.id
      )
    end
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
