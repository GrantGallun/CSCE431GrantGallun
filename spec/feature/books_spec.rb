# Integration tests: add a book through the real form and check the flash notice.
require 'rails_helper'

RSpec.describe 'Adding a book', type: :feature do
  # Sunny day: a valid title saves the book and shows the success notice on the Home Page.
  scenario 'with a valid title' do
    visit new_book_path
    fill_in 'Title', with: 'Clean Code'
    click_on 'Create Book'

    expect(page).to have_current_path(books_path)
    expect(page).to have_css('#notice', text: 'Book "Clean Code" was successfully added.')
    expect(page).to have_content('Clean Code')
    expect(Book.count).to eq(1)
  end

  # Rainy day: a blank title is rejected with an alert and the validation error.
  scenario 'with a blank title' do
    visit new_book_path
    fill_in 'Title', with: ''
    click_on 'Create Book'

    expect(page).to have_css('#alert', text: 'Book could not be added.')
    expect(page).to have_content("Title can't be blank")
    expect(Book.count).to eq(0)
  end
end
