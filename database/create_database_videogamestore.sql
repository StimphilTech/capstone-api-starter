USE sys;

# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          VideoGameStore                                  #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS videogamestore;

CREATE DATABASE IF NOT EXISTS videogamestore;

USE videogamestore;

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
VALUES  ('Console Games', 'Latest games for PlayStation, Xbox, and Nintendo platforms.'),
        ('PC Games', 'Digital and physical PC gaming titles for all genres.'),
        ('Gaming Accessories', 'Controllers, headsets, and gear to enhance your gaming experience.');

/* INSERT Products */
-- Console Games
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('The Legend of Zelda: Breath of the Wild', 59.99, 1, 'Open-world adventure game for Nintendo Switch.', 'zelda-botw.jpg', 50, 1, 'Adventure'),
        ('God of War', 49.99, 1, 'Epic Norse mythology action-adventure for PlayStation.', 'god-of-war.jpg', 40, 1, 'Action'),
        ('Halo Infinite', 59.99, 1, 'Master Chief returns in this sci-fi shooter for Xbox.', 'halo-infinite.jpg', 35, 0, 'Shooter'),
        ('Super Mario Odyssey', 54.99, 1, 'Mario''s globe-trotting adventure on Nintendo Switch.', 'mario-odyssey.jpg', 45, 1, 'Adventure'),
        ('Spider-Man: Miles Morales', 49.99, 1, 'Swing through New York as the new Spider-Man.', 'spiderman-miles.jpg', 30, 0, 'Action'),
        ('Forza Horizon 5', 59.99, 1, 'Open-world racing across beautiful Mexico landscapes.', 'forza-horizon-5.jpg', 25, 1, 'Racing'),
        ('Animal Crossing: New Horizons', 54.99, 1, 'Build your perfect island paradise with friends.', 'animal-crossing.jpg', 60, 0, 'Simulation'),
        ('The Last of Us Part II', 39.99, 1, 'Post-apocalyptic survival adventure continues.', 'last-of-us-2.jpg', 20, 0, 'Action'),
        ('Mario Kart World', 89.99, 1, 'The ultimate kart racing experience on Switch.', 'mario-kart-8.jpg', 70, 1, 'Racing'),
        ('Gears 5', 29.99, 1, 'Third-person shooter with intense combat action.', 'gears-5.jpg', 25, 0, 'Shooter'),
        ('Metroid Dread', 59.99, 1, 'Return of Samus in this atmospheric action game.', 'metroid-dread.jpg', 30, 0, 'Action'),
        ('Horizon Forbidden West', 69.99, 1, 'Explore a beautiful post-apocalyptic world.', 'horizon-forbidden.jpg', 35, 1, 'RPG'),
        ('Elden Ring', 59.99, 1, 'FromSoftware''s open-world dark fantasy epic.', 'elden-ring.jpg', 40, 1, 'RPG'),
        ('FIFA 24', 69.99, 1, 'The latest soccer simulation with updated teams.', 'fifa-24.jpg', 50, 0, 'Sports'),
        ('Call of Duty: Modern Warfare III', 69.99, 1, 'Military first-person shooter with multiplayer.', 'cod-mw3.jpg', 45, 0, 'Shooter'),
        ('Assassin''s Creed Mirage', 49.99, 1, 'Return to the roots of the stealth action series.', 'ac-mirage.jpg', 30, 0, 'Action'),
        ('Hogwarts Legacy', 59.99, 1, 'Experience magic in the wizarding world RPG.', 'hogwarts-legacy.jpg', 40, 1, 'RPG'),
        ('Resident Evil 4', 59.99, 1, 'Remake of the survival horror classic.', 're4-remake.jpg', 35, 0, 'Action'),
        ('Street Fighter 6', 59.99, 1, 'The legendary fighting series returns stronger.', 'street-fighter-6.jpg', 25, 0, 'Fighting'),
        ('Starfield', 69.99, 1, 'Bethesda''s epic space exploration RPG.', 'starfield.jpg', 30, 1, 'RPG');

-- PC Games
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('Cyberpunk 2077', 29.99, 2, 'Futuristic open-world RPG in Night City.', 'cyberpunk-2077.jpg', 100, 0, 'RPG'),
        ('The Witcher 3: Wild Hunt', 19.99, 2, 'Epic fantasy RPG with hundreds of hours of content.', 'witcher-3.jpg', 150, 1, 'RPG'),
        ('Counter-Strike 2', 0.00, 2, 'Free-to-play competitive tactical shooter.', 'counter-strike-2.jpg', 999, 1, 'Shooter'),
        ('Baldur''s Gate 3', 59.99, 2, 'Turn-based RPG based on Dungeons & Dragons.', 'baldurs-gate-3.jpg', 75, 1, 'RPG'),
        ('Minecraft Java Edition', 26.95, 2, 'Build and explore infinite procedural worlds.', 'minecraft.jpg', 200, 1, 'Simulation'),
        ('Grand Theft Auto V', 19.99, 2, 'Open-world crime saga in Los Santos.', 'gta-5.jpg', 120, 0, 'Action'),
        ('Red Dead Redemption 2', 39.99, 2, 'Western epic from Rockstar Games.', 'rdr2.jpg', 80, 0, 'Action'),
        ('Apex Legends', 0.00, 2, 'Free battle royale with unique legend abilities.', 'apex-legends.jpg', 999, 0, 'Shooter'),
        ('Fortnite', 0.00, 2, 'Popular battle royale with building mechanics.', 'fortnite.jpg', 999, 0, 'Shooter'),
        ('League of Legends', 0.00, 2, 'World''s most popular MOBA game.', 'league-legends.jpg', 999, 1, 'Strategy'),
        ('World of Warcraft', 14.99, 2, 'Legendary MMORPG with subscription model.', 'world-of-warcraft.jpg', 500, 0, 'RPG'),
        ('Overwatch 2', 0.00, 2, 'Team-based hero shooter from Blizzard.', 'overwatch-2.jpg', 999, 0, 'Shooter'),
        ('Diablo IV', 69.99, 2, 'Action RPG with dark gothic atmosphere.', 'diablo-4.jpg', 60, 1, 'Action'),
        ('Age of Empires IV', 39.99, 2, 'Real-time strategy through historical ages.', 'age-empires-4.jpg', 40, 0, 'Strategy'),
        ('Total War: Warhammer III', 59.99, 2, 'Fantasy strategy with massive battles.', 'total-war-wh3.jpg', 35, 0, 'Strategy'),
        ('Cities: Skylines', 29.99, 2, 'City-building simulation game.', 'cities-skylines.jpg', 80, 0, 'Simulation'),
        ('Stardew Valley', 14.99, 2, 'Relaxing farming simulation RPG.', 'stardew-valley.jpg', 150, 1, 'Simulation'),
        ('Among Us', 4.99, 2, 'Social deduction game with crewmates and impostors.', 'among-us.jpg', 200, 0, 'Puzzle'),
        ('Fall Guys', 0.00, 2, 'Colorful battle royale party game.', 'fall-guys.jpg', 999, 0, 'Action');

-- Gaming Accessories
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('Xbox Wireless Controller', 59.99, 3, 'Official wireless controller for Xbox Series X|S.', 'xbox-controller.jpg', 50, 1, 'Controller'),
        ('PlayStation 5 DualSense Controller', 69.99, 3, 'Advanced controller with haptic feedback.', 'ps5-controller.jpg', 40, 1, 'Controller'),
        ('Nintendo Pro Controller', 69.99, 3, 'Professional controller for Nintendo Switch.', 'switch-pro-controller.jpg', 30, 0, 'Controller'),
        ('SteelSeries Arctis 7P Headset', 149.99, 3, 'Wireless gaming headset with surround sound.', 'steelseries-headset.jpg', 35, 1, 'Audio'),
        ('Razer DeathAdder V3 Gaming Mouse', 79.99, 3, 'Ergonomic gaming mouse with precision sensor.', 'razer-mouse.jpg', 60, 0, 'Peripheral'),
        ('Corsair K95 RGB Mechanical Keyboard', 199.99, 3, 'Premium mechanical keyboard with RGB lighting.', 'corsair-keyboard.jpg', 25, 1, 'Peripheral'),
        ('ASUS ROG Gaming Monitor 27"', 299.99, 3, '144Hz gaming monitor with G-Sync support.', 'asus-monitor.jpg', 20, 1, 'Display'),
        ('Elgato Stream Deck', 149.99, 3, 'Customizable control panel for content creators.', 'elgato-streamdeck.jpg', 30, 0, 'Streaming'),
        ('Blue Yeti USB Microphone', 99.99, 3, 'Professional USB microphone for streaming.', 'blue-yeti-mic.jpg', 40, 0, 'Audio'),
        ('Logitech C920 HD Webcam', 79.99, 3, 'Full HD webcam for streaming and video calls.', 'logitech-webcam.jpg', 50, 0, 'Streaming'),
        ('Gaming Chair RGB', 299.99, 3, 'Ergonomic gaming chair with RGB lighting.', 'gaming-chair.jpg', 15, 1, 'Furniture'),
        ('HyperX Cloud II Headset', 89.99, 3, 'Professional gaming headset with 7.1 surround.', 'hyperx-headset.jpg', 45, 0, 'Audio'),
        ('PlayStation 5 Charging Station', 29.99, 3, 'Dual charging dock for PS5 controllers.', 'ps5-charging-station.jpg', 60, 0, 'Accessory'),
        ('Xbox Series X Cooling Stand', 39.99, 3, 'Vertical stand with cooling fans for Xbox.', 'xbox-cooling-stand.jpg', 35, 0, 'Accessory'),
        ('Nintendo Switch Carrying Case', 24.99, 3, 'Protective carrying case for Switch console.', 'switch-case.jpg', 80, 0, 'Accessory'),
        ('Gaming Mousepad XL', 19.99, 3, 'Extra large mousepad for gaming setups.', 'xl-mousepad.jpg', 100, 0, 'Peripheral'),
        ('Cable Management Kit', 14.99, 3, 'Organize your gaming setup cables.', 'cable-management.jpg', 75, 0, 'Accessory'),
        ('LED Strip Lights RGB', 29.99, 3, 'Programmable RGB lighting for gaming rooms.', 'led-strips.jpg', 90, 1, 'Lighting'),
        ('Gaming Desk 55"', 199.99, 3, 'Spacious gaming desk with cable management.', 'gaming-desk.jpg', 12, 0, 'Furniture'),
        ('VR Headset Stand', 24.99, 3, 'Display stand for VR headsets and controllers.', 'vr-stand.jpg', 40, 0, 'Accessory');

-- add shopping cart items
INSERT INTO shopping_cart (user_id, product_id, quantity)
VALUES  (3, 8, 1),
        (3, 10, 1);