class SetBadgeService
  def initialize(test_passage: )
    @test_passage = test_passage
    @user = @test_passage.user
    @test = @test_passage.test
  end

  def call
    badge_awarded = nil

    Badge.all.each do |badge|
      if send("#{badge.rule}_award?", badge)
        assign_badge(badge)
        badge_awarded = badge
      end
    end

    badge_awarded
  end

  private

  def assign_badge(badge)
    user_badge = UserBadge.find_by(user: @user, badge: badge)

    if user_badge.present?
      user_badge.update(count: user_badge.count + 1)
    else
      UserBadge.create(user: @user, badge: badge)
    end
  end

  def category_complete_award?(badge)
    passed_tests_ids    = passed_by_category.pluck(:test_id).uniq.sort
    comparing_tests_ids = Test.where(category_id: @test.category.id).pluck(:id).sort

    passed_tests_ids.present? && passed_tests_ids == comparing_tests_ids
  end

  def level_complete_award?(badge)
    passed_tests_ids    = passed_by_level.pluck(:test_id).uniq.sort
    comparing_tests_ids = Test.where(level: @test.level).pluck(:id).sort

    passed_tests_ids.present? && passed_tests_ids == comparing_tests_ids
  end

  def first_attempt_award?(badge)
    @user.test_passages.where(test_id: @test.id).count == 1
  end

  def second_attempt_award?(badge)
    total_attempts     = @user.test_passages.where(test_id: @test.id)
    successed_attempts = total_attempts.where(success: true)

    total_attempts.count == 2 && successed_attempts.count == 1
  end

  def passed_by_category
    TestPassage.includes(:user, test: [:category])
      .where(user: @user)
      .where(success: true)
      .where(tests: { categories: { id: @test.category.id } })
  end

  def passed_by_level
    TestPassage.includes(:user, :test)
      .where(user: @user)
      .where(success: true)
      .where(tests: { level: @test.level })
  end
end