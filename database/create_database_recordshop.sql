USE sys;

# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          RecordShop                                      #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS recordshop;

CREATE DATABASE IF NOT EXISTS recordshop;

USE recordshop;

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #

CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE profiles (
    user_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(200) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE categories (
    category_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    PRIMARY KEY (category_id)
);

CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    subcategory VARCHAR(20),
    image_url VARCHAR(200),
    stock INT NOT NULL DEFAULT 0,
    featured BOOL NOT NULL DEFAULT 0,
    PRIMARY KEY (product_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    date DATETIME NOT NULL,
    address VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL,
    shipping_amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_line_items (
    order_line_item_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    sales_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(10, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_line_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- new tables
CREATE TABLE shopping_cart (
	user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/*  INSERT Users  */
INSERT INTO users (username, hashed_password, role) 
VALUES  ('user','$2a$10$NkufUPF3V8dEPSZeo1fzHe9ScBu.LOay9S3N32M84yuUM2OJYEJ/.','ROLE_USER'),
        ('admin','$2a$10$lfQi9jSfhZZhfS6/Kyzv3u3418IgnWXWDQDk7IbcwlCFPgxg9Iud2','ROLE_ADMIN'),
        ('george','$2a$10$lfQi9jSfhZZhfS6/Kyzv3u3418IgnWXWDQDk7IbcwlCFPgxg9Iud2','ROLE_USER');

/* INSERT Profiles */
INSERT INTO profiles (user_id, first_name, last_name, phone, email, address, city, state, zip)
VALUES  (1, 'Joe', 'Joesephus', '800-555-1234', 'joejoesephus@email.com', '789 Oak Avenue', 'Dallas', 'TX', '75051'),
        (2, 'Adam', 'Admamson', '800-555-1212', 'aaadamson@email.com', '456 Elm Street','Dallas','TX','75052'),
        (3, 'George', 'Jetson', '800-555-9876', 'george.jetson@email.com', '123 Birch Parkway','Dallas','TX','75051')     ;

/* INSERT Categories */
INSERT INTO categories (name, description) 
VALUES  ('Vinyl Records', 'Discover classic and modern albums on vinyl format.'),
        ('CDs', 'Browse our extensive collection of compact discs.'),
        ('Music Accessories', 'Everything you need for your music setup and collection.');

/* INSERT Products */
-- Vinyl Records
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('The Beatles - Abbey Road Vinyl', 29.99, 1, 'Classic Beatles album remastered on 180-gram vinyl.', 'abbey-road-vinyl.jpg', 50, 1, 'Rock'),
        ('Pink Floyd - Atom Heart Mother Vinyl', 36.99, 1, 'Experimental progressive rock with orchestral arrangements.', 'atom-heart-mother-vinyl.jpg', 25, 1, 'Rock'),
        ('Led Zeppelin IV Vinyl', 32.99, 1, 'Rock masterpiece featuring Stairway to Heaven.', 'led-zeppelin-iv-vinyl.jpg', 25, 0, 'Rock'),
        ('Miles Davis - Kind of Blue Vinyl', 39.99, 1, 'Essential jazz album on premium vinyl pressing.', 'kind-of-blue-vinyl.jpg', 20, 1, 'Jazz'),
        ('Fleetwood Mac - Rumours Vinyl', 31.99, 1, 'Best-selling album with hits like Go Your Own Way.', 'rumours-vinyl.jpg', 40, 0, 'Rock'),
        ('Simon & Garfunkel - Bookends Vinyl', 32.99, 1, 'Folk rock masterpiece with Mrs. Robinson and America.', 'bookends-vinyl.jpg', 30, 1, 'Folk'),
        ('Bob Marley - Legend Vinyl', 33.99, 1, 'Greatest hits collection from the reggae legend.', 'legend-vinyl.jpg', 30, 0, 'Reggae'),
        ('Queen - A Night at the Opera Vinyl', 36.99, 1, 'Features the epic Bohemian Rhapsody.', 'night-opera-vinyl.jpg', 15, 1, 'Rock'),
        ('Johnny Cash - At Folsom Prison Vinyl', 29.99, 1, 'Live country classic recorded in prison.', 'folsom-prison-vinyl.jpg', 25, 0, 'Country'),
        ('Stevie Wonder - Songs in the Key of Life Vinyl', 45.99, 1, 'Double album soul masterpiece.', 'key-of-life-vinyl.jpg', 20, 0, 'R&B'),
        ('David Bowie - The Rise and Fall of Ziggy Stardust Vinyl', 33.99, 1, 'Glam rock concept album classic.', 'ziggy-stardust-vinyl.jpg', 30, 1, 'Rock'),
        ('The Rolling Stones - Goats Head Soup Vinyl', 34.99, 1, 'Rock and roll but with soup and goats', 'sticky-fingers-vinyl.jpg', 25, 0, 'Rock'),
        ('Billie Eilish - When We All Fall Asleep Vinyl', 27.99, 1, 'Modern pop sensation on colored vinyl.', 'billie-eilish-vinyl.jpg', 50, 1, 'Pop'),
        ('The Animals - The Animals Vinyl', 28.99, 1, 'British blues rock classic with House of the Rising Sun.', 'animals-vinyl.jpg', 40, 0, 'Rock'),
        ('Mac Miller - Balloonerism Vinyl', 34.99, 1, 'Posthumous experimental hip-hop album on colored vinyl.', 'balloonerism-vinyl.jpg', 30, 1, 'Hip-Hop'),
        ('Radiohead - OK Computer Vinyl', 38.99, 1, 'Alternative rock masterpiece on vinyl.', 'ok-computer-vinyl.jpg', 20, 1, 'Alternative'),
        ('Joni Mitchell - Hejira Vinyl', 38.99, 1, 'Folk jazz masterpiece with introspective songwriting.', 'hejira-vinyl.jpg', 25, 0, 'Folk'),
        ('Parquet Courts - Wide Awake! Vinyl', 29.99, 1, 'Post-punk revival with political commentary.', 'parquet-courts-vinyl.jpg', 35, 0, 'Alternative'),
        ('Kendrick Lamar - DAMN. Vinyl', 35.99, 1, 'Pulitzer Prize-winning hip-hop album. by Toyin Ojih Odutola Gallery Vinyl', 'damn-vinyl.jpg', 25, 1, 'Hip-Hop'),
        ('Tame Impala - Currents Vinyl', 34.99, 1, 'Psychedelic pop masterpiece on colored vinyl.', 'currents-vinyl.jpg', 30, 0, 'Electronic'),
        ('King Gizzard - Flight b741 Vinyl', 32.99, 1, 'Australian psych rock experimental album on vinyl.', 'king-gizzard-flight-vinyl.jpg', 25, 0, 'Rock');

-- CDs
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('The Beatles - White Album CD', 15.99, 2, 'Double CD remaster of the iconic White Album.', 'white-album-cd.jpg', 60, 0, 'Rock'),
        ('Miles Davis - Kind of Blue CD', 16.99, 2, 'Essential jazz masterpiece and legendary recording.', 'kind-of-blue-cd.jpg', 45, 1, 'Jazz'),
        ('AC/DC - Back in Black CD', 14.99, 2, 'Hard rock classic remastered.', 'back-in-black-cd.jpg', 50, 0, 'Rock'),
        ('The Cars - Cars CD', 14.99, 2, 'New wave classic with Drive and Just What I Needed.', 'cars-cars-cd.jpg', 35, 0, 'Rock'),
        ('U2 - The Joshua Tree CD', 16.99, 2, 'Irish rock band''s most acclaimed work.', 'joshua-tree-cd.jpg', 35, 1, 'Rock'),
        ('Metallica - Master of Puppets CD', 17.99, 2, 'Thrash metal masterpiece remastered.', 'master-puppets-cd.jpg', 45, 0, 'Rock'),
        ('Motörhead - Ace of Spades CD', 16.99, 2, 'Heavy metal classic with the iconic title track.', 'ace-of-spades-cd.jpg', 40, 1, 'Rock'),
        ('Nirvana - MTV Unplugged in New York CD', 14.99, 2, 'Acoustic performance capturing raw emotion.', 'unplugged-cd.jpg', 35, 0, 'Alternative'),
        ('Red Hot Chili Peppers - By the way CD', 15.99, 2, 'Funk rock album with hit singles.', 'blood-sugar-cd.jpg', 30, 0, 'Rock'),
        ('Radiohead - Pablo Honey CD', 16.99, 2, 'Alternative rock evolution before OK Computer.', 'bends-cd.jpg', 25, 0, 'Alternative'),
        ('Oasis - (What''s the Story) Morning Glory? CD', 14.99, 2, 'Britpop classic with Wonderwall and Champagne Supernova.', 'morning-glory-cd.jpg', 40, 1, 'Rock'),
        ('Foo Fighters - The Colour and the Shape CD', 15.99, 2, 'Post-grunge album with Everlong and My Hero.', 'colour-shape-cd.jpg', 35, 0, 'Alternative'),
        ('Beastie Boys - License to Ill CD', 15.99, 2, 'Hip-hop classic debut album with Fight For Your Right.', 'license-to-ill-cd.jpg', 40, 0, 'Hip-Hop'),
        ('Pearl Jam - Ten CD', 16.99, 2, 'Grunge classic debut album.', 'ten-cd.jpg', 30, 0, 'Alternative'),
        ('Soundgarden - Superunknown CD', 17.99, 2, 'Heavy alternative rock with Black Hole Sun.', 'superunknown-cd.jpg', 25, 0, 'Alternative'),
        ('Stone Temple Pilots - Core CD', 14.99, 2, 'Grunge and hard rock hybrid.', 'core-cd.jpg', 30, 0, 'Alternative'),
        ('Alice in Chains - Dirt CD', 15.99, 2, 'Dark grunge masterpiece.', 'dirt-cd.jpg', 25, 1, 'Alternative'),
        ('Sublime - 40oz. to Freedom CD', 13.99, 2, 'Ska punk classic with reggae influences.', 'sublime-cd.jpg', 40, 0, 'Reggae'),
        ('Blink-182 - Enema of the State CD', 12.99, 2, 'Pop punk album that defined late 90s.', 'enema-state-cd.jpg', 45, 0, 'Pop');

-- Music Accessories
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('Audio-Technica AT-LP120XUSB Turntable', 349.99, 3, 'Professional direct drive turntable with USB output.', 'turntable.jpg', 15, 1, 'Silver'),
        ('Sony MDR-7506 Headphones', 99.99, 3, 'Professional studio monitor headphones.', 'headphones.jpg', 40, 1, 'Black'),
        ('Vinyl Record Storage Crate', 29.99, 3, 'Wooden crate holds up to 100 LP records.', 'record-crate.jpg', 50, 0, 'Brown'),
        ('Anti-Static Record Cleaning Kit', 24.99, 3, 'Complete kit for maintaining your vinyl collection.', 'cleaning-kit.jpg', 75, 1, 'Blue'),
        ('Stylus Replacement Cartridge', 79.99, 3, 'High-quality replacement stylus for turntables.', 'stylus.jpg', 30, 0, 'Silver'),
        ('Record Player Preamp', 129.99, 3, 'Phono preamp for connecting turntables to modern systems.', 'preamp.jpg', 20, 0, 'Black'),
        ('CD Storage Shelf', 89.99, 3, 'Holds up to 200 CDs in an organized display.', 'cd-shelf.jpg', 25, 0, 'Brown'),
        ('Marantz 2270 Vintage Receiver', 899.99, 3, 'Classic 1970s stereo receiver with original wood case.', 'marantz-2270.jpg', 5, 1, 'Silver'),
        ('Anti-Static Inner Sleeves', 19.99, 3, 'Pack of 50 anti-static sleeves for vinyl protection.', 'inner-sleeves.jpg', 100, 0, 'White'),
        ('Record Weight Stabilizer', 49.99, 3, 'Brass weight to reduce vibration during playback.', 'record-weight.jpg', 35, 0, 'Gold'),
        ('McIntosh MC275 Tube Amplifier', 1999.99, 3, 'Legendary tube amplifier for audiophile listening.', 'mcintosh-mc275.jpg', 3, 1, 'Black'),
        ('Studio Monitor Speakers', 299.99, 3, 'Pair of active studio monitors for accurate sound.', 'monitor-speakers.jpg', 15, 1, 'Black'),
        ('Vinyl Record Outer Sleeves', 14.99, 3, 'Pack of 25 protective outer sleeves for album covers.', 'outer-sleeves.jpg', 80, 0, 'Clear'),
        ('Digital Audio Converter', 159.99, 3, 'Convert analog audio to digital with high fidelity.', 'dac-converter.jpg', 25, 0, 'Silver'),
        ('Record Clamp', 34.99, 3, 'Precision clamp for better vinyl playback stability.', 'record-clamp.jpg', 40, 0, 'Black'),
        ('Headphone Amplifier', 179.99, 3, 'Drive high-impedance headphones with clean power.', 'headphone-amp.jpg', 20, 0, 'Silver'),
        ('USB Audio Interface', 149.99, 3, 'Professional audio interface for recording and playback.', 'audio-interface.jpg', 18, 1, 'Red'),
        ('Cable Management Kit', 19.99, 3, 'Organize your audio cables with velcro ties and clips.', 'cable-kit.jpg', 60, 0, 'Black'),
        ('Acoustic Foam Panels', 69.99, 3, 'Set of 12 foam panels for room acoustic treatment.', 'foam-panels.jpg', 30, 0, 'Charcoal'),
        ('Music Stand', 39.99, 3, 'Adjustable music stand for sheet music and tablets.', 'music-stand.jpg', 25, 0, 'Black');

-- add shopping cart items
INSERT INTO shopping_cart (user_id, product_id, quantity)
VALUES  (3, 8, 1),
        (3, 10, 1);