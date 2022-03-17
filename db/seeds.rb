# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.create(
  name: 'El Matatan',
  bio: 'El matatan de la lectura.',
  email: 'elmatatan@email.com',
  password: '123456',
  role: 'admin'
)

User.create(
  name: 'Rubén Pire',
  bio: 'Me gustan los libros de realismo mágico.',
  email: 'rubenpire7@gmail.com',
  password: '123456',
)

User.create(
  name: 'Guest',
  bio: 'Have fun with this guest user account!',
  email: 'testuser@email.com',
  password: 'test123',
)

Book.create(
  title: 'One Hundred Years of Solitude',
  author: 'Gabriel García Márquez',
  num_of_pages: 500,
  current_page: 255,
  current_chapter: 'Chapter: XI',
  category: 'Magic Realism',
  user_id: 2
)

Book.create(
  title: 'Electrical Machines',
  author: 'Stephen J. Chapman',
  num_of_pages: 502,
  current_page: 11,
  current_chapter: 'Chapter II: Transformers',
  category: 'Engineering',
  user_id: 1
)

Book.create(
  title: 'Twelve Pilgrim Tales',
  author: 'Gabriel García Márquez',
  num_of_pages: 150,
  current_page: 82,
  current_chapter: 'Chapter: VII',
  category: 'Magic Realism',
  user_id: 2
)
