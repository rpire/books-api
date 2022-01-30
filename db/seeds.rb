# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Book.create(
  title: 'One Hundred Years of Solitude',
  author: 'Gabriel García Márquez',
  num_of_chapters: 30,
  current_chapter: 11,
  category: 'Magic Realism',
  user_id: 1
)

Book.create(
  title: 'Electrical Machines',
  author: 'Stephen J. Chapman',
  num_of_chapters: 48,
  current_chapter: 2,
  category: 'Engineering',
  user_id: 1
)

Book.create(
  title: 'Twelve Pilgrim Tales',
  author: 'Gabriel García Márquez',
  num_of_chapters: 15,
  current_chapter: 7,
  category: 'Magic Realism',
  user_id: 1
)
