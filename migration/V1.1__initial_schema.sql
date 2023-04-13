CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_users_not_deleted ON users (email) WHERE NOT is_deleted;
----------------------------------------------------------------------------------------
CREATE TABLE property_listings (
    id SERIAL PRIMARY KEY,
    host_id INTEGER NOT NULL,
    property_type VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    number_of_bedrooms INTEGER NOT NULL,
    number_of_bathrooms INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    pricing NUMERIC(10, 2) NOT NULL,
    availability BOOLEAN NOT NULL DEFAULT TRUE,
    house_rules TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (host_id) REFERENCES users (id)
);

CREATE INDEX idx_property_listings_not_deleted ON property_listings (property_type) WHERE NOT is_deleted;

------------------------------------------------------------------------------------------

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    guest_id INTEGER NOT NULL,
    property_listing_id INTEGER NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    booking_status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (guest_id) REFERENCES users (id),
    FOREIGN KEY (property_listing_id) REFERENCES property_listings (id)
);

CREATE INDEX idx_bookings_not_deleted ON bookings (guest_id) WHERE NOT is_deleted;

------------------------------------------------------------------------------------------

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    guest_id INTEGER NOT NULL,
    host_id INTEGER NOT NULL,
    booking_id INTEGER NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT,
    property_listing_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (guest_id) REFERENCES users (id),
    FOREIGN KEY (host_id) REFERENCES users (id),
    FOREIGN KEY (property_listing_id) REFERENCES property_listings (id),
    FOREIGN KEY (booking_id) REFERENCES bookings (id)
);

CREATE INDEX idx_reviews_not_deleted ON reviews (property_listing_id) WHERE NOT is_deleted;

------------------------------------------------------------------------------------------

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    booking_id INTEGER NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    payment_status VARCHAR(255) NOT NULL,
    guest_id INTEGER NOT NULL,
    payment_method VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (booking_id) REFERENCES bookings (id)
);

CREATE INDEX idx_payments_not_deleted ON payments (guest_id) WHERE NOT is_deleted;

------------------------------------------------------------------------------------------
