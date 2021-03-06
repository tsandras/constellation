# == Schema Information
#
# Table name: stars
#
#  id                :integer          not null, primary key
#  system_id         :integer          not null
#  star_id           :integer
#  standard_code     :string           not null
#  internal_code     :string           not null
#  particular_name   :string
#  position          :string           default("A"), not null
#  rotation_type     :string           default("star"), not null
#  spectral_class    :string           not null
#  spectral_subclass :string           not null
#  luminosity_class  :string           not null
#  prefix            :string           default(""), not null
#  suffix            :string           default(""), not null
#  rotation          :integer          default(28), not null
#  temperature       :integer          default(5750), not null
#  age               :float            default(4.5), not null
#  mass              :float            default(1.0), not null
#  rayon             :float            default(1.0), not null
#  star_composition  :json
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class StarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
