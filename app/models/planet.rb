# == Schema Information
#
# Table name: planets
#
#  id                     :integer          not null, primary key
#  star_id                :integer          not null
#  standard_code          :string           not null
#  internal_code          :string           not null
#  particular_name        :string
#  position               :string           default("a"), not null
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

# app/models/planet.rb
class Planet < ApplicationRecord
  include InternalCode

  POSITION = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z).freeze
  SURFACE_TYPE = %w(t i g).freeze

  belongs_to :star

  validates :particular_name, uniqueness: true, allow_nil: true
  validates :star_id, presence: true
  validates :standard_code, presence: true
  validates :internal_code, presence: true

  before_validation :set_standard_code, :set_internal_code
  before_save :set_standard_code, :set_internal_code

  def set_standard_code
    self.standard_code =
      standard_code_mass +
      standard_code_distance +
      standard_code_temperature +
      stantard_code_eccentricity +
      surface_type
  end

  def set_internal_code
    self.internal_code = 'tmp'
  end

  def standard_code_mass
    return (mass / 0.05).round.to_s + 'M' if mass < 1.00
    return mass.round.to_s + 'E' if mass < 16.00 && mass >= 1.00
    return (mass / 17.15).round.to_s + 'N' if mass < 317.83 && mass >= 16.00
    (mass / 317.83).round.to_s + 'J' if mass >= 317.83
  end

  def standard_code_distance
    out = Math.log10(star_distance)
    return '0' if out == 0.0
    out.to_s
  end

  def standard_code_temperature
    return 'F' if surface_temperature < 250
    return 'W' if surface_temperature >= 250 && surface_temperature < 450
    return 'G' if surface_temperature >= 450 && surface_temperature < 1000
    return 'R' if surface_temperature >= 1000
  end

  def stantard_code_eccentricity
    orbital_eccentricity.to_s[2]
  end
end
