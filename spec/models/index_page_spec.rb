require 'spec_helper'

describe TechniquesIndexPage do
  describe '#has_techniques?' do
    it 'returns true when it has techniques' do
      page = TechniquesIndexPage.new(techniques: [double('technique')],
                           default_grouping: double('grouping'))
      expect(page.has_techniques?).to be_true
    end

    it 'returns false when it has no techniques' do
      page = TechniquesIndexPage.new(techniques: [],
                           default_grouping: double('grouping'))
      expect(page.has_techniques?).to be_false
    end
  end
end
