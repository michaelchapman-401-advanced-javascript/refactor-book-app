DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS bookshelves;

CREATE TABLE IF NOT EXISTS bookshelves (
  id SERIAL PRIMARY KEY,
  name VARCHAR(222)
);

CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(222),
  author VARCHAR(222),
  isbn TEXT,
  image_url TEXT,
  description TEXT,
  bookshelf_id INT REFERENCES bookshelves(id)
);

CREATE TABLE BOOKSHELVES (id SERIAL PRIMARY KEY, name VARCHAR(255));

INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

ALTER TABLE books ADD COLUMN bookshelf_id INT;

UPDATE books SET bookshelf_id=subquery.id FROM (SELECT * FROM bookshelves) AS subquery WHERE books.bookshelf = subquery.name;

ALTER TABLE books DROP COLUMN bookshelf;

ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);
