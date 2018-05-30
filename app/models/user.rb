class User < ApplicationRecord
  has_many :posts
  has_many :comments
  attr_accessor :login
  validates :username, presence: :true, uniqueness: { case_sensitive: false }, length: { in: 4..20 }
  validates :username, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_writer :login

  def login
    @login || username || email
  end

  private

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
end
