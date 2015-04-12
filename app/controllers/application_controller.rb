class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :init

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path
  end

  def init
	@department_list = { "Biotechnology" => "BT", "Chemical" => "CHE", "Civil" => "CE", "Computer Sc" => "CSE", "Electronics" => "ECE", "Electrical" => "EE", "Information Technology"=> "IT", "Mechanical" => "ME", "Metallurgy" => "MME" }
	@requests_all = User.where(admin: false, pending: true).count
	@requests_list = []
	@department_list.each_key do |key|
		users = User.where(admin: false, pending: true, branch: @department_list[key])
		@requests_list << users.count
	end
  end

  def home
  	@params = current_user
  end

  def students
  	if current_user.admin?
	  	if params[:branch]
	  		@students = User.where(admin: false, branch: params[:branch], pending: false, disable: false).order_by(roll_no: 1)
	  	else
		  	@students = User.where(admin: false, pending: false, disable: false).order_by(roll_no: 1)
		end
	else
		redirect_to main_app.root_path
	end
  end

  def requests
  	if current_user.admin?
	  	if params[:branch]
	  		@requests = User.where(admin: false, pending: true, branch: params[:branch])
	  	else
		  	@requests = User.where(admin: false, pending: true)
		end
	else
		redirect_to main_app.root_path
	end
  end

  def pending_status
  	if current_user.admin?
	  	state = params[:state]
	  	disable_status = (state == 'accept') ? false : true
	  	ids = params[:ids]
	  	unless ids.count == 0
		  	users = User.where(admin: false, pending: true).in(_id: ids)
		  	users.update_all({disable: disable_status, pending: false})
		end
	end
	render nothing: true
  end

  def destroy
  	if current_user.admin?
  		user_id = params[:user]
  		user = User.where(_id: user_id)
  		unless user.count == 0
  			user.destroy
  		end
  	end
  	render nothing: true
  end

end
