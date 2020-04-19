class Badge < ApplicationRecord
  RULES_CODES_PATTERN = [[1, 1, 1], [1, 1, 0], [1, 0, 0], [1, 0, 1], [0, 1, 1], [0, 1, 0], [0, 0, 1], [0, 0, 0]].freeze

  belongs_to :category, optional: true
  belongs_to :test, optional: true

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  before_save :set_image, on: :create
  before_save :set_rule_code, on: :create

  validates :rule_code, uniqueness: true

  def self.by_rules(test_id: , category_id:, level:)
    code = [(test_id || 0), (category_id || 0), (level || 0)]

    code_variants = RULES_CODES_PATTERN.map do |rule|
      [rule[0] * code[0], rule[1] * code[1], rule[2] * code[2]].join(' ')
    end

    self.where(rule_code: code_variants)
  end

  def self.find_by_rules(test_id: , category_id:, level: , attempts_number: )
    badges = self.by_rules(test_id: test_id, category_id: category_id, level: level)

    if attempts_number.present?
      badges.where('attempts_number >= ?', attempts_number).order(:rule_priority).first
    else
      badges.where(attempts_number: nil).order(:rule_priority).first
    end
  end

  private

  def set_image
    self.image = 'badge.png'
  end

  def set_rule_code
    code_pattern  = [(self.test_id || 0), (self.category_id || 0), (self.level || 0)]
    binary_code_pattern = code_pattern.map { |c| c.present? && c > 0 ? 1 : c }
    rule_priority = RULES_CODES_PATTERN.index(binary_code_pattern)

    self.rule_code = code_pattern.join(' ')
    self.rule_priority = rule_priority
  end
end