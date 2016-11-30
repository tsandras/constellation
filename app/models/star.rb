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

# app/models/star.rb
class Star < ApplicationRecord
  include InternalCode
  SPECTRAL_CLASSES = %w(O B A B F G K M L T Y).freeze
  SPECTRAL_SUBCLASSES = %w(0 1 2 3 4 5 6 7 8 9).freeze
  LUMINOSITY_CLASSES = %w(0 Ia Iab Ib II III IV V VI).freeze
  PREFIX = %w(d D c).freeze
  SUFFIX = %w(e f m n p s).freeze
  POSITION = %w(A B C D E).freeze
  ATTRIBUTS_BY_SC = {
    O: { tmin: 30_000, tmax: 80_000, mmin: 16.0, mmax: 100.0, rmin: 6.6, rmax: 20.0 },
    B: { tmin: 10_000, tmax: 30_000, mmin: 2.1, mmax: 16.0, rmin: 1.8, rmax: 6.6 },
    A: { tmin: 7500, tmax: 10_000, mmin: 1.4, mmax: 2.1, rmin: 1.4, rmax: 1.8 },
    F: { tmin: 6000, tmax: 7500, mmin: 1.04, mmax: 1.4, rmin: 1.15, rmax: 1.4 },
    G: { tmin: 5200, tmax: 6000, mmin: 0.8, mmax: 1.04, rmin: 0.96, rmax: 1.15 },
    K: { tmin: 3700, tmax: 5200, mmin: 0.45, mmax: 0.8, rmin: 0.7, rmax: 0.96 },
    M: { tmin: 2400, tmax: 3700, mmin: 0.08, mmax: 0.45, rmin: 0.3, rmax: 0.7 },
    L: { tmin: 1300, tmax: 2400, mmin: 0.05, mmax: 0.08, rmin: 0.1, rmax: 0.3 },
    T: { tmin: 550, tmax: 1300, mmin: 0.02, mmax: 0.05, rmin: 0.05, rmax: 0.1 },
    Y: { tmin: 250, tmax: 550, mmin: 0.01, mmax: 0.02, rmin: 0.01, rmax: 0.05 }
  }.freeze
  ROTATION_TYPES = %w(star secondary binary).freeze

  belongs_to :system
  has_many :planets
  has_many :stars

  validates :particular_name, uniqueness: true, allow_nil: true
  validates :system_id, presence: true
  validates :standard_code, presence: true
  validates :internal_code, presence: true
  validates :spectral_class, inclusion: { in: SPECTRAL_CLASSES }
  validates :spectral_subclass, inclusion: { in: SPECTRAL_SUBCLASSES }
  validates :luminosity_class, inclusion: { in: LUMINOSITY_CLASSES }
  validates :prefix, inclusion: { in: PREFIX }
  validates :suffix, inclusion: { in: SUFFIX }
  validates :position, inclusion: { in: POSITION }
  validate :temperature_range
  validate :mass_range
  validate :rayon_range

  def temperature_range
    min = ATTRIBUTS_BY_SC[spectral_class.to_sym][:tmin]
    max = ATTRIBUTS_BY_SC[spectral_class.to_sym][:tmax]
    return errors.add(:temperature, 'error message') if temperature < min
    return errors.add(:temperature, 'error message') if temperature > max
  end

  def mass_range
    min = ATTRIBUTS_BY_SC[spectral_class.to_sym][:mmin]
    max = ATTRIBUTS_BY_SC[spectral_class.to_sym][:mmax]
    return errors.add(:mass, 'error message') if mass < min
    return errors.add(:mass, 'error message') if mass > max
  end

  def rayon_range
    min = ATTRIBUTS_BY_SC[spectral_class.to_sym][:rmin]
    max = ATTRIBUTS_BY_SC[spectral_class.to_sym][:rmax]
    return errors.add(:rayon, 'error message') if rayon < min
    return errors.add(:rayon, 'error message') if rayon > max
  end

  before_validation :set_standard_code, :set_internal_code
  before_save :set_standard_code, :set_internal_code

  def set_standard_code
    self.standard_code =
      prefix +
      spectral_class +
      spectral_subclass +
      luminosity_class +
      suffix +
      '-' + position
  end

  def set_internal_code
    self.internal_code = 'tmp'
  end
end
