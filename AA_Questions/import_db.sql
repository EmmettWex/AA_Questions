DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255),
    lname VARCHAR(255)
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    body TEXT,
    author_id INTEGER,
    FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    question_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO users(fname, lname)
VALUES("Emmett", "Wechsler");

INSERT INTO questions(title, body, author_id)
VALUES ("Angry", "Why isn't this working!!!1!", 1);

INSERT INTO question_follows(question_id, user_id)
VALUES(1,1);

INSERT INTO replies(question_id, parent_reply_id, user_id, body)
VALUES(1, null, 1, "PLEASE HELP!!!");

INSERT INTO replies(question_id, parent_reply_id, user_id, body)
VALUES(1, 1, 1, "no way idiot hahaa");

INSERT INTO question_likes(user_id, question_id)
VALUES(1,1);