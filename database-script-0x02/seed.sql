-- ========================
-- 🌟 Seed Data Script
-- ========================

-- 1. Users
INSERT INTO Users (username, email, password_hash, first_name, last_name, phone_number, profile_picture_url, is_host)
VALUES
('host_jane', 'jane@example.com', 'hashed_pw_123', 'Jane', 'Doe', '1234567890', 'https://example.com/jane.jpg', TRUE),
('guest_john', 'john@example.com', 'hashed_pw_456', 'John', 'Smith', '0987654321', 'https://example.com/john.jpg', FALSE),
('host_mike', 'mike@example.com', 'hashed_pw_789', 'Mike', 'Ross', NULL, NULL, TRUE),
('guest_emily', 'emily@example.com', 'hashed_pw_321', 'Emily', 'Blunt', NULL, NULL, FALSE);

-- 2. PropertyTypes
INSERT INTO PropertyTypes (type_name)
VALUES ('Apartment'), ('House'), ('Cottage');

-- 3. Addresses
INSERT INTO Addresses (address_line, city, state, country, postal_code, latitude, longitude)
VALUES
('123 Sunset Blvd', 'Los Angeles', 'CA', 'USA', '90001', 34.0522, -118.2437),
('456 Palm Street', 'Miami', 'FL', 'USA', '33101', 25.7617, -80.1918),
('789 Ocean Drive', 'Cape Town', NULL, 'South Africa', '8001', -33.9249, 18.4241);

-- 4. Properties
INSERT INTO Properties (host_id, property_type_id, address_id, title, description, room_count, bathroom_count, max_guests, price_per_night)
VALUES
(1, 1, 1, 'Modern Downtown Apartment', 'A cozy modern apartment in the heart of LA.', 2, 1, 4, 120.00),
(3, 2, 2, 'Beachfront Villa', 'Luxury villa with ocean views.', 4, 3, 8, 350.00),
(1, 3, 3, 'Rustic Cottage', 'Quiet retreat with mountain views.', 3, 2, 6, 200.00);

-- 5. Amenities 
INSERT INTO Amenities (name)
VALUES
('WiFi'),
('Air Conditioning'),
('Heating'),
('Kitchen'),
('Balcony'),
('Sea View'),
('Coffee Machine'),
('Early Check-In'),
('Late Check-Out'),
('Private Pool'),
('Free Parking'),
('Washer'),
('Dryer'),
('Pet Friendly'),
('TV'),
('BBQ Grill'),
('Fireplace'),
('Gym Access');

-- 6. PropertyAmenities
-- Property 1: Modern Downtown Apartment
INSERT INTO PropertyAmenities (property_id, amenity_id)
VALUES
(1, 1),  -- WiFi
(1, 2),  -- Air Conditioning
(1, 4),  -- Kitchen
(1, 8),  -- Early Check-In
(1, 15); -- TV

-- Property 2: Beachfront Villa
INSERT INTO PropertyAmenities (property_id, amenity_id)
VALUES
(2, 1),   -- WiFi
(2, 2),   -- Air Conditioning
(2, 5),   -- Balcony
(2, 6),   -- Sea View
(2, 10),  -- Private Pool
(2, 11),  -- Free Parking
(2, 7),   -- Coffee Machine
(2, 9);   -- Late Check-Out

-- Property 3: Rustic Cottage
INSERT INTO PropertyAmenities (property_id, amenity_id)
VALUES
(3, 1),   -- WiFi
(3, 3),   -- Heating
(3, 14),  -- Pet Friendly
(3, 12),  -- Washer
(3, 16),  -- BBQ Grill
(3, 17);  -- Fireplace

-- 7. Bookings
INSERT INTO Bookings (property_id, guest_id, check_in_date, check_out_date, total_price, booking_status, special_requests)
VALUES
(1, 2, '2025-06-01', '2025-06-05', 480.00, 'confirmed', 'Late check-in requested'),
(2, 4, '2025-06-10', '2025-06-15', 1750.00, 'completed', 'Need a baby crib'),
(3, 2, '2025-07-01', '2025-07-03', 400.00, 'pending', NULL);

-- 8. Payments
INSERT INTO Payments (booking_id, amount, payment_method, transaction_id, payment_status)
VALUES
(1, 480.00, 'Credit Card', 'TXN123456', 'completed'),
(2, 1750.00, 'PayPal', 'TXN789012', 'completed'),
(3, 400.00, 'Credit Card', 'TXN345678', 'pending');

-- 9. Reviews
INSERT INTO Reviews (property_id, guest_id, booking_id, rating, comment)
VALUES
(2, 4, 2, 5, 'Amazing stay with a perfect ocean view!'),
(1, 2, 1, 4, 'Great location, a bit noisy at night.');

-- 10. Images
INSERT INTO Images (property_id, url, caption, is_primary, order_position)
VALUES
(1, 'https://example.com/images/apt1_main.jpg', 'Main living area', TRUE, 1),
(1, 'https://example.com/images/apt1_bedroom.jpg', 'Bedroom view', FALSE, 2),
(2, 'https://example.com/images/villa_main.jpg', 'Front view of the villa', TRUE, 1),
(3, 'https://example.com/images/cottage_outside.jpg', 'Peaceful exterior shot', TRUE, 1);