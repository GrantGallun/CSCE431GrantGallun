# Join model for the many-to-many relationship between users and books.
class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book_id, uniqueness: { scope: :user_id, message: "is already in this user's collection" }
end
