-- Generate Sample Data for A/B Testing Framework

-- Insert 10,000 sample users
INSERT INTO users (username, email, user_segment, country_code, is_active)
SELECT 
  'user_' || LPAD(seq::TEXT, 6, '0'),
  'user_' || seq || '@example.com',
  CASE seq % 3 WHEN 0 THEN 'premium' WHEN 1 THEN 'free' ELSE 'trial' END,
  CASE seq % 5 WHEN 0 THEN 'US' WHEN 1 THEN 'CA' WHEN 2 THEN 'GB' WHEN 3 THEN 'DE' ELSE 'FR' END,
  TRUE
FROM GENERATE_SERIES(1, 10000) AS seq
ON CONFLICT DO NOTHING;

-- Insert test experiment
INSERT INTO experiments (name, experiment_code, status, start_date, hypothesis)
VALUES ('Feature Test', 'exp_001', 'active', CURRENT_DATE, 'Features improve conversion')
ON CONFLICT DO NOTHING;

-- Insert variants
INSERT INTO variants (experiment_id, variant_name, variant_code, target_percentage, is_control)
VALUES 
  (1, 'Control', 'control', 20.0, TRUE),
  (1, 'Feature 1', 'feature_1', 16.0, FALSE),
  (1, 'Feature 2', 'feature_2', 16.0, FALSE),
  (1, 'Feature 3', 'feature_3', 16.0, FALSE),
  (1, 'Feature 4', 'feature_4', 16.0, FALSE),
  (1, 'Feature 5', 'feature_5', 16.0, FALSE)
ON CONFLICT DO NOTHING;

-- Assign users
SELECT assign_users_to_experiments(1, 10000);

-- Generate click events (2,500 clicks)
INSERT INTO events (experiment_id, user_id, event_type, event_timestamp)
SELECT ea.experiment_id, ea.user_id, 'click', 
       CURRENT_TIMESTAMP - INTERVAL '1 day' * RANDOM()
FROM experiment_assignments ea
WHERE RANDOM() < 0.25 LIMIT 2500;

-- Generate conversion events (750 conversions)
INSERT INTO events (experiment_id, user_id, event_type, event_timestamp)
SELECT ea.experiment_id, ea.user_id, 'conversion',
       CURRENT_TIMESTAMP - INTERVAL '12 hours' * RANDOM()
FROM experiment_assignments ea
WHERE RANDOM() < 0.075 LIMIT 750;
