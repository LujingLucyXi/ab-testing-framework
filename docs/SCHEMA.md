# Database Schema Documentation

## Overview

The A/B testing framework uses a normalized relational schema with 9 core tables supporting comprehensive experiment management and statistical analysis.

## Core Tables

### 1. users
**Purpose:** User profiles and segments for experiment participation

| Column | Type | Description | Constraints |
|--------|------|-------------|-------------|
| user_id | BIGSERIAL | Primary key | PRIMARY KEY, AUTO_INCREMENT |
| username | VARCHAR(255) | Unique username | UNIQUE, NOT NULL |
| email | VARCHAR(255) | User email address | UNIQUE, NOT NULL |
| created_at | TIMESTAMP | Account creation time | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | Last update time | DEFAULT CURRENT_TIMESTAMP |
| is_active | BOOLEAN | Active status flag | DEFAULT TRUE |
| user_segment | VARCHAR(50) | User segment (premium/free/trial) | NULLABLE |
| country_code | VARCHAR(2) | ISO country code | NULLABLE |

**Indexes:**
- `idx_users_created_at` - Temporal queries
- `idx_users_segment` - Segmentation analysis
- `idx_users_active` - Filter active users

**Example Data:**
```sql
INSERT INTO users (username, email, user_segment, country_code)
VALUES ('john_doe', 'john@example.com', 'premium', 'US');
