admin = User.find_by(email: 'admin@example.com')

unless admin
  admin = User.create(
    first_name: 'Admin',
    last_name: 'Admin',
    email: 'admin@example.com',
    password: '123456',
    password_confirmation: '123456',
    role: 'admin'
  )

  admin.confirm
end

# user = User.create(
#   first_name: FFaker::Name.first_name,
#   last_name: FFaker::Name.last_name,
#   email: FFaker::Internet.email,
#   role: 'regular'
# )

Category.create(title: 'Backend')
Category.create(title: 'Frontend')

Test.create(title: 'Ruby', category: Category.first, author: admin)
Test.create(title: 'Ruby on Rails', category: Category.first, level: 2, author: admin)
Test.create(title: 'JavaScript', category: Category.last, author: admin)
Test.create(title: 'CSS', category: Category.last, author: admin)
Test.create(title: 'Python', category: Category.first, level: 2, author: admin)

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
