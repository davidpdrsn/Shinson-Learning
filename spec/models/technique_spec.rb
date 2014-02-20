require 'spec_helper'

describe Technique do
  it { should validate_presence_of :name }
end
