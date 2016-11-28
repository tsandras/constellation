# == Schema Information
#
# Table name: systems
#
#  id                  :integer          not null, primary key
#  standard_code       :string           not null
#  internal_code       :string           not null
#  particular_name     :string
#  x                   :integer          default(0), not null
#  y                   :integer          default(0), not null
#  stars_configuration :json
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

# app/models/system.rb
class System < ApplicationRecord
  STANDARD_CODES = %w(
    A AB (AB) ABC (AB)C A(BC) (ABC) ABCD (AB)(CD)
    (AB)CD AB(CD) A(BC)D ABCDE (AB)CDE A(BC)DE AB(CD)E
    ABC(DE) (ABC)(DE) (AB)(CDE) A(BCD)E ?????
  ).freeze

  has_many :stars

  validates :particular_name, uniqueness: true, allow_nil: true
  validates :standard_code, inclusion: { in: STANDARD_CODES }
  validates :internal_code, presence: true

  before_validation :set_standard_code, :set_internal_code
  before_save :set_standard_code, :set_internal_code

  def set_standard_code
    self.standard_code = 'tmp'
  end

  def set_internal_code
    self.internal_code = 'tmp'
  end
end
