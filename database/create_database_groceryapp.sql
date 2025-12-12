USE sys;

# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          GroceryApp                                      #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS groceryapp;

CREATE DATABASE IF NOT EXISTS groceryapp;

USE groceryapp;

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
VALUES  ('Fresh Produce', 'Fresh fruits, vegetables, and organic produce.'),
        ('Dairy & Eggs', 'Milk, cheese, yogurt, eggs, and dairy products.'),
        ('Pantry Staples', 'Canned goods, grains, spices, and cooking essentials.');

/* INSERT Products */
-- Fresh Produce
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('Organic Bananas', 3.99, 1, 'Fresh organic bananas, perfect for snacking or smoothies.', 'bananas.jpg', 100, 1, 'Organic'),
        ('Gala Apples', 4.99, 1, 'Crisp and sweet Gala apples, great for lunch boxes.', 'gala-apples.jpg', 80, 1, 'Fresh'),
        ('Fresh Spinach', 2.99, 1, 'Organic baby spinach leaves, perfect for salads.', 'spinach.jpg', 60, 0, 'Organic'),
        ('Plum Tomatoes', 3.49, 1, 'Fresh Plum tomatoes, ideal for cooking and sauces.', 'plum-tomatoes.jpg', 75, 1, 'Fresh'),
        ('Organic Carrots', 2.79, 1, 'Sweet and crunchy organic carrots, great for snacking.', 'carrots.jpg', 90, 0, 'Organic'),
        ('Fresh Broccoli', 3.99, 1, 'Green broccoli crowns, packed with vitamins and nutrients.', 'broccoli.jpg', 45, 1, 'Fresh'),
        ('Red Bell Peppers', 4.49, 1, 'Crisp red bell peppers, perfect for stir-fries and salads.', 'red-bell-peppers.jpg', 50, 0, 'Fresh'),
        ('Organic Strawberries', 5.99, 1, 'Sweet and juicy organic strawberries, seasonal favorite.', 'strawberries.jpg', 40, 1, 'Organic'),
        ('Fresh Avocados', 6.99, 1, 'Ripe Hass avocados, perfect for toast and guacamole.', 'avocados.jpg', 70, 0, 'Fresh'),
        ('Sweet Potatoes', 3.29, 1, 'Nutritious orange sweet potatoes, great for baking.', 'sweet-potatoes.jpg', 85, 0, 'Fresh'),
        ('Organic Blueberries', 7.99, 1, 'Antioxidant-rich organic blueberries, perfect for breakfast.', 'blueberries.jpg', 35, 1, 'Organic'),
        ('Fresh Cilantro', 1.99, 1, 'Aromatic fresh cilantro, essential for Mexican cuisine.', 'cilantro.jpg', 60, 0, 'Fresh'),
        ('Cucumber', 2.49, 1, 'Fresh cucumbers, great for salads and hydrating snacks.', 'cucumber.jpg', 65, 0, 'Fresh'),
        ('Red Onions', 2.99, 1, 'Sharp and flavorful red onions for cooking and salads.', 'red-onions.jpg', 80, 0, 'Fresh'),
        ('Organic Lemons', 4.99, 1, 'Juicy organic lemons, perfect for cooking and drinks.', 'lemons.jpg', 70, 0, 'Organic'),
        ('Fresh Garlic', 1.79, 1, 'Aromatic garlic bulbs, essential for flavor in cooking.', 'garlic.jpg', 95, 1, 'Fresh'),
        ('Baby Potatoes', 3.99, 1, 'Small creamy potatoes, perfect for roasting whole.', 'baby-potatoes.jpg', 75, 0, 'Fresh'),
        ('Organic Kale', 3.49, 1, 'Nutrient-dense organic kale leaves for healthy meals.', 'kale.jpg', 40, 0, 'Organic'),
        ('Fresh Limes', 3.99, 1, 'Tart and juicy limes, essential for cocktails and cooking.', 'limes.jpg', 60, 0, 'Fresh'),
        ('Nitro Cold Brew', 6.99, 1, 'Nitro brewed cold coffee', 'cold-brew.jpg', 55, 1, 'Local');

-- Dairy & Eggs
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES 
        ('Large Grade A Eggs', 3.99, 2, 'Fresh large eggs from free-range chickens.', 'large-eggs.jpg', 80, 0, 'Fresh'),
        ('Sharp Cheddar Cheese', 5.99, 2, 'Aged sharp cheddar cheese, perfect for sandwiches.', 'cheddar-cheese.jpg', 40, 0, 'Fresh'),
        ('Greek Yogurt Plain', 4.99, 2, 'Thick and creamy Greek yogurt, high in protein.', 'greek-yogurt.jpg', 60, 1, 'Low-Fat'),
        ('Unsalted Butter', 4.79, 2, 'Premium unsalted butter for baking and cooking.', 'butter.jpg', 70, 0, 'Fresh'),
        ('Mozzarella Cheese', 4.49, 2, 'Fresh mozzarella cheese, great for pizza and caprese.', 'mozzarella.jpg', 35, 1, 'Fresh'),
        ('Heavy Cream', 3.99, 2, 'Rich heavy cream for cooking and whipping.', 'heavy-cream.jpg', 45, 0, 'Fresh'),
        ('Cottage Cheese', 3.49, 2, 'Low-fat cottage cheese, high in protein.', 'cottage-cheese.jpg', 50, 0, 'Low-Fat'),
        ('Parmesan Cheese', 8.99, 2, 'Aged Parmesan cheese, freshly grated.', 'parmesan-cheese.jpg', 25, 1, 'Fresh'),
        ('Almond Milk', 3.99, 2, 'Unsweetened almond milk, dairy-free alternative.', 'almond-milk.jpg', 55, 1, 'Vegan'),
        
        ('Cream Cheese', 2.99, 2, 'Smooth cream cheese, perfect for bagels and baking.', 'cream-cheese.jpg', 65, 0, 'Fresh'),
        ('Gruyere', 6.49, 2, 'Nutty Swiss cheese with classic holes.', 'gruyere.jpg', 30, 0, 'Imported'),
        ('Crema', 2.79, 2, 'Tangy sour crema for topping and cooking.', 'sour-cream.jpg', 55, 0, 'Fresh'),
        ('Oat Milk', 4.49, 2, 'Creamy oat milk, sustainable plant-based option.', 'oat-milk.jpg', 45, 1, 'Vegan'),
        ('Goat Cheese', 7.99, 2, 'Creamy goat cheese with tangy flavor.', 'goat-cheese.jpg', 20, 0, 'Local'),
        ('Ice Cream', 8.99, 2, 'Whole milk ice cream for hungry stomachs.', 'ice-cream.jpg', 40, 0, 'Frozen'),
        ('Ricotta Cheese', 4.99, 2, 'Fresh ricotta cheese, perfect for lasagna and desserts.', 'ricotta-cheese.jpg', 35, 0, 'Fresh'),
        ('Coconut Milk', 3.49, 2, 'Canned coconut milk for cooking and baking.', 'coconut-milk.jpg', 60, 0, 'Canned'),
        ('Baklava', 5.99, 2, 'Flaky honey goodness', 'baklava.jpg', 35, 1, 'Local');

-- Pantry Staples
INSERT INTO products (name, price, category_id, description, image_url, stock, featured, subcategory) 
VALUES  ('Jasmine Rice 5lb', 6.99, 3, 'Fragrant jasmine rice, perfect for Asian dishes.', 'jasmine-rice.jpg', 40, 1, 'Whole Grain'),
        ('Extra Virgin Olive Oil', 12.99, 3, 'Premium cold-pressed extra virgin olive oil.', 'olive-oil.jpg', 30, 1, 'Organic'),
        ('Moutarde', 83.49, 3, 'Moutarde faite à la perfection', 'moutarde.jpg', 25, 0, 'Imported'),
        ('Ramen Noodles', 1.49, 3, 'Perfect wavy little bites', 'ramen-noodles.jpg', 100, 1, 'Packaged'),
        ('Black Beans Can', 1.99, 3, 'Organic black beans, ready to eat or cook.', 'black-beans.jpg', 100, 0, 'Canned'),
        ('Penne Pasta', 2.49, 3, 'Italian penne pasta made from durum wheat.', 'penne-pasta.jpg', 80, 1, 'Packaged'),
        ('Honey 32oz', 8.99, 3, 'Raw unfiltered honey from local beekeepers.', 'honey.jpg', 35, 0, 'Local'),
        ('Sea Salt', 3.99, 3, 'Coarse sea salt for cooking and finishing dishes.', 'sea-salt.jpg', 60, 0, 'Packaged'),
        ('Canned Tomatoes', 2.79, 3, 'Whole peeled tomatoes in juice, perfect for sauces.', 'canned-tomatoes.jpg', 90, 1, 'Canned'),
        ('Quinoa 2lb', 9.99, 3, 'Organic quinoa, complete protein superfood grain.', 'quinoa.jpg', 45, 1, 'Organic'),
        ('Peanut Butter', 5.49, 3, 'Natural peanut butter with no added sugar.', 'peanut-butter.jpg', 50, 0, 'Natural'),
        ('Ground Coffee', 11.99, 3, 'Medium roast ground coffee beans from Colombia.', 'ground-coffee.jpg', 40, 1, 'Imported'),
        ('Vanilla Extract', 6.99, 3, 'Pure vanilla extract for baking and desserts.', 'vanilla-extract.jpg', 30, 0, 'Natural'),
        ('Coconut Oil', 9.99, 3, 'Organic virgin coconut oil for cooking and baking.', 'coconut-oil.jpg', 35, 0, 'Organic'),
        ('Baking Soda', 1.49, 3, 'Pure baking soda for baking and cleaning.', 'baking-soda.jpg', 75, 0, 'Packaged'),
        ('Apple Cider Vinegar', 4.99, 3, 'Organic apple cider vinegar with the mother.', 'apple-cider-vinegar.jpg', 45, 0, 'Organic'),
        ('Rolled Oats', 4.49, 3, 'Old-fashioned rolled oats for oatmeal and baking.', 'rolled-oats.jpg', 55, 1, 'Whole Grain'),
        ('Chicken Broth', 3.49, 3, 'Low-sodium organic chicken broth for soups.', 'chicken-broth.jpg', 65, 0, 'Canned'),
        ('Brown Sugar', 3.99, 3, 'Light brown sugar for baking and sweetening.', 'brown-sugar.jpg', 50, 0, 'Packaged'),
        ('Garlic Powder', 2.99, 3, 'Ground garlic powder for seasoning dishes.', 'garlic-powder.jpg', 70, 0, 'Packaged'),
        ('Maple Syrup', 12.99, 3, 'Pure Grade A maple syrup from Vermont.', 'maple-syrup.jpg', 25, 1, 'Natural');

-- add shopping cart items
INSERT INTO shopping_cart (user_id, product_id, quantity)
VALUES  (3, 8, 1),
        (3, 10, 1);