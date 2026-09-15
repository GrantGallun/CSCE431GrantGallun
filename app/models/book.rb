class Book < ApplicationRecord
  validates :title, :author, :price, :published_date, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
