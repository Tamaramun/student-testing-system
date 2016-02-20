user = User.create(email: 'teacher@example.com', password: '12345678', password_confirmation: '12345678')
tests = []
5.times do
  tests << Test.create(name: Faker::Lorem.word, description: Faker::Lorem.sentence(3))
end

test_ids = []
tests.each do |test|
  test_ids << test.id
end
questions = []
10.times do
  questions << Question.create(question: Faker::Lorem.sentence(4) + '?', test_id: test_ids.sample)
end