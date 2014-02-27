require 'user_extensions'

class User < ActiveRecord::Base
  has_many :techniques, dependent: :destroy
  has_many :notes, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include UserExtensions
  include UserExtensions::Queries
end
