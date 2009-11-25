CREATE TABLE bookings (
id INTEGER AUTO_INCREMENT NOT NULL, 
"from" DATE, 
"to" DATE, 
nights INTEGER, 
persons INTEGER, 
with_animals INTEGER, 
notes TEXT, 
phone VARCHAR(255), 
mobile VARCHAR(255), 
email VARCHAR(255), 
firstname VARCHAR(255), 
lastname VARCHAR(255), 
company VARCHAR(255), address VARCHAR(255), city VARCHAR(255), postcode VARCHAR(255), country VARCHAR(255), created_at DATETIME, updated_at DATETIME, status_id INTEGER DEFAULT 0);
CREATE TABLE discount_translations (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, discount_id INTEGER, locale VARCHAR(255), description VARCHAR(255), created_at DATETIME, updated_at DATETIME);
CREATE TABLE discounts (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, house_id INTEGER, created_at DATETIME, updated_at DATETIME);
CREATE TABLE house_translations (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, house_id INTEGER, locale VARCHAR(255), house_description VARCHAR(255), created_at DATETIME, updated_at DATETIME);
CREATE TABLE houses (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, city_id INTEGER, code VARCHAR(255), house_type_id INTEGER, condition_id INTEGER, furnishing_id INTEGER, persons INTEGER, floor_area INTEGER, animals INTEGER, distance_center INTEGER, distance_beach INTEGER, distance_restaurant INTEGER, admin_description VARCHAR(255), hidden_description VARCHAR(255), created_at DATETIME, updated_at DATETIME, bedroom INTEGER, living_room INTEGER, living_dining_room INTEGER, living_dining_kitchen INTEGER, kitchen INTEGER, dining_room INTEGER, kitchen_dining_room INTEGER, children INTEGER, terrace_id INTEGER, garden INTEGER, living_room_sq VARCHAR(255), living_dining_room_sq VARCHAR(255), kitchen_sq VARCHAR(255), kitchen_dining_room_sq VARCHAR(255), dining_room_sq VARCHAR(255), living_dining_kitchen_sq VARCHAR(255), terrace_sq VARCHAR(255), balcony_sq VARCHAR(255), yard_sq VARCHAR(255), double_bed INTEGER, single_bed VARCHAR(255), extra_bed INTEGER, pull_out_bed INTEGER, bathrooms INTEGER, shower INTEGER, bathtub INTEGER, wcs INTEGER, wc_separated INTEGER, fridge INTEGER, coffee_machine INTEGER, micro INTEGER, stove_id INTEGER, sat INTEGER, internet INTEGER, clima_id INTEGER, pool INTEGER, pool_sq INTEGER, garden_seats INTEGER, grill INTEGER, sunbath_seat INTEGER, playground INTEGER, parking_id INTEGER, distance_aquapark INTEGER, distance_shop INTEGER, distance_station INTEGER, distance_medical INTEGER, distance_mainroad INTEGER, owner_place_id INTEGER, animal_charge INTEGER, price_pre_season_per_day decimal, price_mid_season_per_day decimal, price_main_season_per_day decimal, price_pre_season_per_week decimal, price_mid_season_per_week decimal, price_main_season_per_week decimal, pictures VARCHAR(255), balcony_id INTEGER);
CREATE TABLE houses_bookings (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, house_id INTEGER, booking_id INTEGER, position INTEGER, created_at DATETIME, updated_at DATETIME);
CREATE TABLE houses_taggables (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, house_id INTEGER, taggable_id INTEGER, created_at DATETIME, updated_at DATETIME);
CREATE TABLE houses_tags (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, house_id INTEGER, tag_id INTEGER, created_at DATETIME, updated_at DATETIME);
CREATE TABLE page_translations (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, page_id INTEGER, locale VARCHAR(255), body TEXT, title VARCHAR(255), created_at DATETIME, updated_at DATETIME);
CREATE TABLE pages (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, published INT, created_at DATETIME, updated_at DATETIME, path VARCHAR(255));
CREATE TABLE reservations (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, house_id INTEGER, from DATE, to DATE, persons INTEGER, user_id INTEGER, status INTEGER, comment TEXT, created_at DATETIME, updated_at DATETIME);
CREATE TABLE schema_migrations (version VARCHAR(255) NOT NULL);
CREATE TABLE sessions (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, session_id VARCHAR(255) NOT NULL, data TEXT, created_at DATETIME, updated_at DATETIME);
CREATE TABLE tag_translations (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, tag_id INTEGER, locale VARCHAR(255), name VARCHAR(255), created_at DATETIME, updated_at DATETIME);
CREATE TABLE taggable_translations (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, taggable_id INTEGER, locale VARCHAR(255), context VARCHAR(255), name VARCHAR(255), created_at DATETIME, updated_at DATETIME);
CREATE TABLE taggables (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, field VARCHAR(255), multi INTEGER, position INTEGER, created_at DATETIME, updated_at DATETIME);
CREATE TABLE tags (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, taggable_id INTEGER, created_at DATETIME, updated_at DATETIME);
CREATE TABLE users (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, username VARCHAR(255), email VARCHAR(255), crypted_password VARCHAR(255), password_salt VARCHAR(255), persistence_token VARCHAR(255) NOT NULL, created_at DATETIME, updated_at DATETIME);
CREATE INDEX index_sessions_on_session_id ON sessions (session_id);
CREATE INDEX index_sessions_on_updated_at ON sessions (updated_at);
CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations (version);
INSERT INTO schema_migrations (version) VALUES ('20090615231054');

INSERT INTO schema_migrations (version) VALUES ('20090615231132');

INSERT INTO schema_migrations (version) VALUES ('20090630211432');

INSERT INTO schema_migrations (version) VALUES ('20090801050318');

INSERT INTO schema_migrations (version) VALUES ('20090808161325');

INSERT INTO schema_migrations (version) VALUES ('20090812174135');

INSERT INTO schema_migrations (version) VALUES ('20090812174422');

INSERT INTO schema_migrations (version) VALUES ('20090812185844');

INSERT INTO schema_migrations (version) VALUES ('20090812192438');

INSERT INTO schema_migrations (version) VALUES ('20090822230337');

INSERT INTO schema_migrations (version) VALUES ('20090823131409');

INSERT INTO schema_migrations (version) VALUES ('20090913100713');

INSERT INTO schema_migrations (version) VALUES ('20090913100952');

INSERT INTO schema_migrations (version) VALUES ('20090928165657');

INSERT INTO schema_migrations (version) VALUES ('20091027204029');

INSERT INTO schema_migrations (version) VALUES ('20091028200419');

INSERT INTO schema_migrations (version) VALUES ('20091101101934');

INSERT INTO schema_migrations (version) VALUES ('20091103221556');