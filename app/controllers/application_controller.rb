class ApplicationController < ActionController::Base
  before_action :current_user
  protect_from_forgery with: :exception
  include SessionsHelper
end
