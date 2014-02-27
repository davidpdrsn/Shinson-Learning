class User < ActiveRecord::Base
  has_many :techniques
  has_many :notes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def questions
    notes.where(question: true).includes(:technique)
  end
end
