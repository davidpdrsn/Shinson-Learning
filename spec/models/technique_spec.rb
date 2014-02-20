require 'spec_helper'

describe Technique do
  it { should belong_to :belt }
  it { should belong_to :category }
  it { should belong_to :user }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :belt_id }
  it { should validate_presence_of :category_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :description }
end
