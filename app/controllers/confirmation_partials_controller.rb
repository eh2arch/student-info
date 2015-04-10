class ConfirmationPartialsController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def confirm
		@params = params[:user]
		render partial: "confirmation_dialog"
	end
end
