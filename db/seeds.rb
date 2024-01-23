unless ENV['DISABLE_SEED'] == 'true'
  puts "\n== Seeding the database with fixtures =="
  # system("bin/rails db:fixtures:load")
  # ActiveRecord::Fixture::FormatError: YAML syntax error occurred
  user = User.create!(email: 'gk@example.com', password: 'password')

  10.times do |i|
    Post.create!(
      title: Faker::Book.title,
      body_markdown: Faker::Markdown.sandwich(sentences: 10, repeat: 3),
      published_at: Time.current,
      user: user,
      )
  end
end
