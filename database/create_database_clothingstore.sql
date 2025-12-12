USE sys;

# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          ClothingStore                                #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS clothingstore;

CREATE DATABASE IF NOT EXISTS clothingstore;

USE clothingstore;

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
VALUES  ('Tops', 'T-shirts, hoodies, sweaters, jackets, and other upper body clothing.'),
        ('Bottoms', 'Jeans, pants, shorts, skirts, and other lower body clothing.'),
        ('Shoes', 'Sneakers, boots, dress shoes, sandals, and all footwear.');

/* INSERT Products */
-- Tops (Category 1)
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('ButterGoods Classic Logo Hoodie', 89.99, 1, 'Australian streetwear brand with quality construction.', 'buttergoods-hoodie.jpg', 25, 1, 'Black'),
        ('Champion Powerblend Hoodie', 54.99, 1, 'Classic athletic hoodie with C logo.', 'champion-hoodie.jpg', 40, 1, 'Gray'),
        ('Plain White T-Shirt', 19.99, 1, 'Basic cotton crew neck t-shirt.', 'white-tshirt.jpg', 100, 1, 'White'),
        ('Plain Black T-Shirt', 19.99, 1, 'Essential black cotton t-shirt.', 'black-tshirt.jpg', 95, 1, 'Black'),
        ('Gray Hoodie', 49.99, 1, 'Comfortable pullover hoodie in heather gray.', 'gray-hoodie.jpg', 40, 0, 'Gray'),
        ('Navy Crewneck Sweater', 59.99, 1, 'Classic knit sweater in navy blue.', 'navy-sweater.jpg', 35, 0, 'Navy'),
        ('Flannel Shirt', 44.99, 1, 'Red and black checkered flannel shirt.', 'flannel-shirt.jpg', 30, 0, 'Red'),
        ('Denim Jacket', 79.99, 1, 'Classic blue denim trucker jacket.', 'denim-jacket.jpg', 25, 1, 'Blue'),
        ('Plain Polo Shirt', 34.99, 1, 'Cotton pique polo shirt.', 'polo-shirt.jpg', 60, 0, 'Navy'),
        ('V-Neck T-Shirt', 24.99, 1, 'Classic v-neck cotton t-shirt.', 'vneck-tshirt.jpg', 70, 0, 'White'),
        ('Button-Down Shirt', 49.99, 1, 'Collared dress shirt in white.', 'button-shirt.jpg', 40, 0, 'White'),
        ('Tank Top', 19.99, 1, 'Basic sleeveless cotton tank.', 'tank-top.jpg', 85, 0, 'White'),
        ('Long Sleeve Shirt', 32.99, 1, 'Basic long sleeve cotton shirt.', 'long-sleeve-shirt.jpg', 55, 0, 'Gray'),
        ('Cardigan Sweater', 64.99, 1, 'Open-front knit cardigan.', 'cardigan.jpg', 30, 0, 'Beige'),
        ('Blouse', 39.99, 1, 'Elegant button-up blouse.', 'blouse.jpg', 40, 0, 'White'),
        
        
        ('Floral Dress', 64.99, 1, 'Pretty dress with floral print.', 'floral-dress.jpg', 20, 0, 'Pink'),
        ('Wrap Dress', 69.99, 1, 'Flattering wrap-style dress.', 'wrap-dress.jpg', 25, 1, 'Navy'),
        ('Jean Jacket', 74.99, 1, 'Classic denim jacket for women.', 'womens-jean-jacket.jpg', 30, 0, 'Blue');

-- Bottoms (Category 2)
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('Blue Jeans', 69.99, 2, 'Classic straight-fit denim jeans.', 'blue-jeans.jpg', 50, 1, 'Blue'),
        ('Black Jeans', 69.99, 2, 'Modern black denim jeans.', 'black-jeans.jpg', 45, 1, 'Black'),
        ('High-Waisted Jeans', 74.99, 2, 'Modern high-rise skinny jeans.', 'high-waist-jeans.jpg', 45, 1, 'Blue'),
        ('Khaki Chinos', 54.99, 2, 'Casual dress pants in khaki color.', 'khaki-chinos.jpg', 40, 0, 'Khaki'),
        ('Track Pants', 49.99, 2, 'Comfortable athletic sweatpants.', 'track-pants.jpg', 35, 0, 'Black'),
        
        ('Denim Shorts', 34.99, 2, 'Classic mid-rise denim shorts.', 'denim-shorts.jpg', 50, 0, 'Blue'),
        
        

        ('Dress Pants', 54.99, 2, 'Formal trousers for business occasions.', 'dress-pants.jpg', 30, 0, 'Charcoal'),
        ('Sweatpants', 44.99, 2, 'Comfortable cotton blend sweatpants.', 'sweatpants.jpg', 40, 0, 'Gray'),
        
        ('Cargo Pants', 59.99, 2, 'Utility pants with multiple pockets.', 'cargo-pants.jpg', 25, 0, 'Olive'),
        ('Athletic Shorts', 29.99, 2, 'Performance shorts for working out.', 'athletic-shorts.jpg', 50, 0, 'Black'),
        ('Pleated Skirt', 44.99, 2, 'Classic pleated school-style skirt.', 'pleated-skirt.jpg', 30, 0, 'Navy'),
        ('Skinny Jeans', 64.99, 2, 'Tight-fitting stretch denim jeans.', 'skinny-jeans.jpg', 40, 0, 'Black'),
        ('Board Shorts', 34.99, 2, 'Quick-dry shorts for swimming.', 'board-shorts.jpg', 35, 0, 'Blue'),
        ('Palazzo Pants', 49.99, 2, 'Wide-leg flowing pants.', 'palazzo-pants.jpg', 25, 0, 'Black'),
        ('Bermuda Shorts', 39.99, 2, 'Knee-length casual shorts.', 'bermuda-shorts.jpg', 45, 0, 'Tan');

-- Shoes (Category 3)
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('Adidas Campus Sneakers', 89.99, 3, 'Retro suede sneakers with three stripes branding.', 'adidas-campus.jpg', 35, 1, 'Green'),
        ('Reebok Classic Leather', 79.99, 3, 'Iconic white leather sneakers with classic styling.', 'reebok-classic.jpg', 40, 1, 'White'),
        ('White Canvas Sneakers', 49.99, 3, 'Basic canvas lace-up sneakers.', 'white-canvas-shoes.jpg', 60, 1, 'White'),
        ('Black Canvas Sneakers', 49.99, 3, 'Classic black canvas sneakers.', 'black-canvas-shoes.jpg', 55, 1, 'Black'),
        ('Running Shoes', 79.99, 3, 'Comfortable athletic running shoes.', 'running-shoes.jpg', 40, 0, 'Gray'),
        ('Slip-On Shoes', 54.99, 3, 'Easy slip-on canvas shoes.', 'slip-on-shoes.jpg', 50, 0, 'Navy'),
        ('High-Top Sneakers', 64.99, 3, 'Classic high-top canvas sneakers.', 'high-top-sneakers.jpg', 35, 0, 'Red'),
        ('Leather Boots', 129.99, 3, 'Durable leather ankle boots.', 'leather-boots.jpg', 20, 1, 'Brown'),
        ('Sandals', 34.99, 3, 'Comfortable summer sandals.', 'sandals.jpg', 45, 0, 'Brown'),
        ('Flip Flops', 19.99, 3, 'Basic rubber flip flop sandals.', 'flip-flops.jpg', 80, 0, 'Black'),
        ('Dress Shoes', 199.99, 3, 'Formal leather dress shoes.', 'dress-shoes.jpg', 25, 0, 'Black'),
        ('Rain Boots', 44.99, 3, 'Waterproof rubber boots.', 'rain-boots.jpg', 30, 0, 'Yellow'),
        ('Hiking Boots', 119.99, 3, 'Sturdy outdoor hiking boots.', 'hiking-boots.jpg', 15, 0, 'Brown'),
        ('Ballet Flats', 39.99, 3, 'Simple women\'s flat shoes.', 'ballet-flats.jpg', 40, 0, 'Black'),
        ('Heels', 69.99, 3, 'Classic women\'s dress heels.', 'heels.jpg', 25, 0, 'Black'),
        ('Winter Boots', 99.99, 3, 'Insulated boots for cold weather.', 'winter-boots.jpg', 20, 0, 'Black'),
        ('Basketball Shoes', 99.99, 3, 'High-performance shoes for basketball.', 'basketball-shoes.jpg', 30, 0, 'Black'),
        ('Skateboard Shoes', 64.99, 3, 'Durable shoes designed for skateboarding.', 'skate-shoes.jpg', 35, 0, 'Black'),
        ('Loafers', 74.99, 3, 'Comfortable slip-on dress shoes.', 'loafers.jpg', 25, 0, 'Brown'),
        ('Combat Boots', 109.99, 3, 'Military-style lace-up boots.', 'combat-boots.jpg', 20, 0, 'Black');

-- add shopping cart items
INSERT INTO shopping_cart (user_id, product_id, quantity)
VALUES  (3, 8, 1),
        (3, 10, 1);