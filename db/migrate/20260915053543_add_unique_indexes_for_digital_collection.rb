# Digital collection rules enforced by the database as well as the models:
# one catalog entry per title (ignoring case) and one link per user and book.
class AddUniqueIndexesForDigitalCollection < ActiveRecord::Migration[8.1]
  def change
    add_index :books, "lower(title)", unique: true, name: "index_books_on_lower_title"
    add_index :user_books, [ :user_id, :book_id ], unique: true
  end
end
