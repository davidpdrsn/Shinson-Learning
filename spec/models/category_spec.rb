require 'spec_helper'

describe Category do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it { should have_many :techniques }

  describe "#html_class" do
    it "returns a string used for the html class" do
      category = create(:category, name: "Jokgi sul")

      expect(category.html_class).to eq "jokgi-sul"
    end
  end
end
