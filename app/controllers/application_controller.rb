# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern

  helper_method :signed_in?, :current_user

  rescue_from NotAuthenticatedError, with: :user_not_authenticated

  private

  def user_not_authenticated
    flash[:warning] = t('user_not_authenticated')
    redirect_to root_path
  end
end
