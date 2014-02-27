class User < ActiveRecord::Base
  has_many :techniques, dependent: :destroy
  has_many :notes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def questions
    notes.where(question: true).includes(:technique)
  end

  def screen_name
    return email unless first_name or last_name

    [first_name, last_name].reject(&:blank?).map(&:to_s).map(&:titleize).join(" ")
  end

  def s
    if screen_name.match /s$/
      "#{screen_name}'"
    else
      "#{screen_name}'s"
    end
  end
end
