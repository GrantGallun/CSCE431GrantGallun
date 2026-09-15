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
end
