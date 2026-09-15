# Integration tests for the User Books page (the home page).
require 'rails_helper'

RSpec.describe 'User Books', type: :feature do
  before do
    User.create!(username: 'Axolotl')
    Book.create!(title: 'Amazing turtles', author: 'Turtle Person', price: 9.99, published_date: Date.new(2020, 1, 1))
  end

  scenario 'the home page is User Books with links to books, users, and a new user book' do
    visit root_path

    expect(page).to have_css('h1', text: 'User Books')
    expect(page).to have_link('New User Book', href: new_user_book_path)
    expect(page).to have_link('Book index', href: books_path)
    expect(page).to have_link('User index', href: users_path)
  end

  scenario 'linking a user to a book with the drop-down lists' do
    visit new_user_book_path
    expect(page).to have_select('User', with_options: [ 'Axolotl' ])
    expect(page).to have_select('Book', with_options: [ 'Amazing turtles' ])

    select 'Axolotl', from: 'User'
    select 'Amazing turtles', from: 'Book'
    expect { click_on 'Create User book' }.to change(UserBook, :count).by(1)

    expect(page).to have_current_path(user_books_path)
    expect(page).to have_css('#notice', text: 'User book was successfully created.')
    within('#user_books') do
      expect(page).to have_content('Axolotl')
      expect(page).to have_content('Amazing turtles')
    end
  end

  scenario 'submitting without choosing a user or book' do
    visit new_user_book_path
    expect { click_on 'Create User book' }.not_to change(UserBook, :count)

    expect(page).to have_content('User must exist')
    expect(page).to have_content('Book must exist')
  end
end
