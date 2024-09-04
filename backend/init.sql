

/* JWT */
CREATE TABLE tokens (
  user_id bigint NOT NULL,
  status boolean NOT NULL DEFAULT FALSE,
  created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  access_token character varying(512) NOT NULL,
  refresh_token character varying(512) NOT NULL
);


CREATE TABLE posts (
  id character varying(32) NOT NULL,
  user_id bigint NOT NULL,
  parent_id bigint NULL DEFAULT NULL,
  meta_title character varying(100) NULL,
  title character varying(75) NOT NULL,
  cover character varying(100) NOT NULL,
  summary text NULL,
  content text NULL DEFAULT NULL,
  is_published boolean NOT NULL DEFAULT FALSE,
  created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  published_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE post_category (
  id SERIAL PRIMARY KEY,
  post_id BIGINT NOT NULL,
  category_id BIGINT NOT NULL
);
CREATE TABLE category (
  id SERIAL PRIMARY KEY,
  parent_id BIGINT NULL DEFAULT NULL,
  title character varying(75) NOT NULL,
  content TEXT NULL DEFAULT NULL
);


/*
https://wordpress.com/support/invite-people/user-roles/

Administrator: The highest level of permission. Admins have the power to access almost everything.
Editor: Has access to all posts, pages, comments, categories, and tags, and can upload media.
Author: Can write, upload media, edit, and publish their own posts.
Contributor: Has no publishing or uploading capability but can write and edit their own posts until they are published.
Viewer: Viewers can read and comment on posts and pages on private sites.
Subscriber: People who subscribe to your site’s updates.
*/
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  role character varying(16) NOT NULL DEFAULT 'subscriber',

  username character varying(32) UNIQUE NOT NULL,
  email character varying(64) UNIQUE NOT NULL,
  registered_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  last_login_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  hashed_password character varying(72) NULL DEFAULT NULL,
  activation_key character varying(32) NULL DEFAULT NULL,

  avatar_url character varying(64) NULL DEFAULT NULL,
  intro text NULL DEFAULT NULL,
  profile text NULL DEFAULT NULL
);

CREATE TABLE person (
  id SERIAL PRIMARY KEY,
  first_name character varying(64) NULL DEFAULT NULL,
  last_name character varying(64) NULL DEFAULT NULL,
  birth timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  gender character varying(16) NOT NULL,
  phone_number character varying(16) NULL DEFAULT NULL,
  mobile_phone_number character varying(16) NULL DEFAULT NULL,
  created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  modified_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE comment (
  id SERIAL PRIMARY KEY,
  post_id BIGINT NOT NULL,
  parent_id BIGINT NULL DEFAULT NULL,
  title VARCHAR(75) NOT NULL,
  content TEXT NULL DEFAULT NULL,
  is_published boolean NOT NULL DEFAULT FALSE,
  created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  published_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
