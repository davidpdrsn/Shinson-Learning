module FindsTechniques
  extend ActiveSupport::Concern

  def get_technique
    @technique = current_user.techniques.find(params[self.class::TECHNIQUE_PARAM_KEY])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "Technique not found"
    redirect_to root_path
  end
end
