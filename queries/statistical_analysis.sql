SELECT 
  v.variant_code,
  COUNT(DISTINCT ea.user_id) as total_users,
  COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END) as conversions,
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END) / 
    NULLIF(COUNT(DISTINCT ea.user_id), 0), 4
  ) as conversion_rate,
  ROUND(
    100.0 * (COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END)::NUMERIC / 
    NULLIF(COUNT(DISTINCT ea.user_id), 0) - 
    1.96 * SQRT(
      (COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END)::NUMERIC / 
       NULLIF(COUNT(DISTINCT ea.user_id), 0) * 
       (1 - COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END)::NUMERIC / 
       NULLIF(COUNT(DISTINCT ea.user_id), 0))) / 
      NULLIF(COUNT(DISTINCT ea.user_id), 0)
    )), 4
  ) as ci_lower_95,
  ROUND(
    100.0 * (COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END)::NUMERIC / 
    NULLIF(COUNT(DISTINCT ea.user_id), 0) + 
    1.96 * SQRT(
      (COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END)::NUMERIC / 
       NULLIF(COUNT(DISTINCT ea.user_id), 0) * 
       (1 - COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END)::NUMERIC / 
       NULLIF(COUNT(DISTINCT ea.user_id), 0))) / 
      NULLIF(COUNT(DISTINCT ea.user_id), 0)
    )), 4
  ) as ci_upper_95
FROM experiment_assignments ea
JOIN variants v ON ea.variant_id = v.variant_id
LEFT JOIN events ev ON ea.experiment_id = ev.experiment_id AND ea.user_id = ev.user_id
WHERE ea.experiment_id = $1
GROUP BY v.variant_id, v.variant_code
ORDER BY v.variant_id;
