require 'spec_helper'

describe User do
  it { should have_many(:techniques).dependent(:destroy) }
  it { should have_many(:notes).dependent(:destroy) }
  it { should have_many(:studies).dependent(:destroy) }
end
