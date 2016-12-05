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

  def tree
    tree = {}
    number = -1
    col = 0..(standard_code.length - 1)
    col.each do |i|
      if maj?(standard_code[i]) && !min?(standard_code[i])
        tree[standard_code[i]] = {}
        last_first = standard_code[i]
        number = -1
      elsif min?(standard_code[i]) && !maj?(standard_code[i])
        tmp = {}
        tmp[standard_code[i]] = []
        tree[last_first] = tree[last_first].merge(tmp)
        last_second = standard_code[i]
        number += 1
      elsif alpha?(standard_code[i])
        tree[last_first][last_second].push(standard_code[i])
      end
    end
    tree
  end

  private

  def maj?(char)
    return false if char.upcase != char
    true
  end

  def alpha?(char)
    res = Integer(char) rescue false
    return true if res != false
    false
  end

  def min?(char)
    return false if char.downcase != char
    true
  end
end
