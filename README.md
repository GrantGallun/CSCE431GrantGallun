# Book Collection

CSCE 431 individual assignment series (Grant Gallun). A Rails 8.1 + PostgreSQL app for
keeping track of books, which users own them, and deploying it to Heroku.

## Run locally (course Docker image)

```bash
docker run -dit --name bookcollection -p 3000:3000 \
  -e DATABASE_USER=csce431 -e DATABASE_PASSWORD=password \
  -v "$PWD:/app" paulinewade/csce431:sp26v1
docker exec -it -w /app bookcollection bash
# inside the container
bundle install
bin/rails db:prepare db:seed
bin/rails server -b 0.0.0.0     # http://localhost:3000
bundle exec rspec               # unit + integration tests
```

## User stories and acceptance criteria

These are the stories the instructional team can use to test the deployed app.

### 1. See my book collection
As a reader, I want to see all my books on one page so that I know what I own.
- Given books exist, when I open the Book index, then I see each book's title, author, price and published date.
- Each row has Show, Edit and Delete links.
- There is an "Add a Book" link.

### 2. Add a book
As a reader, I want to add a book so that my collection stays current.
- Given I am on "Add a Book", when I enter a title, author, price and choose a published date from the drop-down menus and press "Create Book", then I return to the Book index and see the notice `Book "<title>" was successfully added.`
- When any field is blank, the book is not saved, I see the alert "Book could not be added." and a message such as "Title can't be blank".
- A negative price is rejected.

### 3. View a book's details
As a reader, I want to open one book so that I can see all of its information.
- When I click "Show", I see the title, author, price (as currency) and published date.
- The page has Edit, Delete and "Back to Books" links.

### 4. Update a book
As a reader, I want to correct a book's details.
- When I click "Edit", the form is pre-filled with the current values.
- When I save valid changes, I return to the Book index and see `Book "<title>" was successfully updated.`
- Invalid changes are not saved and the errors are shown.

### 5. Delete a book
As a reader, I want to remove a book, with a chance to change my mind.
- When I click "Delete", I see a confirmation page asking "Are you sure you want to permanently delete this book?"
- Pressing "Delete Book" removes it and shows `Book "<title>" was successfully deleted.` on the Book index.
- "Cancel" returns to the book without deleting it.

### 6. Navigate back
- Every Book page other than the Book index has a "Back to Books" link, and the Book index links to the home page.

### 7. Record which users own which books (Book Collection 4)
As a librarian, I want to link users to books so that I can see who owns what.
- The home page (`/`) is "User Books": a table of username and book title with Show, Edit and Destroy links.
- "New User Book" shows drop-down lists containing only existing users and existing books.
- The page links to "New User Book", "Book index" and "User index".
- The User index lists usernames with Show, Edit and Destroy links and a "New User" link.

## Deploying to Heroku

The repo contains a `Procfile` (web process; release phase runs `db:migrate` and the
idempotent `db:seed`) and `app.json` (Postgres add-on and settings for review apps).
Production uses the single `DATABASE_URL` Heroku provides.

1. Create a pipeline and connect this GitHub repository.
2. Enable Review Apps (they are built from `app.json`) and open one for the `test` branch.
3. Create a staging app with the `heroku-postgresql:essential-0` add-on. Enable automatic
   deploys from `main`. (The Ruby buildpack sets `SECRET_KEY_BASE`; the app stores no other secrets.)
4. Merge `test` into `main`, check that staging works, then promote staging to production.
