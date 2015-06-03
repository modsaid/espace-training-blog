class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :authenticate_user!, if: :require_user

	def require_user
		params[:controller] != 'devise/registrations'
	end
end
