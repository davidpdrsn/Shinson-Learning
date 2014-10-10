require 'spec_helper'

describe TechniquesIndexPage do
  describe '#has_techniques?' do
    it 'returns true when there are techniques' do
      page = TechniquesIndexPage.new(techniques: [double('technique')], default_grouping: nil)

      expect(page.has_techniques?).to be_true
    end

    it 'returns false when there are no techniques' do
      page = TechniquesIndexPage.new(techniques: [], default_grouping: nil)

      expect(page.has_techniques?).to be_false
    end
  end
end
