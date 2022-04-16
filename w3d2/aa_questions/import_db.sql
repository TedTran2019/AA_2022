PRAGMA foreign_keys = ON;

DROP TABLE if exists question_likes;
DROP TABLE if exists replies;
DROP TABLE if exists question_follows;
DROP TABLE if exists questions;
DROP TABLE if exists users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER, 
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Ted', 'Tran'),
  ('Helen', 'Yu'),
  ('Brian', 'Vu');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('How long to sous vide a steak?', '3 inch thickness, pls answer quick!', 
  (SELECT id FROM users WHERE fname = 'Ted' AND lname = 'Tran')),
  ('How to draw a cat?', 'I like cats', 
  (SELECT id FROM users WHERE fname = 'Helen' AND lname = 'Yu')),
   ('How to beat Elden Ring', 'Game is hard', 
  (SELECT id FROM users WHERE fname = 'Brian' AND lname = 'Vu'));

  INSERT INTO
    question_follows(question_id, follower_id)
  VALUES
    (1, 2), (1, 3), (2, 1), (2, 3), (3, 3);

  INSERT INTO
    replies(question_id, parent_id, author_id, body)
  VALUES
    (1, NULL, 2, 'Steak is bad!'),
    (1, 1, 1, 'You are bad'),
    (2, NULL, 3, 'Kitty is the best cat');

  INSERT INTO
    question_likes(question_id, user_id)
  VALUES
    (1, 2), (1, 3), (2, 1)
