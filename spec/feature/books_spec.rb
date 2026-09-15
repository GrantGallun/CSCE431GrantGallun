# Integration tests: use the real Add a Book form and check what the user sees.
require 'rails_helper'

RSpec.describe 'Adding a book', type: :feature do
  # Sunny day: valid inputs save the book, show the success notice on the Home Page,
  # and every attribute appears on the book's details page.
  scenario 'with valid inputs' do
    visit new_book_path
    fill_in 'Title', with: 'Clean Code'
    fill_in 'Author', with: 'Robert C. Martin'
    fill_in 'Price', with: '37.99'
    select '2008', from: 'book_published_date_1i'
    select 'August', from: 'book_published_date_2i'
    select '1', from: 'book_published_date_3i'
    expect { click_on 'Create Book' }.to change(Book, :count).by(1)

    expect(page).to have_current_path(books_path)
    expect(page).to have_css('#notice', text: 'Book "Clean Code" was successfully added.')

    # Match on the price so a seeded "Clean Code" row can't be picked instead.
    within('tr', text: '$37.99') { click_on 'Show' }
    expect(page).to have_content('Author Robert C. Martin')
    expect(page).to have_content('Price $37.99')
    expect(page).to have_content('Published date August 1, 2008')
  end

  # Rainy day: a blank title is rejected with an alert and the validation error.
  scenario 'with a blank title' do
    visit new_book_path
    fill_in 'Title', with: ''
    expect { click_on 'Create Book' }.not_to change(Book, :count)

    expect(page).to have_css('#alert', text: 'Book could not be added.')
    expect(page).to have_content("Title can't be blank")
  end

  scenario 'with a blank author' do
    visit new_book_path
    fill_in 'Author', with: ''
    expect { click_on 'Create Book' }.not_to change(Book, :count)

    expect(page).to have_content("Author can't be blank")
  end

  scenario 'with a blank price' do
    visit new_book_path
    fill_in 'Price', with: ''
    expect { click_on 'Create Book' }.not_to change(Book, :count)

    expect(page).to have_content("Price can't be blank")
  end

  scenario 'without choosing a published date from the drop-down' do
    visit new_book_path
    expect(page).to have_select('book_published_date_1i')
    expect { click_on 'Create Book' }.not_to change(Book, :count)

    expect(page).to have_content("Published date can't be blank")
  end
end
