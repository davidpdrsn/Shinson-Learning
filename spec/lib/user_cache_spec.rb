require 'spec_helper'

describe UserCache do
  describe "#studies_count" do
    it "returns the number of studies a user has", caching: true do
      user, user_cache = user_with_cache

      2.times { create :study, user: user }
      expect(user_cache.studies_count).to eq 2

      2.times { create :study, user: user }
      expect(user_cache.studies_count).to eq 4
    end
  end

  describe "#notes_count" do
    it "returns the number of notes the user has", caching: true do
      user, user_cache = user_with_cache

      2.times { create :note, user: user }
      expect(user_cache.notes_count).to eq 2

      2.times { create :note, user: user }
      expect(user_cache.notes_count).to eq 4
    end
  end

  describe "#techniques_count" do
    it "returns the number of techniques the user has", caching: true do
      user, user_cache = user_with_cache

      2.times { create :technique, user: user }
      expect(user_cache.techniques_count).to eq 2

      2.times { create :technique, user: user }
      expect(user_cache.techniques_count).to eq 4
    end
  end

  def user_with_cache
    user = create :user
    user_cache = UserCache.new user, Rails.cache

    return user, user_cache
  end
end
