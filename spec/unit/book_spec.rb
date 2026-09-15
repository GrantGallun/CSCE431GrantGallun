# Unit tests for the Book model.
# Each rainy-day test only sets the attribute it checks, so it passes as soon as that
# attribute is implemented, independent of the others.
require 'rails_helper'

RSpec.describe Book, type: :model do
  # Sunny day: a book with every attribute filled in is valid.
  it 'is valid with valid attributes' do
    book = described_class.new(
      title: 'Clean Code',
      author: 'Robert C. Martin',
      price: 37.99,
      published_date: Date.new(2008, 8, 1)
    )
    expect(book).to be_valid
  end

  # Rainy day: a blank title is rejected.
  it 'is not valid without a title' do
    book = described_class.new(title: '')
    expect(book).not_to be_valid
    expect(book.errors[:title]).to include("can't be blank")
  end

  it 'is not valid without an author' do
    book = described_class.new(author: '')
    expect(book).not_to be_valid
    expect(book.errors[:author]).to include("can't be blank")
  end

  it 'is not valid without a price' do
    book = described_class.new(price: nil)
    expect(book).not_to be_valid
    expect(book.errors[:price]).to include("can't be blank")
  end

  it 'is not valid with a negative price' do
    book = described_class.new(price: -1)
    expect(book).not_to be_valid
    expect(book.errors[:price]).to include('must be greater than or equal to 0')
  end

  it 'is not valid without a published date' do
    book = described_class.new(published_date: nil)
    expect(book).not_to be_valid
    expect(book.errors[:published_date]).to include("can't be blank")
  end
end
