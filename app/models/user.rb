class User
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Userstamp::User

  track_history({
    track_create: true,
    track_destroy: true,
    track_update: true,
    on: [:sign_in_count,:current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip]
  })

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Admin role
  field :admin, type: Boolean, default: false

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :first_name,         type: String, default: ""
  field :last_name,          type: String, default: ""
  field :date_of_birth,      type: DateTime, default: DateTime.now
  field :gender,             type: String, default: "male"
  field :year_of_joining,    type: Integer, default: 2010
  field :branch,             type: String, default: "IT"
  field :contact_number,     type: Integer, default: "9999999999"
  field :address,            type: String, default: ""
  field :hobbies,            type: Array, default: []

  field :disable,            type: Boolean, default: true

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  class << self
    def serialize_from_session(key, salt)
      record = to_adapter.get(key[0]["$oid"])
      record if record && record.authenticatable_salt == salt
    end
  end

  def title
    self.email
  end

end
