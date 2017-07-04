CREATE TABLE ingredients(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(400)
);

CREATE TABLE users(
  id SERIAL4 PRIMARY KEY,
  email VARCHAR (500),
  password_digest TEXT
);
