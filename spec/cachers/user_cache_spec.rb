require 'spec_helper'

describe UserCache do
  describe "#studies_count" do
    it "returns the number of studies a user has", caching: true do
      user, user_cache = user_with_cache

      2.times do
        expect do
          create :study, user: user
        end.to change { user_cache.studies_count }.by(1)
      end
    end
  end

  describe "#notes_count" do
    it "returns the number of notes the user has", caching: true do
      user, user_cache = user_with_cache

      2.times do
        expect do
          create :note, user: user
        end.to change { user_cache.notes_count }.by(1)
      end
    end
  end

  describe "#techniques_count" do
    it "returns the number of techniques the user has", caching: true do
      user, user_cache = user_with_cache

      2.times do
        expect do
          create :technique, user: user
        end.to change { user_cache.techniques_count }.by(1)
      end
    end
  end

  def user_with_cache
    user = create :user
    user_cache = UserCache.new user, Rails.cache

    return user, user_cache
  end
end
