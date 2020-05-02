class SetBadgeService
  def initialize(test_passage: , user: )
    @test_passage = test_passage
    @user = user
    @test = @test_passage.test
  end

  def call
    if @test_passage.passed?
      @badge = find_badge
      assign_badge
    end

    @badge
  end

  private

  def find_badge
    badges = Badge.where(name: badge_names)
    with_attempt_number = badges.where('attempts_number >= ?', attempts_number).order(name: :desc).first
    without_attempt_number = badges.where(attempts_number: nil).order(name: :desc).first

    with_attempt_number || without_attempt_number
  end

  def assign_badge
    user_badge = UserBadge.find_by(user: @user, badge: @badge)

    if user_badge
      user_badge.update(count: user_badge.count + 1)
    else
      UserBadge.create(user: @user, badge: @badge)
    end
  end

  def badge_names
    ["B#{@test.id}#{@test.category_id}#{@test.level}", "B0#{@test.category_id}#{@test.level}"]
  end

  def attempts_number
    TestPassage.where(user: @user, test: @test).count
  end
end