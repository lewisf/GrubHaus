class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  ## Database authenticatable
  field :username,           :type => String, :default => ""
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates :username, presence: true, uniqueness: true
  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  attr_accessor :login
  attr_accessible :login

  embeds_one :profile
  has_many :followers, :class_name => "User", :inverse_of => :following
  has_many :following, :class_name => "User", :inverse_of => :followers
  has_many :favorites, :class_name => "Recipe"
  has_many :recipes, :inverse_of => :author

  # Overriding the default devise user query because we want to allow
  # logging in with both username or email.
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      Rails.logger.info("Picked up login")
      self.any_of({ :username => /^#{Regexp.escape(login)}$/i },
                  { :email => /^#{Regexp.escape(login)}$/i} ).first
    else
      super  # do normal is 'login' is not passed in the conditions
    end
  end

end
