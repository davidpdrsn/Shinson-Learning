require 'spec_helper'

describe Belt do
  it { should validate_presence_of :color }
  it { should validate_presence_of :degree }
end
