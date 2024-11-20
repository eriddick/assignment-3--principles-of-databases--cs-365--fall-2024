DROP DATABASE IF EXISTS student_passwords;

CREATE DATABASE student_passwords;

DROP USER IF EXISTS 'passwords_user'@'localhost';

CREATE USER 'passwords_user'@'localhost';
GRANT ALL ON student_passwords.* TO 'passwords_user'@'localhost';

USE student_passwords;

CREATE TABLE IF NOT EXISTS website (
  website_name VARCHAR(128) NOT NULL,
  website_url  VARCHAR(128) NOT NULL,
  PRIMARY KEY  (website_url)
);

CREATE TABLE IF NOT EXISTS user (
  website_url VARCHAR(128)  NOT NULL,
  user_name   VARCHAR(128) NOT NULL,
  email       VARCHAR(128) NOT NULL,
  PRIMARY KEY (website_url, user_name)
);

CREATE TABLE IF NOT EXISTS password (
  website_url  VARCHAR(128)  NOT NULL,
  user_name    VARCHAR(128)  NOT NULL,
  password     VARBINARY(512) NOT NULL,
  comment      VARCHAR(128) NULL,
  PRIMARY KEY (website_url, user_name, password)
);

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = '0xC64A1D87828CEE993608764155FE43D2C64A1D87828CEE993608764155FE43D2';
SET @init_vector = "0xC64A1D87828CEE993608764155FE43D2";

INSERT INTO website
VALUES
  ("Youtube", "https://www.youtube.com"),
  ("Blackboard", "https://www.blackboard.hartford.edu"),
  ("Wikipedia", "https://www.wikipedi.com"),
  ("GitHub", "https://www.github.com"),
  ("Facebook", "https://www.facebook.com"),
  ("Twitter", "https://www.twitter.com"),
  ("LinkedIn", "https://www.linkedin.com"),
  ("Instagram", "https://www.instagram.com"),
  ("Reddit", "https://www.reddit.com"),
  ("Netflix", "https://www.netflix.com");

INSERT INTO user
VALUES
  ("https://www.youtube.com", "graywick", "graywick@example.com"),
  ("https://www.blackboard.hartford.edu", "jdoe", "jdoe@hartford.edu"),
  ("https://www.wikipedia.com", "janesmith", "janesmith@example.com"),
  ("https://www.github.com", "octocat", "octocat@github.com"),
  ("https://www.facebook.com", "fb_user123", "fb_user123@facebook.com"),
  ("https://www.twitter.com", "bird", "bird@twitter.com"),
  ("https://www.linkedin.com", "pro_networker", "pro_networker@linkedin.com"),
  ("https://www.instagram.com", "jdog", "jdog@instagram.com"),
  ("https://www.reddit.com", "redditor_expert", "redditor_expert@reddit.com"),
  ("https://www.netflix.com", "binge_watcher", "binge_watcher@netflix.com");

INSERT INTO password
VALUES
  ("https://www.youtube.com", "graywick", AES_ENCRYPT('door5497', @key_str, @init_vector), "No comment"),
  ("https://www.blackboard.hartford.edu", "jdoe", AES_ENCRYPT('classroom99', @key_str, @init_vector), "2024-10-03 18:23:53"),
  ("https://www.wikipedia.com", "janesmith", AES_ENCRYPT('g62^43pl', @key_str, @init_vector), "2024-10-05 7:22:18"),
  ("https://www.github.com", "octocat", AES_ENCRYPT('james007', @key_str, @init_vector), "2024-10-06 12:53:10"),
  ("https://www.facebook.com", "fb_user123", AES_ENCRYPT('fbuser987', @key_str, @init_vector), "2024-10-08 14:12:33"),
  ("https://www.twitter.com", "bird", AES_ENCRYPT('tw33t890', @key_str, @init_vector), "2024-10-10 14:30:34"),
  ("https://www.linkedin.com", "pro_networker", AES_ENCRYPT('lulo0909', @key_str, @init_vector), "2024-10-11 12:00:58"),
  ("https://www.instagram.com", "jdog", AES_ENCRYPT('sol20$f', @key_str, @init_vector), "2024-10-11 13:03:10"),
  ("https://www.reddit.com", "redditor_expert", AES_ENCRYPT('losttime2', @key_str, @init_vector), "2024-10-12 06:21:24"),
  ("https://www.netflix.com", "binge_watcher", AES_ENCRYPT('strangerthings', @key_str, @init_vector), "2024-10-12 16:43:46");
