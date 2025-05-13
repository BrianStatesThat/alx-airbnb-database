-- =======================
-- 1. Users Table
-- =======================
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(20),
    profile_picture_url TEXT,
    is_host BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =======================
-- 2. PropertyTypes Table
-- =======================
CREATE TABLE PropertyTypes (
    property_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE NOT NULL
);

-- =======================
-- 3. Addresses Table
-- =======================
CREATE TABLE Addresses (
    address_id SERIAL PRIMARY KEY,
    address_line TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);

-- =======================
-- 4. Properties Table
-- =======================
CREATE TABLE Properties (
    property_id SERIAL PRIMARY KEY,
    host_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    property_type_id INTEGER REFERENCES PropertyTypes(property_type_id),
    address_id INTEGER REFERENCES Addresses(address_id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    room_count INTEGER CHECK (room_count >= 0),
    bathroom_count INTEGER CHECK (bathroom_count >= 0),
    max_guests INTEGER CHECK (max_guests > 0),
    price_per_night NUMERIC(10, 2) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for Properties
CREATE INDEX idx_properties_host ON Properties(host_id);
CREATE INDEX idx_properties_price ON Properties(price_per_night);

-- =======================
-- 5. Amenities Table
-- =======================
CREATE TABLE Amenities (
    amenity_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- =======================
-- 6. PropertyAmenities Join Table
-- =======================
CREATE TABLE PropertyAmenities (
    property_id INTEGER REFERENCES Properties(property_id) ON DELETE CASCADE,
    amenity_id INTEGER REFERENCES Amenities(amenity_id) ON DELETE CASCADE,
    PRIMARY KEY (property_id, amenity_id)
);

-- =======================
-- 7. Bookings Table
-- =======================
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    property_id INTEGER REFERENCES Properties(property_id) ON DELETE CASCADE,
    guest_id INTEGER REFERENCES Users(user_id) ON DELETE CASCADE,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    booking_status VARCHAR(20) CHECK (booking_status IN ('pending', 'confirmed', 'cancelled', 'completed')),
    special_requests TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for Bookings
CREATE INDEX idx_bookings_guest ON Bookings(guest_id);
CREATE INDEX idx_bookings_property ON Bookings(property_id);

-- =======================
-- 8. Payments Table
-- =======================
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    booking_id INTEGER REFERENCES Bookings(booking_id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    transaction_id VARCHAR(100) UNIQUE,
    payment_status VARCHAR(20) CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =======================
-- 9. Reviews Table
-- =======================
CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    property_id INTEGER REFERENCES Properties(property_id) ON DELETE CASCADE,
    guest_id INTEGER REFERENCES Users(user_id) ON DELETE CASCADE,
    booking_id INTEGER REFERENCES Bookings(booking_id) ON DELETE SET NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =======================
-- 10. Images Table
-- =======================
CREATE TABLE Images (
    image_id SERIAL PRIMARY KEY,
    property_id INTEGER REFERENCES Properties(property_id) ON DELETE CASCADE,
    url TEXT NOT NULL,
    caption VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    order_position INTEGER,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for primary images
CREATE INDEX idx_images_primary ON Images(property_id, is_primary);
