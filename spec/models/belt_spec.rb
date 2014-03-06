require 'spec_helper'

describe Belt do
  it { should have_many :techniques }

  it { should validate_presence_of :color }
  it { should validate_presence_of :degree }
  it { should validate_uniqueness_of :degree }
end
