# AirBNB Clone Platform SQL Schema

This repository contains the SQL schema design for a property rental platform. It structures core entities such as users, properties, bookings, payments, and reviews. This schema can serve as a foundation for building platforms similar to Airbnb, Vrbo, or Booking.com.

---

## Schema Overview

### 1. **Users**
Stores user account information.

- `user_id`: Primary Key
- `username`, `email`: Unique identifiers
- `password_hash`: Encrypted password
- Optional fields: `first_name`, `last_name`, `phone_number`, `profile_picture_url`
- `is_host`: Boolean flag to distinguish hosts from guests
- Timestamps: `created_at`, `updated_at`

---

### 2. **PropertyTypes**
Defines types of properties available (e.g., apartment, house, villa).

- `property_type_id`: Primary Key
- `type_name`: Unique name for the property type

---

### 3. **Addresses**
Stores address data for properties.

- `address_id`: Primary Key
- Includes fields for street, city, state, country, postal code
- Latitude and longitude for geolocation support

---

### 4. **Properties**
Core table for listing properties.

- `property_id`: Primary Key
- Foreign Keys:
  - `host_id` → `Users`
  - `property_type_id` → `PropertyTypes`
  - `address_id` → `Addresses`
- Details: `title`, `description`, room/bathroom count, `price_per_night`, guest capacity
- `is_active`: To manage visibility
- Timestamps: `created_at`, `updated_at`

**Indexes**:
- `host_id`, `price_per_night` for faster search/filtering

---

### 5. **Amenities**
List of all possible amenities (e.g., WiFi, Pool, Parking).

- `amenity_id`: Primary Key
- `name`: Unique amenity name

---

### 6. **PropertyAmenities**
Join table connecting properties and amenities.

- Composite Primary Key: (`property_id`, `amenity_id`)
- Foreign Keys to `Properties` and `Amenities`

---

### 7. **Bookings**
Handles reservation data.

- `booking_id`: Primary Key
- Foreign Keys:
  - `property_id` → `Properties`
  - `guest_id` → `Users`
- Dates: `check_in_date`, `check_out_date`
- `booking_status`: Enum ('pending', 'confirmed', 'cancelled', 'completed')
- Optional: `special_requests`
- Timestamps included

**Indexes**:
- `guest_id`, `property_id` for query optimization

---

### 8. **Payments**
Records payment transactions.

- `payment_id`: Primary Key
- Foreign Key: `booking_id` → `Bookings`
- Includes `amount`, `payment_method`, and `transaction_id`
- `payment_status`: Enum ('pending', 'completed', 'failed', 'refunded')
- Timestamps: `payment_date`, `created_at`, `updated_at`

---

### 9. **Reviews**
Feedback and ratings for completed stays.

- `review_id`: Primary Key
- Foreign Keys:
  - `property_id` → `Properties`
  - `guest_id` → `Users`
  - `booking_id` → `Bookings` (nullable)
- `rating`: Integer (1–5)
- Optional: `comment`
- Timestamps: `created_at`, `updated_at`

---

### 10. **Images**
Stores property-related images.

- `image_id`: Primary Key
- Foreign Key: `property_id` → `Properties`
- Fields: `url`, optional `caption`, `is_primary`, and display `order_position`
- Timestamp: `uploaded_at`

**Index**:
- (`property_id`, `is_primary`) to quickly fetch main images

---