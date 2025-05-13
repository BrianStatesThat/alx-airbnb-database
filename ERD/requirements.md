# Airbnb Clone - Database Requirements

This document outlines the core database structure and relationships for the Airbnb Clone project. It includes the essential **entities**, their **attributes**, and the **relationships** between them.

---

## Entities and Attributes

### 1. User

- `user_id` (Primary Key)  
- `username`  
- `email`  
- `password_hash`  
- `first_name`  
- `last_name`  
- `phone_number`  
- `profile_picture_url`  
- `created_at`  
- `updated_at`  
- `is_host` (boolean)

---

### 2. Property

- `property_id` (Primary Key)  
- `host_id` (Foreign Key → User.user_id)  
- `title`  
- `description`  
- `property_type` (house, apartment, etc.)  
- `room_count`  
- `bathroom_count`  
- `max_guests`  
- `price_per_night`  
- `address`  
- `city`  
- `state`  
- `country`  
- `postal_code`  
- `latitude`  
- `longitude`  
- `amenities` (could be a separate table)  
- `created_at`  
- `updated_at`  
- `is_active` (boolean)

---

### 3. Booking

- `booking_id` (Primary Key)  
- `property_id` (Foreign Key → Property.property_id)  
- `guest_id` (Foreign Key → User.user_id)  
- `check_in_date`  
- `check_out_date`  
- `total_price`  
- `booking_status` (pending, confirmed, cancelled, completed)  
- `created_at`  
- `updated_at`  
- `special_requests`

---

### 4. Payment

- `payment_id` (Primary Key)  
- `booking_id` (Foreign Key → Booking.booking_id)  
- `amount`  
- `payment_method`  
- `transaction_id`  
- `payment_status` (pending, completed, failed, refunded)  
- `payment_date`  
- `created_at`  
- `updated_at`

---

### 5. Review

- `review_id` (Primary Key)  
- `property_id` (Foreign Key → Property.property_id)  
- `guest_id` (Foreign Key → User.user_id)  
- `booking_id` (Foreign Key → Booking.booking_id)  
- `rating` (1-5)  
- `comment`  
- `created_at`  
- `updated_at`

---

### 6. Image

- `image_id` (Primary Key)  
- `property_id` (Foreign Key → Property.property_id)  
- `url`  
- `caption`  
- `is_primary` (boolean)  
- `uploaded_at`  
- `order_position`

---

## Relationships

- **User → Property**: One-to-Many  
  - A user (host) can list multiple properties  
  - A property belongs to exactly one user

- **User → Booking**: One-to-Many  
  - A user (guest) can have multiple bookings  
  - A booking belongs to exactly one user

- **Property → Booking**: One-to-Many  
  - A property can have multiple bookings  
  - A booking is for exactly one property

- **Booking → Payment**: One-to-One or One-to-Many  
  - A booking can have one or multiple payments

- **Property → Review**: One-to-Many  
  - A property can have multiple reviews  
  - A review is for exactly one property

- **User → Review**: One-to-Many  
  - A user can write multiple reviews  
  - A review is written exactly by one user
    
- **Property → Images**: One-to-Many
  -  A property can have multiple images
  -  Each image is linked to one property

![ERD](https://github.com/BrianStatesThat/alx-airbnb-database/blob/c20b18841e398c21ba3b26987102bc8464f27658/images/diagram.png?raw=true)
