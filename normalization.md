# Normalization Review and Steps to 3NF

## Objective
Ensure the database schema adheres to the **Third Normal Form (3NF)** to eliminate data redundancy and ensure data integrity.

---

## 1. Normalization Principles Overview

###  First Normal Form (1NF)
- Each table has a **primary key**.
- All attributes contain only **atomic (indivisible)** values.
- Each field contains values of a **single type**.

### Second Normal Form (2NF)
- Must be in **1NF**.
- All non-key attributes are **fully functionally dependent** on the **entire primary key** (no partial dependencies).

### Third Normal Form (3NF)
- Must be in **2NF**.
- No **transitive dependencies** (non-key attribute depending on another non-key attribute).

---

## 2. Schema Review & Normalization Steps

### User Table
-  Already in **3NF**:
  - `user_id` is the **primary key**.
  - All other attributes depend solely on `user_id`.
  - No partial or transitive dependencies.

**No changes needed.**

---

### Property Table
- Contains `host_id` as a foreign key → `User(user_id)`.
- All fields are atomic and depend on `property_id`.
- Some fields can be normalized further:
  - `property_type` should reference a **PropertyTypes** table.
  - Address-related fields should be separated into an **Addresses** table.

#### 🔧 Normalization Action:
- Create **PropertyTypes** table for `property_type`.
- Create **Addresses** table for `address`, `city`, `state`, `country`, `postal_code`.

** Result:**
- `Properties` references `property_type_id` and `address_id`.
- Fully conforms to 3NF.

---

###  Booking Table
- `booking_id` is the **primary key**.
- `property_id` and `guest_id` are foreign keys.
- All other fields depend only on `booking_id`.

** Already in 3NF. No changes needed.**

---

### Payment Table
- `payment_id` is the **primary key**.
- `booking_id` is a foreign key.
- All other fields are directly dependent on `payment_id`.
- Optional: Create lookup tables for:
  - `payment_status`
  - `payment_method`

** Structurally in 3NF. No mandatory changes.**

---

### Review Table
- `review_id` is the **primary key**.
- `property_id`, `guest_id`, and `booking_id` are foreign keys.
- All other fields depend only on `review_id`.

** Already satisfies 3NF. No changes needed.**

---

###  Image Table
- `image_id` is the **primary key**.
- `property_id` is a foreign key.
- All other fields describe the image, with no multivalued or transitive dependencies.

** In 3NF. No changes needed.**

---

###  PropertyTypes Table *(New)*
- Created to remove repeating values in `property_type`.
- Fields: `property_type_id`, `type_name`.

** Normalized and reusable.**

---

###  Addresses Table *(New)*
- Consolidates:
  - `address`, `city`, `state`, `country`, `postal_code`
- Fields: `address_id`, `address_line`, `city`, `state`, `country`, `postal_code`.

** Reduces duplication and supports 3NF.**

---

###  Amenities & PropertyAmenities Tables *(New)*
- **Amenities** table holds individual amenity names.
- **PropertyAmenities** is a join table between `property_id` and `amenity_id`.

** Removes multivalued field (from Property). Now conforms to 1NF, 2NF, and 3NF.**

---

## 3.  Final Assessment

After evaluating each table:
- All tables satisfy **1NF**, **2NF**, and **3NF**.
- No multivalued fields remain.
- No partial dependencies.
- No transitive dependencies.
- Foreign keys and lookup tables are appropriately used.

---

## Conclusion

The Airbnb Clone database schema has been normalized and fully adheres to **3NF**:
- Data redundancy is minimized.
- Integrity and scalability are ensured.
- Ready for implementation with strong relational design.