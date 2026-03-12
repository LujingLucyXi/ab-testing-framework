-- Conversion Rate Analysis by Test Group

SELECT 
  v.variant_code,
  v.variant_name,
  COUNT(DISTINCT ea.user_id) as total_users,
  COUNT(DISTINCT CASE WHEN ev.event_type = 'click' THEN ev.event_id END) as clicks,
  COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END) as conversions,
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN ev.event_type = 'conversion' THEN ev.event_id END) / 
    NULLIF(COUNT(DISTINCT ea.user_id), 0), 2
  ) as conversion_rate_pct
FROM experiments e
JOIN variants v ON e.experiment_id = v.experiment_id
LEFT JOIN experiment_assignments ea ON v.variant_id = ea.variant_id
LEFT JOIN events ev ON ea.experiment_id = ev.experiment_id AND ea.user_id = ev.user_id
WHERE e.experiment_id = $1
GROUP BY v.variant_id, v.variant_code, v.variant_name
ORDER BY v.variant_id;
