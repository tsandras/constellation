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

# app/models/system.rb
class System < ApplicationRecord
  validates :particular_name, uniqueness: true, allow_nil: true
  validates :standard_code, presence: true
  validates :internal_code, presence: true
end
