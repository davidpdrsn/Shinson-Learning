require 'spec_helper'

describe Note do
  it { should belong_to :user }
  it { should belong_to :technique }

  it { should validate_presence_of :text }
end
