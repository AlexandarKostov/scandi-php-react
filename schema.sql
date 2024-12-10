CREATE DATABASE scandiweb-task;

-- CREATING TABLES --
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    inStock BOOLEAN DEFAULT TRUE,
    gallery JSON,
    description TEXT,
    category VARCHAR(255),
    brand VARCHAR(255),
    FOREIGN KEY (category) REFERENCES categories(name) ON DELETE SET NULL
);

CREATE TABLE attributes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,

    CONSTRAINT unique_attribute UNIQUE (name, type)
);


CREATE TABLE product_attributes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attribute_id INT,
    displayValue VARCHAR(255) NOT NULL,
    value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE SET NULL,
    CONSTRAINT unique_product_attribute_value UNIQUE (product_id, attribute_id, value)
);

CREATE TABLE currencies (
    label VARCHAR(50) PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL
);

CREATE TABLE prices (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10, 2),
    currency VARCHAR(50) NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (currency) REFERENCES currencies(label) ON DELETE CASCADE,
    CONSTRAINT unique_product_price_currency UNIQUE (product_id, currency)
);


CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    total_amount DECIMAL(10, 2) NOT NULL,
    total_currency VARCHAR(50) NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
                             id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                             order_id BIGINT UNSIGNED NOT NULL,
                             product_id INT,
                             product_name VARCHAR(255) NOT NULL,
                             attribute_values JSON NOT NULL,
                             quantity INT UNSIGNED DEFAULT 1,
                             paid_amount DECIMAL(10, 2) NOT NULL,
                             paid_currency VARCHAR(50) NOT NULL,
                             created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
                             FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);


-- INSERTING DATA --
INSERT INTO categories (name) VALUES
('All'),
('Apple'),
('Samsung');


INSERT INTO products (name, inStock, gallery, description, category, brand) VALUES
  ('Iphone 12', true, '["https://istyle.mk/media/catalog/product/i/p/iphone_12_white_pdp_image_position-2__en-us_6.jpg","https://istyle.mk/media/catalog/product/i/p/iphone_12_pdp_image_position-2__en-us_6.jpg"]', 'Iphone 12 60GB', 'Apple', 'Iphone'),
  ('Iphone 15 Pro Max', true, '["https://istyle.mk/media/catalog/product/i/p/iphone_15_pro_max_black_titanium_pdp_image_position-1__en-us_2.jpg","https://www.compudemano.com/wp-content/uploads/2023/09/iphone-15-pro-max_0010_Capa-23.jpg.webp"]', 'Iphone 15 Pro Max 256GB 120hZ', 'Apple', 'Iphone'),
  ('Iphone 16 Plus', true, '["https://istyle.mk/media/catalog/product/cache/image/e9c3970ab036de70892d86c6d221abfe/i/p/iphone_16_plus_black_pdp_image_position_1__cs-cz.jpg","https://istyle.mk/media/catalog/product/cache/image/e9c3970ab036de70892d86c6d221abfe/i/p/iphone_16_plus_teal_pdp_image_position_1__cs-cz.jpg"]', 'Iphone 16 Plus 128GB', 'Apple', 'Iphone'),
  ('MacBook Pro', true, '["https://istyle.hu/media/wysiwyg/HU/landing-pages/preselection/m3_16_fekete.jpg","https://istyle.hu/media/wysiwyg/HU/landing-pages/preselection/m3_16_ezust.jpg"]', 'Apple M4 Pro чип 14 јадрен CPU 20 јадрен GPU5 12GB SSD', 'Apple', 'Mac'),
  ('MacBook Air', true, '["https://istyle.hu/media/wysiwyg/HU/landing-pages/preselection/m2-mba-silver.jpg","https://istyle.hu/media/wysiwyg/HU/landing-pages/preselection/m2-mba-midnight.jpg"]', 'MacBook Air M3 8GB 256 GB', 'Apple', 'Mac'),
  ('Samsung Galaxy S24 FE', true, '["https://admin.ledikom.mk/uploads/items/4459/1729580883samsung-galaxy-s24-fe-2.webp.jpg?v=1","https://admin.ledikom.mk/uploads/items/4459/1729673981-6236.webp.jpg?v=1"]', 'Samsung Galaxy S24 FE 256GB 8GB', 'Samsung', 'Galaxy'),
  ('Galaxy Z Fold6', true, '["https://admin.ledikom.mk/uploads/items/4428/1730969785-6278.webp.jpg?v=1","https://admin.ledikom.mk/uploads/items/4428/1730969785-6280.webp.jpg?v=1","https://admin.ledikom.mk/uploads/items/4428/1730969785-6282.webp.jpg?v=1"]', 'Galaxy Z Fold6 512GB 12GB', 'Samsung', 'Galaxy'),
  ('Samsung Galaxy S24 Ultra', true, '["https://admin.ledikom.mk/uploads/items/4163/1730972960-6038.webp.jpg?v=1","https://admin.ledikom.mk/uploads/items/4163/1730972959-5271.webp.jpg?v=1","https://admin.ledikom.mk/uploads/items/4163/1730972959-4799.webp.jpg?v=1"]', 'Samsung Galaxy S24 Ultra 1TB 12GB', 'Samsung', 'Galaxy');





INSERT INTO attributes (name, type) VALUES
('color', 'text');

INSERT INTO product_attributes (product_id, attribute_id, displayValue, value) VALUES
('1', '1', 'white', '#FFFFFF'),     --in the product_id field we are putting the id from the product table when we insert the products and
('1', '1', 'dark', '#000000'),      --in the attribute_id we insert the id from the insert above just to be clear or if you dont want like that
('2', '1', 'white', '#FFFFFF'),     --you can modify the product create table
('2', '1', 'dark', '#000000'),
('3', '1', 'white', '#FFFFFF'),
('3', '1', 'dark', '#000000'),
('4', '1', 'white', '#FFFFFF'),
('4', '1', 'dark', '#000000'),
('5', '1', 'silver', '#C0C0C0'),
('5', '1', 'dark', '#000000'),
('6', '1', 'white', '#FFFFFF'),
('6', '1', 'dark', '#000000'),
('7', '1', 'white', '#FFFFFF'),
('7', '1', 'dark', '#000000'),
('7', '1', 'silver', '#C0C0C0'),
('8', '1', 'white', '#FFFFFF'),
('8', '1', 'dark', '#000000'),
('8', '1', 'silver', '#C0C0C0');

INSERT INTO currencies (label, symbol) VALUES
('USD', '$'),
('EUR', '€');

INSERT INTO prices (product_id,amount, currency) VALUES
                                          (1, 144.69, 'EUR'),
                                          (2, 518.47, 'USD'),
                                          (3, 844.02, 'USD'),
                                          (4, 333.99, 'EUR'),
                                          (5, 1600, 'USD'),
                                          (6, 1000.76, 'USD'),
                                          (7, 300, 'USD'),
                                          (8, 120.57, 'USD');


INSERT INTO orders (total_amount, total_currency) VALUES (2000.00, 'USD');

-- TESTING
SELECT * FROM products;
