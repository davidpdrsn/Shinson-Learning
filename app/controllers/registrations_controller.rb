class RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      if params[:add_white_techniques]
        AddsWhiteTechniques.new(user).add_techniques
      end
    end
  end
end
