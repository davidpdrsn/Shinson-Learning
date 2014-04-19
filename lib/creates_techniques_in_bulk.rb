class CreatesTechniquesInBulk
  def initialize technique_attributes
    @technique_attributes = technique_attributes
  end

  def create_for_user user
    techniques = technique_records user
    save_all_and_return_invalid techniques
  end

  private

  def technique_records user
    @technique_attributes.map { |attrs| user.techniques.new attrs }
  end

  def save_all_and_return_invalid techniques
    techniques.inject([]) do |acc, technique|
      technique.save
      acc << technique if technique.new_record?
      acc
    end
  end
end
