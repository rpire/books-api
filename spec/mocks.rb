require 'devise/jwt/test_helpers'

module Mocks
  def generate_user
    @user = User.create(
      name: 'Average HP Fan',
      bio: 'I love fantasy books!',
      icon: 7,
      email: 'hp_fan@email.com',
      password: 'expeliarmus'
    )
  end

  def generate_admin
    @admin = User.create(
      name: 'Average Anoying Admin',
      bio: 'I come to destroy your user\'s dreams.',
      icon: 4,
      email: 'adminuser@email.com',
      password: 'comeetyourmaker',
      role: 'admin'
    )
  end

  def authenticate(user)
    @token = Devise::JWT::TestHelpers.auth_headers({}, user).values.first
  end

  def generate_books
    @book_one = Book.create(
      user_id: @user.id,
      title: 'Harry Potter and the Philosopher\'s Stone',
      author: 'J.K. Rowling',
      category: 'Fantasy Novel',
      current_chapter: 'Diagon Alley',
      num_of_pages: 254,
      current_page: 77
    )

    @book_two = Book.create(
      user_id: @user.id,
      title: 'I Don\'t Wanna Go Mr. Stark',
      author: 'Peter R. Parker',
      category: 'Farewell',
      current_chapter: 'Avengers: Infinity War',
      num_of_pages: 44,
      current_page: 4
    )
  end
end
