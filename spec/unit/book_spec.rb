# Unit tests for the Book model.
require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { described_class.new(title: 'Clean Code') }

  # Sunny day: a book with a title is valid.
  it 'is valid with valid attributes' do
    expect(book).to be_valid
  end

  # Rainy day: a book with a blank title is rejected.
  it 'is not valid without a title' do
    book.title = ''
    expect(book).not_to be_valid
    expect(book.errors[:title]).to include("can't be blank")
  end
end
