Category.create(title: 'Backend')
Category.create(title: 'Frontend')

Test.create(title: 'Ruby', category: Category.first)
Test.create(title: 'Ruby on Rails', category: Category.first, level: 2)
Test.create(title: 'JavaScript', category: Category.last)
Test.create(title: 'CSS', category: Category.last)
Test.create(title: 'Python', category: Category.first, level: 2)

Test.all.each do |test|
  questions = []
  8.times { questions << "#{FFaker::Lorem.sentence}?" }

  questions.each do |answer|
    Question.create(body: answer, test: test)
  end
end

Question.all.each do |question|
  answers = []
  4.times { answers << FFaker::Lorem.sentence }

  answers.each { |answer| Answer.create(body: answer, question: question) }
  question.answers.sample.update(correct: true)
end

user = User.create(
  first_name: FFaker::Name.first_name,
  last_name: FFaker::Name.last_name,
  email: FFaker::Internet.email
)

Test.all.each { |test| TestsUser.create(user: user, test: test) }
