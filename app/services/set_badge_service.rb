class SetBadgeService
  def initialize(test_passage: )
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
  end

  def call
    @badge = find_badge
    return unless @badge.present?

    define_award_methods

    if send("#{@badge.rule}_award?", @badge)
      assign_badge
      @badge
    end
  end

  private

  def find_badge
    rules = ["#{@test.category.title.downcase}", "level_#{@test.level}", "attempt_#{attempts_number}"]
    Badge.find_by(rule: Badge.rules.keys & rules)
  end

  def define_award_methods
    self.class.define_method("#{@badge.rule}_award?".to_sym) do |badge|
      case badge.rule
      when 'backend', 'frontend'
        passed_by_category.pluck(:test_id).uniq.sort == Test.by_category(badge.rule.capitalize).pluck(:id).sort
      when 'level_1', 'level_2'
        passed_by_level.pluck(:test_id).uniq.sort == Test.where(level: badge.rule.last.to_i).pluck(:id).sort
      when 'attempt_1', 'attempt_2'
        attempts_number == badge.rule.last.to_i
      else
        false
      end
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