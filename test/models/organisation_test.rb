# == Schema Information
#
# Table name: organisations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  history     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class OrganisationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
