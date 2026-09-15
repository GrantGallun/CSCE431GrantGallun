# Week 3 lab requirement: a test that runs against the TEST database once it has
# been populated from db/seeds.rb. find_or_create_by! in the seed file makes this
# idempotent, so it's safe to run standalone:
#   RAILS_ENV=test bundle exec rspec spec/unit/seeded_books_spec.rb
require 'rails_helper'

RSpec.describe 'db/seeds.rb', type: :model do
  it 'loads at least 5 books into the TEST database' do
    load Rails.root.join('db/seeds.rb')

    expect(Book.count).to be >= 5
    expect(Book.pluck(:title)).to include('The Hobbit', 'Dune', 'Clean Code')
  end

  it 'links sample users to books and can be run again without duplicating anything' do
    load Rails.root.join('db/seeds.rb')
    expect(User.find_by!(username: 'Axolotl').books.pluck(:title)).to contain_exactly('Dune', 'The Hobbit')

    # Works whether or not the test database was already seeded.
    expect { load Rails.root.join('db/seeds.rb') }.not_to change { [ Book.count, User.count, UserBook.count ] }
  end
end
