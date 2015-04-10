class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :gender, :year_of_joining, :branch, :contact_number, :address, :roll_no, :registration_no, :cgpa, :rank_aieee, :school, :avatar, :hobbies =>[])
   end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :date_of_birth, :gender, :year_of_joining, :branch, :contact_number, :address, :roll_no, :registration_no, :cgpa, :rank_aieee, :school, :avatar, :hobbies =>[])
    end
  end

end
