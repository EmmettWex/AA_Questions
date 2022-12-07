PRAGMA foreign_keys = ON;
-- may need DROP TABLE thing later, leave it for now.

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255),
    lname VARCHAR(255)
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    body VARCHAR(255),
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
    parent_reply INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT,
    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(parent_reply) REFERENCES replies(id),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(quesion_id) REFERENCES questions(id)
);