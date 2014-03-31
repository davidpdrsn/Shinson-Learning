# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#

class User < ActiveRecord::Base
  has_many :techniques, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :studies, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def neglected_studies
    studies.select do |study|
      # TODO: refactor this conditional
      !study.ever_studied? || !study.studied_recently?
    end
  end

  def questions
    notes.where(question: true).includes(:technique)
  end

  def sorted_techniques
    techniques.includes(:category, :belt).sort
  end

  def admin?
    AdminUser.where(email: email).present?
  end
end
