# Credit Scoring: Logistic Regression

A credit card approval model built with logistic regression, focused on business-driven metric selection over raw accuracy.

## Business Context

A bank needs to assess a credit card applicant's creditworthiness and decide whether to approve or reject the application, based on 11 features (credit history, income, spending, housing, employment, dependents, etc.).

## Dataset

1,319 applications, no missing values. Target variable `card` is imbalanced: ~78% approved, ~22% rejected.

## Tools Used

Python (pandas, scikit-learn, matplotlib) - preprocessing, logistic regression, hyperparameter tuning, evaluation.

## Why Accuracy Isn't Enough

A naive model predicting "approve" every time would hit ~78% accuracy without learning anything. Precision, recall, and specificity give a more honest read.

## Feature Importance

| Strongest positive | Strongest negative |
|---|---|
| share (+5.73), expenditure (+4.85) | reports (−1.96), dependents (−0.28) |

Clients who already spend actively on credit are *more* likely approved (established repayment history). A history of negative credit reports is the clearest rejection signal.

## Choosing the Right Metric

**Specificity** matters most here: approving a risky client (false positive) causes direct financial loss, while rejecting a good one (false negative) is only a missed opportunity. The asymmetry makes specificity the priority for tuning.

## Hyperparameter Tuning

- **Best penalty: none** - specificity hit 0.986, vs. 0.972 (L1) and 0.875 (L2).
- **C turned out irrelevant once `penalty=None`.** All tested values (0.001–1000) gave the same specificity - scikit-learn even warns of this, since `C` only scales a regularization term that no longer exists. The flat curve confirms `C` has no effect here, not that "regularization doesn't help" (that was already shown by the penalty comparison).

## Results: Baseline vs. Optimized

| Metric | Baseline | Optimized | Change |
|---|---|---|---|
| Accuracy | 0.9545 | 0.9727 | ↑ |
| Precision | 0.9691 | 0.9960 | ↑ |
| Recall | 0.9729 | 0.9690 | ~same |
| F1 | 0.9710 | 0.9823 | ↑ |
| **Specificity** | **0.8889** | **0.9861** | **↑↑ (false positives 8 → 1)** |

## Key Takeaway

Removing regularization entirely cut false positives from 8 to 1 out of 72 high-risk applicants, with recall and accuracy essentially unchanged. Tuning `C` added nothing further, since it only matters when regularization is actually applied.

## Repository Contents

- Python/Jupyter notebook - preprocessing, model training, metric evaluation, hyperparameter tuning with validation curves
