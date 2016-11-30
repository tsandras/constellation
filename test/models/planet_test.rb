# == Schema Information
#
# Table name: planets
#
#  id                     :integer          not null, primary key
#  star_id                :integer          not null
#  planet_id              :integer
#  standard_code          :string           not null
#  internal_code          :string           not null
#  particular_name        :string
#  position               :string           default("a"), not null
#  rotation_type          :string           default("planet"), not null
#  star_distance          :float            default(1.0), not null
#  diameter               :integer          default(12742), not null
#  mass                   :float            default(1.0), not null
#  orbital_period         :float            default(365.25), not null
#  orbital_eccentricity   :float            default(0.01), not null
#  rotation_period        :float            default(1.0), not null
#  surface_gravity        :float            default(1.0), not null
#  surface_pressure       :float            default(1.0), not null
#  surface_temperature    :integer          default(350), not null
#  surface_type           :string           default("t"), not null
#  escape_velocity        :float            default(11.15), not null
#  planet_composition     :json
#  atmosphere_composition :json
#  description            :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class PlanetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
