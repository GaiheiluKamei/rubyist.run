class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ---
  # Database Authenticatable: hashes and stores a password in the database to validate the authenticity of a user while signing in. The authentication can be done both through POST requests or HTTP Basic Authentication.
  # Omniauthable: adds OmniAuth (https://github.com/omniauth/omniauth) support.
  # Confirmable: sends emails with confirmation instructions and verifies whether an account is already confirmed during sign in.
  # Recoverable: resets the user password and sends reset instructions.
  # Registerable: handles signing up users through a registration process, also allowing them to edit and destroy their account.
  # Rememberable: manages generating and clearing a token for remembering the user from a saved cookie.
  # Trackable: tracks sign in count, timestamps and IP address.
  # Timeoutable: expires sessions that have not been active in a specified period of time.
  # Validatable: provides validations of email and password. It's optional and can be customized, so you're able to define your own validations.
  # Lockable: locks an account after a specified number of failed sign-in attempts. Can unlock via email or after a specified time period.
  devise :database_authenticatable, :rememberable, :validatable

  has_many :posts
end
