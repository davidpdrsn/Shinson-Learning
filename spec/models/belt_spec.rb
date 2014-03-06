# == Schema Information
#
# Table name: belts
#
#  id     :integer          not null, primary key
#  color  :string(255)
#  degree :string(255)
#

require 'spec_helper'

describe Belt do
  it { should have_many :techniques }

  it { should validate_presence_of :color }
  it { should validate_presence_of :degree }
  it { should validate_uniqueness_of :degree }

end
