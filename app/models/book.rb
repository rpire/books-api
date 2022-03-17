class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true, length: { maximum: 30 }
  validates :current_chapter, presence: true, length: { maximum: 30 }
  validates :num_of_pages, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :current_page, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :current_page, comparison: { less_than_or_equal_to: :num_of_pages }
  validates :category, presence: true, length: { maximum: 20 }
end
