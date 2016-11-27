# == Schema Information
#
# Table name: systems
#
#  id              :integer          not null, primary key
#  standard_code   :string           not null
#  internal_code   :string           not null
#  particular_name :string
#  x               :integer          default(0), not null
#  y               :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class SystemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
