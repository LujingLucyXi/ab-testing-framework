CREATE OR REPLACE FUNCTION assign_users_to_experiments(p_experiment_id INTEGER, p_sample_size INTEGER)
RETURNS TABLE(assigned_count INTEGER) AS $$
DECLARE
  v_user_id BIGINT;
  v_variant_id INTEGER;
  v_hash_value NUMERIC;
  v_cumulative_percentage DECIMAL(5,2);
  v_assigned_count INTEGER := 0;
BEGIN
  -- Loop through sample of users
  FOR v_user_id IN SELECT user_id FROM users WHERE is_active = TRUE LIMIT p_sample_size LOOP
    
    -- Step 1: Generate deterministic hash from experiment_id + user_id
    -- MD5 creates a consistent hash for the same inputs
    -- This ensures same user always gets same variant
    
    -- Step 2: Convert hash to percentage (0-100)
    -- Extract first 8 hex characters and convert to integer
    -- Then normalize to 0-100 range
    v_hash_value := CAST(
      ('x' || SUBSTR(MD5(CAST(p_experiment_id AS VARCHAR) || CAST(v_user_id AS VARCHAR)), 1, 8))::bit(32)::bigint 
      AS NUMERIC
    ) / 4294967295.0 * 100;
    
    -- Step 3: Match hash value to variant based on cumulative percentages
    -- Example: If percentages are [20%, 16%, 16%, 16%, 16%, 16%]
    -- Cumulative: [20%, 36%, 52%, 68%, 84%, 100%]
    -- If hash_value = 25, user goes to variant with 36% (second bucket)
    
    SELECT variant_id INTO v_variant_id 
    FROM (
      SELECT 
        variant_id,
        SUM(target_percentage) OVER (ORDER BY variant_id) as cumulative_percentage
      FROM variants
      WHERE experiment_id = p_experiment_id
      ORDER BY variant_id
    ) t
    WHERE v_hash_value < cumulative_percentage
    LIMIT 1;
    
    -- Step 4: Insert assignment
    IF v_variant_id IS NOT NULL THEN
      INSERT INTO experiment_assignments (experiment_id, user_id, variant_id)
      VALUES (p_experiment_id, v_user_id, v_variant_id)
      ON CONFLICT (experiment_id, user_id) DO NOTHING;
      
      v_assigned_count := v_assigned_count + 1;
    END IF;
  END LOOP;
  
  RETURN QUERY SELECT v_assigned_count;
END;
$$ LANGUAGE plpgsql;
