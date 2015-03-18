DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  parent_question INTEGER NOT NULL,
  parent_reply INTEGER,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (parent_question) REFERENCES questions(id),
  FOREIGN KEY (parent_reply) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Enoch', 'Root'), ('Hoid', 'Wit'), ('Jenny', 'Everywhere'), ('Paul', 'Chandler');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('I have never begged you before', 'I do so now.', 2),
  ('Alchemy', 'Just because you only see me around alchemists you assume
    I am an alchemist. Should I assume the same of you?', 1),
  ('Oath', 'This is my power, this is my fight, shine through the void with orange light', 4);

INSERT INTO
  replies (parent_question, parent_reply, body, user_id)
VALUES
  (1, NULL, 'Lorem ipsum dolor sit amet. Nil consectur, nil vescit.', 3),
  (1, 1, 'O sibili si ergo, fortibus es inero. O nobili desar trux.', 2),
  (1, 2, 'Si quad sinem? Causen dux.', 3),
  (2, NULL, 'Pellentesque vitae augue mauris. In vel mattis justo. Nulla
    pulvinar dolor in massa suscipit, at sodales orci interdum. Quisque et
    tempor purus, vitae pretium libero. Duis faucibus
    velit in mattis pellentesque.', 4);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1,1), (2,3), (4, 3), (1, 2);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1,3), (2,3), (3, 1), (3, 2), (3, 3);
