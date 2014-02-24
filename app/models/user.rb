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

  def screen_name
    return email unless first_name or last_name

    [first_name, last_name].map(&:to_s).map(&:titleize).reject(&:blank?).join(" ")
  end
end
