# A book in the shared digital catalog: each title appears once, and deleting a book
# removes it from every user's collection.
class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books

  normalizes :title, with: ->(title) { title.strip }

  validates :title, :author, :price, :published_date, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
