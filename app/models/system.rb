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
    A AB Aa ABC Aab ABa Aa1 Aa0b ABab ABCa Aa12 Aabc Aab1
  ).freeze

  has_many :stars

  validates :particular_name, uniqueness: true, allow_nil: true
  validates :standard_code, inclusion: { in: STANDARD_CODES }
  validates :internal_code, presence: true

  before_validation :set_internal_code
  before_save :set_internal_code

  def set_internal_code
    self.internal_code = 'tmp'
  end
end
