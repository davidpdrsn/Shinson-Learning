require "spec_helper"

describe ExportsController do
  let(:user) { create :user }

  describe "#new" do
    it "requies authentication" do
      get :new

      expect(subject).to redirect_to new_user_session_path
    end
  end

  describe "#show" do
    context "when signed in" do
      before { sign_in user }

      it "assigns techniques to @export" do
        category = create :category
        belt = create :belt
        another_belt = create :belt
        technique = create :technique, user: user, belt: belt, category: category
        another_technique = create :technique, user: user, belt: another_belt, category: category

        get :show, export: { belts: [belt.id], categories: [category.id] }

        assigned_techniques = techniques_in_grouped_hash assigns[:techniques]
        expect(assigned_techniques).to eq [technique]
      end

      it "renders show without a layout" do
        get :show, export: { belts: [], categories: [] }

        expect(subject).to render_template :show
      end
    end

    it "requies authentication" do
      get :show

      expect(subject).to redirect_to new_user_session_path
    end
  end

  def techniques_in_grouped_hash techniques
    techniques.values.map(&:values).flatten
  end
end
