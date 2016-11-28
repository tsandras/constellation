# app/models/internal_code.rb
module InternalCode
  # TODO: create method to set internal code to celescial bodies
  STANDARD_INTERNAL_SYSTEM = {
    'A' => '0',
    'AB' => '1',
    '(AB)' => '2',
    'ABC' => '3',
    '(AB)C' => '4',
    'A(BC)' => '5',
    '(ABC)' => '6',
    'ABCD' => '7',
    '(AB)(CD)' => '8',
    '(AB)CD' => '9',
    'AB(CD)' => 'A',
    'A(BC)D' => 'B',
    'ABCDE' => 'C',
    '(AB)CDE' => 'D',
    'A(BC)DE' => 'E',
    'AB(CD)E' => 'F',
    'ABC(DE)' => 'G',
    '(ABC)(DE)' => 'H',
    '(AB)(CDE)' => 'I',
    'A(BCD)E' => 'J',
    '?????' => 'X'
  }.freeze

  def self.standard_internal_system(standard_code)
    STANDARD_INTERNAL_SYSTEM[standard_code]
  end

  STANDARD_INTERNAL_STAR = {
    'O' => { high: 'J', low: 'I' },
    'B' => { high: 'H', low: 'G' },
    'A' => { high: 'F', low: 'E' },
    'F' => { high: 'D', low: 'C' },
    'G' => { high: 'B', low: 'A' },
    'K' => { high: '9', low: '8' },
    'M' => { high: '7', low: '6' },
    'L' => { high: '5', low: '4' },
    'T' => { high: '3', low: '2' },
    'Y' => { high: '1', low: '0' }
  }.freeze

  def self.standard_internal_star(spectral_class, spectral_subclass)
    highs = %w(0 1 2 3 4)
    if highs.include?(spectral_subclass)
      STANDARD_INTERNAL_STAR[spectral_class][:high]
    else
      STANDARD_INTERNAL_STAR[spectral_class][:low]
    end
  end
end
