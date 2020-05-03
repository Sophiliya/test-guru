class SetBadgeService
  def initialize(test_passage: )
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
    @badge = find_badge
  end

  def call
    return unless @badge.present? && rules_satisfied?

    assign_badge
    @badge
  end

  private

  def find_badge
    by_category = Badge.find_by(rule: "#{@test.category.title.downcase}")
    by_level    = Badge.find_by(rule: "level_#{@test.level}")
    by_attempt  = Badge.find_by(rule: "attempt_#{attempts_number}")

    by_category || by_level || by_attempt
  end

  def rules_satisfied?
    case @badge.rule
    when 'backend', 'frontend'
      passed_by_category.count == Test.by_category(@badge.rule.capitalize).count
    when 'level_1', 'level_2'
      passed_by_level.count == Test.where(level: @badge.rule.last.to_i).count
    when 'attempt_1', 'attempt_2'
      attempts_number == @badge.rule.last.to_i
    else
      false
    end
  end

  def assign_badge
    user_badge = UserBadge.find_by(user: @user, badge: @badge)

    if user_badge.present?
      user_badge.update(count: user_badge.count + 1)
    else
      UserBadge.create(user: @user, badge: @badge)
    end
  end

  def passed_by_category
    TestPassage.includes(:user, test: [:category])
      .where(user: @user)
      .where(success: true)
      .where(tests: { categories: { title: @badge.rule.capitalize } })
  end

  def passed_by_level
    TestPassage.includes(:user, :test)
      .where(user: @user)
      .where(success: true)
      .where(tests: { level: @badge.rule.last.to_i })
  end

  def attempts_number
    TestPassage.where(user: @user, test: @test).count
  end
end