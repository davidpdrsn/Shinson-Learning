require 'spec_helper'

describe Technique do
  it { should belong_to :belt }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
