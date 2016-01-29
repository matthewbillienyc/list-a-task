class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login, except: [:new, :create, :home]
  include SessionsHelper
  include ApplicationHelper

  def home
    render 'layouts/home'
  end
end
