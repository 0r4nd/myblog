

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
  category character varying(128) NOT NULL DEFAULT 'Uncategorized',
  summary text NULL,
  content text NULL DEFAULT NULL,
  is_published boolean NOT NULL DEFAULT FALSE,
  created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  published_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE category (
  id character varying(32) NOT NULL,
  parent_id character varying(32) DEFAULT NULL,
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




/* Users */
INSERT INTO users (id, role, username, email, registered_at) VALUES
(DEFAULT, 'administrator', 'admin', 'admin@admin.com', DEFAULT);
-- (DEFAULT, 'administrator', 'Jon Doe', 'jondoe@admin.com', DEFAULT);


/* Posts */

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('52156DfF2D52Db1FAcE9777b5653f9C9',
2,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('Bc5BED9B89b3BA24Bb7614a71034f7fe',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('8f893e26Ece26c0bA24218260177239a',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('33053AefB170DEab3fb52AB1D6D4d885',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('4928a498Ab7BAFF317F6aD2b42851B6c',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('B46D9Ffa8F8696d410b80F2153b5dF88',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('656Fef7350fd75F2c3416A0D5D3D942f',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('4CC670dc8795e97C375d9C646ec636A3',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('1A08D456afb0Fa6cD6e808efDd75625e',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);

INSERT INTO posts (id, user_id, parent_id, meta_title, title, cover, category, summary, content, is_published, created_at, updated_at, published_at) VALUES
('71d80C9B0B5A90072e790a3496b158Ff',
1,
NULL,
'meta_title',
'Lorem ipsum! 🙂',
'robots.webp',
'Speech synthesis|Database|Cloud',
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero',
'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed malesuada mattis bibendum. Donec eget arcu ex. Pellentesque tristique sapien libero, eu bibendum ex scelerisque sit amet. Quisque consectetur, massa ac blandit posuere, arcu felis porttitor velit, sit amet molestie neque augue a magna. Maecenas semper nibh sodales ante ullamcorper, non tincidunt eros eleifend. Fusce laoreet ligula ac nulla placerat, quis laoreet purus dictum. Mauris ultrices nunc pretium massa facilisis, in suscipit tortor pulvinar. Ut ornare odio justo, vel rhoncus sapien blandit quis. Donec malesuada massa a nulla pretium, at aliquet massa suscipit. Nunc id est eu nunc accumsan blandit vitae at eros. Praesent lobortis ut tortor quis volutpat. Nulla dignissim malesuada lacinia. Integer interdum sapien nec nulla egestas, nec lacinia felis mattis. Nulla tristique ac elit non iaculis. Nunc faucibus eleifend hendrerit. In porta mollis magna nec euismod. Vestibulum a finibus lorem, a maximus magna. Donec congue ipsum at imperdiet venenatis. Sed nec dui nulla. Nam eget tincidunt est. Maecenas augue tellus, iaculis eu erat faucibus, sodales pulvinar libero. Mauris tristique commodo pulvinar. Mauris sit amet ornare augue. Morbi nec ipsum nec enim condimentum consequat. Cras eget lacus et ante bibendum laoreet id eget sapien. Maecenas interdum, dolor ac aliquam iaculis, lacus tellus ultricies orci, a porta erat tortor sed tellus. Maecenas eu ornare ligula, non semper est. In hac habitasse platea dictumst. Pellentesque a libero sed erat aliquam ultrices. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque posuere nisi in dolor consequat, eu pulvinar orci dictum. Pellentesque mollis neque a ipsum consequat vestibulum. Aliquam cursus semper nisi. Sed id tortor turpis. Sed cursus ex malesuada lectus efficitur sodales. Quisque vel interdum est, a ullamcorper nunc. Vestibulum vehicula, nibh eget ultrices sollicitudin, diam mauris porttitor ante, nec eleifend nulla nulla iaculis lectus. Praesent a pellentesque massa. Nulla iaculis arcu ac nisl mollis, eget consequat nisi imperdiet. Aenean sem nisi, scelerisque tristique placerat eget, sagittis quis lectus. Quisque diam lorem, dapibus vitae elit ac, tincidunt tincidunt velit. Fusce sit amet sapien eu ligula scelerisque commodo. Pellentesque at commodo eros. Curabitur tempor lorem eget dolor ullamcorper tempor. Vestibulum mollis eros ac enim efficitur maximus. Donec ut nulla quis nisi pellentesque semper dignissim id dui. Integer congue convallis tellus, at consequat lacus commodo id. Nunc maximus, magna et egestas aliquet, velit velit dapibus lorem, tincidunt condimentum augue quam quis purus. Sed eu urna dolor. Nullam eleifend aliquam luctus. Phasellus malesuada fermentum purus, non tempus magna sagittis eu. Vestibulum elit enim, commodo id tellus et, euismod vehicula augue. Vestibulum bibendum massa tincidunt, blandit orci non, mattis quam. Aliquam eleifend neque laoreet ante molestie finibus. Maecenas fringilla massa et interdum sollicitudin. Proin vel quam ex. Cras consectetur quam neque, at lobortis purus auctor sed. Vivamus commodo eleifend purus, eu eleifend ipsum. Aliquam venenatis in nisl in fringilla. Sed bibendum tincidunt lectus id tristique. Nunc ut sem in ipsum consequat aliquam. Pellentesque ut egestas dui, eu ornare lectus. In tincidunt magna vel ligula rutrum condimentum. Vivamus vehicula justo at ex ultrices imperdiet. Nullam semper pellentesque dui, vitae tincidunt arcu iaculis eu. </p>',
TRUE,
DEFAULT,
DEFAULT,
DEFAULT);



/* Categories */
INSERT INTO category (id, parent_id, content) VALUES
('Uncategorized', DEFAULT, ''),
('Database', DEFAULT, ''),
('Cloud', DEFAULT, ''),
('Machine learning', DEFAULT, ''),
('Deep learning', DEFAULT, ''),
('Speech recognition', DEFAULT, ''),
('Speech synthesis', DEFAULT, ''),
('Security', DEFAULT, ''),
('Industrial robotics', DEFAULT, ''),
('Home robotics', DEFAULT, ''),
('Robotics', DEFAULT, '');
