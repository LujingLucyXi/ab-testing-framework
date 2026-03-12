-- Database Schema for A/B Testing Framework
CREATE TABLE experiments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    control_group_ratio DECIMAL(5, 2) CHECK (control_group_ratio >= 0 AND control_group_ratio <= 1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_experiment_assignments (
    user_id INT NOT NULL,
    experiment_id INT NOT NULL,
    group_assigned VARCHAR(10) CHECK (group_assigned IN ('control', 'treatment')), 
    PRIMARY KEY (user_id, experiment_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (experiment_id) REFERENCES experiments(id)
);

CREATE TABLE experiment_results (
    id SERIAL PRIMARY KEY,
    experiment_id INT NOT NULL,
    user_id INT NOT NULL,
    conversion BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (experiment_id) REFERENCES experiments(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);