# Methodology in A/B Testing Framework

## User Assignment
- **Deterministic MD5 Hashing Formula**: 
  
  
  Hash = MD5(experiment_id || user_id)

## Conversion Rate Calculation
- **Formulas**:
  - Conversion Rate = (Number of Conversions) / (Total Users)
  - Click Rate = (Number of Clicks) / (Total Impressions)
  - Average Events per User = (Total Events) / (Total Users)

## Chi-square Statistical Testing
- **Null Hypothesis (H0)**: There is no difference in conversion rates between groups.
- **Alternative Hypothesis (H1)**: There is a difference in conversion rates between groups.

## t-Test for Continuous Metrics
- Use t-tests to compare means between two groups.

## 95% Confidence Intervals for Proportions
- **Z-Score**: Use a 1.96 z-score for 95% confidence intervals.

## Effect Size using Cohen's h Formula
- Effect Size (h) = 2 * (Φ1 - Φ2) / √(1 - Φ1² - Φ2²)

## Sample Size Calculation Formula
- Use power analysis to determine the sample size needed for your experiment.

## Multiple Comparisons Correction
- **Methods**:
  - Bonferroni Correction
  - False Discovery Rate (FDR)

## Power Analysis
- Evaluate the power of your experiment to avoid Type II errors.

## Sequential Analysis
- **Fixed Horizon vs Optional Stopping**: Understand the differences and implications for your analysis.

## Common Pitfalls
- P-Hacking
- Peeking
- Insufficient Sample Size
- Simpson's Paradox
- Survivorship Bias

## Best Practices
- Always define your success metrics beforehand.
- Pre-register your experiments where possible.

## Reference Formulas
| Topic                     | Formula                                            |
|---------------------------|----------------------------------------------------|
| Conversion Rate           | (Conversions) / (Total Users)                      |
| Click Rate                | (Clicks) / (Impressions)                           |
| Cohen's h                 | 2 * (Φ1 - Φ2) / √(1 - Φ1² - Φ2²)                   |

