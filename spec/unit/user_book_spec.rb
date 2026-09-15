# Unit tests for the many-to-many association between users and books.
require 'rails_helper'

RSpec.describe UserBook, type: :model do
  let(:user) { User.create!(username: 'Axolotl') }
  let(:book) do
    Book.create!(title: 'Amazing turtles', author: 'Turtle Person', price: 9.99, published_date: Date.new(2020, 1, 1))
  end

  it 'links a user to a book in both directions' do
    described_class.create!(user: user, book: book)

    expect(user.books).to contain_exactly(book)
    expect(book.users).to contain_exactly(user)
  end

  it 'is not valid without a user or a book' do
    user_book = described_class.new
    expect(user_book).not_to be_valid
    expect(user_book.errors[:user]).to include('must exist')
    expect(user_book.errors[:book]).to include('must exist')
  end

  it 'does not allow the same book twice for one user' do
    described_class.create!(user: user, book: book)
    duplicate = described_class.new(user: user, book: book)
    expect(duplicate).not_to be_valid
    # The database enforces it too, even if validations are skipped.
    expect { duplicate.save!(validate: false) }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it 'is removed when its user or book is deleted' do
    described_class.create!(user: user, book: book)
    expect { book.destroy }.to change(described_class, :count).by(-1)
  end
end

RSpec.describe User, type: :model do
  it 'is not valid without a username' do
    expect(described_class.new(username: '')).not_to be_valid
  end
end
