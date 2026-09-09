# A/B Test: Credit Reminder in Onboarding

A full-cycle A/B test case study for a mobile app's onboarding flow - from experiment design and sample size calculation through statistical analysis, data quality investigation, and rollout recommendation.

## Business Context

The onboarding team's goal is to increase Conversion to First Payment. In the app, users pay to message each other using an in-app currency (credits). New users get a 20-credit welcome bonus at registration. When a user tries to message with zero credits, they see an "insufficient credits" message.

**Goal:** Increase Conversion to First Payment by 10%+ for new users.

**Hypothesis:** Showing users a pinned reminder message in chat when their credit balance runs low (≤5 credits) will nudge them toward their first payment ("last step" effect) without hurting overall product engagement.

**Variants:**
- **A (Control):** Standard flow - users only see "Insufficient credits" when they try to send a message with zero balance
- **B (Test):** A pinned reminder automatically appears when credits run low, and disappears permanently after first payment

## Experiment Design

- **Target audience:** New users registered after test launch, 50/50 traffic split
- **Sample size:** 28,495 users per group (56,991 total), calculated via power analysis (α = 0.05, power = 0.80, two-sided z-test)
- **Duration:** 16 days minimum, including a 7-day observation window (covers 75% of all users who ever convert, based on historical payment-timing distribution)
- **Primary metric:** Conversion to First Payment (%)
- **Secondary metric:** Conversion among users who spent 15+ credits (compared *between* groups, not within treatment, to avoid selection bias)
- **Guardrail metric:** % of users who spend 15+ credits - the reminder shouldn't discourage product usage before it's even shown

**Historical time-to-first-payment distribution** (used to size the 7-day observation window):

| Percentile | Days to first payment |
|---|---|
| 50th | 0 |
| 75th | 7 |
| 90th | 51 |
| 95th | 105 |

The 7-day window was chosen because it already captures 75% of all users who ever convert - extending it further would have meant a much longer test for diminishing returns.

**Note on actual test length:** the minimum required sample was 56,991 users across 16 days. The test actually ran 34 days and collected 125,217 users - over double the minimum. This didn't affect result validity.

## Tools Used

- **Python** (pandas, scipy, statsmodels) - data processing, power analysis, two-proportion z-test
- **Matplotlib / Seaborn** - payment-timing distribution, weekly conversion trend charts

## Results

**Test quality checks:**

| Check | Result | Comment |
|---|---|---|
| Sample Ratio Mismatch | 49.97% / 50.03% | Traffic split evenly, no systemic bias |
| Statistical significance | p = 0.0076 | Result is statistically significant |

**Primary metric:**

| Group | Users | Payments | Conversion Rate |
|---|---|---|---|
| Control (A) | 62,568 | 3,506 | 5.60% |
| Test (B) | 62,649 | 3,731 | 5.96% |
| **Difference** | | | **+0.35pp (+6.28% relative)** |

Achieved power = 76% (target 80%) - slightly underpowered since the actual effect size came in smaller than the targeted MDE, but the accumulated sample size still supports a reliable result.

**Secondary metric (users who spent 15+ credits):** conversion rose from 13.48% (Control) to 14.24% (Test), p = 0.012 — confirms the effect exists specifically among users who were actually exposed to the reminder threshold.

**Descriptive only - not a causal comparison:** within Group B, users who actually saw the reminder converted at 16.07% vs. 2.74% for those who didn't. This is a striking number, but it's a within-treatment split, not a between-group comparison - users who reach the reminder threshold are inherently more active/engaged than those who don't, so this gap reflects both the reminder's effect *and* pre-existing selection bias. It's useful color for understanding the mechanism, not evidence to cite as "the effect size."

**Guardrail:** share of users spending 15+ credits was virtually unchanged (41.1% control vs 41.3% test) - the reminder does not discourage product usage.

**Weekly trend:** groups tracked evenly in weeks 11-12 (new users need time to spend their first 15 credits and trigger the reminder), then Group B pulled consistently ahead from week 13 onward, peaking at +1.34pp in week 16 - the effect is stable and strengthens over time.

## Data Quality Investigation

Two issues were identified and documented during analysis:

1. **Data leakage** - 89 control-group users (0.14% of Control) were mistakenly tagged with a reminder timestamp despite never being exposed to the feature, pointing to a minor event-tagging bug in the backend traffic splitter. The leak is too small (<1%) to affect the p-value, but was flagged as a ticket for engineering.
2. **Timeline anomaly in reminder-to-payment interval** - distribution ranged from -39 to +266 days (median 0, mean 5.02 days). The negative tail reflects users who paid before ever seeing a reminder (already-paying users incorrectly re-triggered by the base logic); the long right tail reflects "sleeper" users who saw the reminder, left, and returned months later to pay.

## Recommendation

**Ship to 100% of traffic.** Although the primary +10% relative-lift target wasn't met, the achieved +6.28% lift is statistically robust and durable over time, with a fully clean guardrail metric. Recommended next steps:

1. Full technical rollout to all new users
2. Fix the data-leakage bug in the traffic splitter (engineering ticket)
3. Add a `user_is_free_tier == True` guard to the trigger logic to eliminate the negative-interval anomaly
4. **Future experiments:** test different credit thresholds (2 / 5 / 10) instead of a fixed 5; explore a dynamic, personalized trigger based on individual spend pace; test reminder copy/CTA variants and in-chat + push combinations
5. **Downstream audit:** after 3 months, compare long-term Retention and LTV of users who paid impulsively (same day as reminder) vs. those who purchased independently

## Repository Contents

- Python/Jupyter notebook - full analysis pipeline (sample size calc, z-test, segment analysis, cohort trend)
- Full report (PDF) - experiment design, results, data quality findings, and recommendations
