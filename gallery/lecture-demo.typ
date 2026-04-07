#import "../bypst.typ": *

#show: bips-theme.with(base-size: 16pt)

// ============================================================================
// INTRODUCTION TO STATISTICAL MODELING - LECTURE DEMO
// ============================================================================
//
// This is a demonstration of a full-length lecture (100 slides) to test
// compilation performance with the BIPS theme on realistic content volumes.

#title-slide(
  title: "Fake Introduction to Statistical Modeling",
  subtitle: "A Made Up Overview for Demo Purposes",
  author: "Prof. Dr. Schlau",
  institute: "Institute of Things and Stuff",
  date: "Winter Semester 2024",
  occasion: "STAT 42 - Lecture 1",
)

#section-slide("Course Overview")

#bips-slide(title: "Welcome to Statistical Modeling")[
  === Course Objectives
  - Understand fundamental concepts of statistical modeling
  - Learn to select appropriate models for different data types
  - Develop skills in model validation and interpretation
  - Apply statistical software for real-world problems

  === Prerequisites
  - Basic statistics (descriptive statistics, probability)
  - Elementary calculus and linear algebra
  - Some programming experience (R or Python preferred)
]

#bips-slide(title: "Course Structure", subtitle: "14-Week Schedule & Assessment")[
  #two-columns[
    1. *Weeks 1-2*: Linear Regression
    2. *Weeks 3-4*: Multiple Regression
    3. *Weeks 5-6*: Generalized Linear Models
    4. *Weeks 7-8*: Logistic & Poisson
    5. *Weeks 9-10*: Mixed Effects
    6. *Weeks 11-12*: Time Series
    7. *Weeks 13-14*: Machine Learning
  ][
    *Assessment:*
    - Homework: 40%
    - Midterm: 25%
    - Final project: 35%
  ]
]

#bips-slide(title: "Learning Resources", subtitle: "Textbooks & Software")[
  #two-columns[
    *Required Textbooks:*
    - Kutner et al. "Applied Linear Statistical Models"
    - Dobson & Barnett "GLM Introduction"
  ][
    *Software:*
    - R with RStudio (primary)
    - Python with statsmodels
    - SPSS (alternative)
  ]

  #callout(type: "tip")[
    All software freely available with guides provided.
  ]
]

#section-slide("What is Statistical Modeling?")

#bips-slide(title: "Statistical Models", subtitle: "Definition & Key Components")[
  #two-columns[
    A mathematical representation that:
    - Captures variable relationships
    - Accounts for uncertainty
    - Enables prediction/inference
    - Provides mechanistic insights
  ][
    *Components:*
    - *Response variable* (outcome)
    - *Explanatory variables* (predictors)
    - *Error term* (random variation)
    - *Parameters* (to estimate)
  ]
]

#bips-slide(title: "Types of Statistical Models")[
  #two-columns[
    == By Response Variable Type
    - *Continuous*: Linear regression, ANOVA
    - *Binary*: Logistic regression
    - *Count*: Poisson regression
    - *Categorical*: Multinomial regression
    - *Time-to-event*: Survival models
  ][
    == By Complexity
    - *Simple*: One predictor variable
    - *Multiple*: Several predictor variables
    - *Multivariate*: Multiple response variables
    - *Hierarchical*: Nested or grouped data
  ]

]

#bips-slide(title: "Model Building Philosophy", text-size: 16pt)[
  1. *Problem formulation*: Define research question
  2. *Data collection*: Gather relevant observations
  3. *Exploratory analysis*: Understand data structure
  4. *Model specification*: Choose appropriate form
  5. *Parameter estimation*: Fit model to data
  6. *Model diagnostics*: Check assumptions
  7. *Model refinement*: Improve if necessary
  8. *Interpretation*: Draw conclusions

  #callout(type: "tip")[
    "All models are wrong, but some are useful." --- George Box
  ]
]

#section-slide("Linear Regression Foundations")

#bips-slide(title: "Simple Linear Regression")[
  === Mathematical Form
  $ y_i = beta_0 + beta_1 x_i + epsilon_i $

  #two-columns(
    [
      Where:
      - $y_i$: Response for observation $i$
      - $x_i$: Predictor for observation $i$
      - $beta_0$: Intercept parameter
      - $beta_1$: Slope parameter
      - $epsilon_i$: Random error term
    ],
    [
      === Assumptions
      - *Linearity*: Relationship is linear
      - *Independence*: Observations are independent
      - *Homoscedasticity*: Constant error variance
      - *Normality*: Errors are normally distributed
    ],
  )


]

#bips-slide(title: "Parameter Estimation", subtitle: "Least Squares Method", text-size: 16pt)[
  Minimize: $ "SSE" = sum_(i=1)^n (y_i - hat(y)_i)^2 $
  #vfill
  #two-columns[
    *Normal Equations:*
    $ hat(beta)_1 = (sum (x_i - overline(x))(y_i - overline(y))) / (sum (x_i - overline(x))^2) $

    $ hat(beta)_0 = overline(y) - hat(beta)_1 overline(x) $
  ][
    *Properties:*
    - Unbiased estimators
    - Minimum variance (BLUE)
    - Closed-form solution
  ]
]

#bips-slide(title: "Coefficient Interpretation")[
  #two-columns(
    [
      == Slope Coefficient ($beta_1$)
      - Expected change in $y$ for one-unit\ increase in $x$
      - Units: (units of $y$)/(units of $x$)
      - Sign indicates direction of relationship
    ],
    [
      == Intercept ($beta_0$)
      - Expected value of $y$ when $x = 0$
      - May not be meaningful if $x = 0$ is outside observed range
      - Sometimes centered for better interpretation
    ],
  )

  #pause

  #callout(type: "warning")[
    Correlation does not imply causation. Be careful about causal interpretation.
  ]
]

#bips-slide(title: "Goodness of Fit", subtitle: [Coefficient of Determination ($R^2$)])[
  
  $ R^2 = ("SSR") / ("SST") = 1 - ("SSE") / ("SST") $
  
  #two-columns(
    [
      Where:
      - SST = Total sum of squares
      - SSR = Regression sum of squares
      - SSE = Error sum of squares
    ],
    [
      === Interpretation
      - Proportion of variance in $y$ explained by $x$
      - Range: 0 to 1 (0% to 100%)
      - Higher values indicate better fit
      - *Caution*: High $R^2$ doesn't guarantee good model
    ],
  )
  

]

#bips-slide(title: "Hypothesis Testing")[
  #two-columns[
    == Testing Slope Significance
    - *Null hypothesis*: $H_0: beta_1 = 0$
    - *Alternative*: $H_1: beta_1 ≠ 0$
    - *Test statistic*: $t = (hat(beta)_1) / ("SE"(hat(beta)_1))$
    - *Distribution*: $t$ with $n-2$ degrees of freedom
  ][
    == Confidence Intervals
    $ hat(beta)_1 ± t_(alpha\/2, n-2) × "SE"(hat(beta)_1) $
    
    == P-values and Interpretation
    - Small p-value (< 0.05): Evidence against $H_0$
    - Large p-value: Insufficient\ evidence against $H_0$
  ]

]

#section-slide("Multiple Linear Regression")

#bips-slide(
  title: "Multiple Regression",
  subtitle: "General Form & Matrix Notation",
  text-size: 16pt,
  content-align: horizon,
)[
  $ y_i = beta_0 + beta_1 x_("1i") + beta_2 x_("2i") + ... + beta_p x_("pi") + epsilon_i $
  
  #two-columns[
    == Matrix Form:
    $ bold(y) = bold(X) bold(beta) + bold(epsilon) $
  ][
    == Where:
    - $bold(y)$: response vector $(n times 1)$
    - $bold(X)$: design matrix $(n times (p times 1))$
    - $bold(beta)$: parameters $((p+1) times 1)$
    - $bold(epsilon)$: errors $(n times 1)$
  ]
]

#bips-slide(title: "Multiple Regression Estimation", subtitle: "Normal Equations & Assumptions", text-size: 16pt)[
  $ hat(bold(beta)) = (bold(X)^top bold(X))^(-1) bold(X)^top bold(y) $

  #two-columns[
    == Assumptions:
    - Linearity in parameters
    - Independence of observations
    - Constant error variance
    - Normal error distribution
    - No multicollinearity
  ][
    #align(horizon)[
      #callout(type: "note")[
        $bold(X)^top bold(X)$ must be invertible.
      ]
    ]
  ]
]

#bips-slide(title: "Coefficient Interpretation")[
  === Partial Regression Coefficients
  - $hat(beta)_j$: Expected change in $y$ for one-unit increase in $x_j$
  - *Holding all other variables constant*
  - Accounts for relationships among predictors
  - Can differ substantially from simple regression coefficients

  === Example: House Price Model

  $"Price" = beta_0 + beta_1("Size") + beta_2("Bedrooms") + beta_3("Age") + epsilon$

  - $beta_1$: Price change per sq ft, holding bedrooms and age constant
  - $beta_2$: Price change per bedroom, holding size and age constant
]

#bips-slide(title: "Model Selection", text-size: 16pt)[
  #two-columns[
    === Forward Selection
    1. Start with no variables
    2. Add variable with smallest p-value
    3. Continue until no improvement
    
    === Backward Elimination
    1. Start with all variables
    2. Remove variable with largest p-value > α
    3. Continue until all p-values ≤ α
  ][
    === Stepwise Selection
    - Combination of forward and backward
    - Can add or remove variables at each step
    - Most commonly used approach
  ]
]

#bips-slide(title: "Information Criteria")[
  === Akaike Information Criterion (AIC)
  $ "AIC" = n ln("SSE" / n) + 2p $

  === Bayesian Information Criterion (BIC)
  $ "BIC" = n ln("SSE" / n) + p ln(n) $

  === Usage
  #two-columns(columns: (0.9fr, 1fr))[
    - Lower values indicate better models
    - Balance fit quality with model complexity
  ][
    - BIC penalizes complexity more heavily than AIC
    - Useful for comparing non-nested models
  
  ]
]

#section-slide("Model Diagnostics")

#bips-slide(title: "Residual Analysis", subtitle: "Types & Diagnostic Plots", text-size: 16pt)[
  #two-columns[
    *Residual Types:*
    - *Raw*: $e_i = y_i - hat(y)_i$
    - *Standardized*: $r_i = e_i / s$
    - *Studentized*: $t_i = e_i / (s sqrt(1 - h_("ii")))$
    - *Deleted*: Leave-one-out
  ][
    *Diagnostic Plots:*
    1. Residuals vs. fitted
    2. Normal Q-Q plot
    3. Scale-location plot
    4. Cook's distance
  ]
]

#bips-slide(title: "Assumption Checking", subtitle: "Linearity & Homoscedasticity")[
  #two-columns[
    *Linearity:*
    - *Check*: Residuals vs. fitted
    - *Good*: Random scatter
    - *Bad*: Curved pattern
    - *Fix*: Transformations
  ][
    *Homoscedasticity:*
    - *Check*: Scale-location plot
    - *Good*: Constant spread
    - *Bad*: Funnel shape
    - *Fix*: Weighted least squares
  ]
]

#bips-slide(title: "Outliers and Influence", text-size: 16pt)[
  #two-columns[
    == Outliers
    - Observations with unusual response values
    - Large residuals ($abs("studentized residual") > 2$)
    - May indicate data errors or special cases
    
    == Leverage
    - Observations with unusual predictor values
    - High leverage: $h_("ii") > 2p / n$
    - Can have strong influence on fit
  ][
    == Cook's Distance
    - Measures overall influence of observation
    - $D_i > 1$ suggests influential observation
    - Combines residual size and leverage
  ]
  
]

#bips-slide(title: "Transformation Techniques", text-size: 16pt)[
  === Response Transformations
  - *Log transformation*: $ln(y)$ for right-skewed data
  - *Square root*: $sqrt(y)$ for count data
  - *Box-Cox*: $y^(lambda)$ family of transformations

  === Predictor Transformations
  - *Polynomial*: $x, x^2, x^3, ...$
  - *Logarithmic*: $ln(x)$ for exponential relationships
  - *Reciprocal*: $1 / x$ for hyperbolic relationships

  #callout(type: "tip")[
    Always interpret results in terms of original scale when possible.
  ]
]

#section-slide("Categorical Predictors")

#bips-slide(title: "Dummy Variables")[
  #two-columns()[
    === Binary Categorical Variable
    Example: Gender (Male/Female)
    - Create dummy: $x = cases(1 "if Male", 0 "if Female")$
    - Model: $y = beta_0 + beta_1 x + epsilon$
    - Interpretation:
      - $beta_0$: Expected $y$ for reference group (Female)
      - $beta_1$: Difference between groups (Male - Female)
  ][
    === Multiple Categories
    For $k$ categories, create $k-1$ dummy variables
    - Reference category has all dummies = 0
    - Each coefficient represents difference from reference
  ]

]

#bips-slide(title: "ANOVA as Regression", text-size: 15pt)[
  === One-Way ANOVA
  Compare means across groups using dummy variables

  === Two-Way ANOVA
  $ y_("ijk") = mu + alpha_i + beta_j + (alpha beta)_("ij") + epsilon_("ijk") $

  - $alpha_i$: Main effect of factor A
  - $beta_j$: Main effect of factor B
  - $(alpha beta)_("ij")$: Interaction effect
  - Implemented using dummy variables and interactions

  === Advantages of Regression Approach
  - Handles unbalanced designs naturally
  - Easy to include continuous covariates
  - Flexible contrast coding
]

#bips-slide(title: "Interaction Effects")[
  === Concept
  Effect of one variable depends on level of another variable

  === Mathematical Form
  $ y = beta_0 + beta_1 x_1 + beta_2 x_2 + beta_3 x_1 x_2 + epsilon $

  === Interpretation
  - $beta_1$: Effect of $x_1$ when $x_2 = 0$
  - $beta_2$: Effect of $x_2$ when $x_1 = 0$
  - $beta_3$: Change in effect of $x_1$ per unit change in $x_2$

  #callout(type: "important")[
    Always include main effects when modeling interactions.
  ]
]

#section-slide("Generalized Linear Models")

#bips-slide(title: "GLM Framework", subtitle: "Three Components", text-size: 16pt)[
  #two-columns[
    *Components:*
    1. *Random*: Response distribution
    2. *Systematic*: Linear predictor
    3. *Link*: Connects mean to predictor
  ][
    *General Form:*
    - $y_i ~ "ExpFamily"(mu_i, phi)$
    - $eta_i = bold(x)_i^top bold(beta)$
    - $g(mu_i) = eta_i$
  ]

  *Exponential Family:* Normal, Binomial, Poisson, Gamma
]

#bips-slide(title: "Logistic Regression", subtitle: "Binary Response Models", text-size: 15pt)[
  *Model:* $y_i ~ "Bernoulli"(pi_i)$, $"logit"(pi_i) = bold(x)_i^top bold(beta)$

  #two-columns[
    *Interpretation:*
    - $beta_j$: Log-odds ratio
    - $exp(beta_j)$: Odds ratio
    - OR > 1: Positive effect
    - OR < 1: Negative effect
  ][
    *Estimation:*
    - Maximum likelihood
    - No closed form
    - Iterative methods
  ]
]

#bips-slide(title: "Poisson Regression")[
  === Count Data
  - $y_i ~ "Poisson"(lambda_i)$
  - $ln(lambda_i) = bold(x)_i^top bold(beta)$ (log link)
  - $lambda_i = exp(bold(x)_i^top bold(beta))$

  === Interpretation
  - $beta_j$: Log rate ratio per unit change in $x_j$
  - $exp(beta_j)$: Rate ratio per unit change in $x_j$
  - Rate ratio > 1: Increases count
  - Rate ratio < 1: Decreases count

  === Overdispersion
  - Variance > mean violates Poisson assumption, use negative binomial or quasi-Poisson models
]

#bips-slide(title: "Model Comparison")[
  #two-columns(
    [
      === Deviance
      $ D = 2[l("saturated") - l("fitted")] $
      - Measure of model lack-of-fit
      - Lower deviance indicates better fit
      - Asymptotically chi-squared distributed
    ],
    [
      === AIC for GLMs
      $ "AIC" = -2l + 2p $
      - Balances fit quality with complexity
      - Use for model selection among GLMs
    ],
  )

  === Likelihood Ratio Tests
  Compare nested models using deviance difference
  $ "LRT" = D_("reduced") - D_("full") ~ chi^2_("df") $
]

#section-slide("Advanced Topics")

#bips-slide(title: "Mixed Effects Models", subtitle: "Accounting for Clustering", text-size: 16pt)[
  #two-columns[
    *Components:*
    - *Fixed effects*: Population-level
    - *Random effects*: Group-specific
    - *Applications*: Longitudinal, hierarchical
  ][
    *Model:*
    $ y_(i j) = bold(x)_(i j)^top bold(beta) + bold(z)_(i j)^top bold(u)_i + epsilon_(i j) $

    Accounts for within-group correlation
  ]
]

#bips-slide(title: "Time Series Analysis")[
  === Temporal Dependencies
  - Observations ordered in time
  - Serial correlation violates independence
  - Need specialized models

  === Autoregressive Models
  $ y_t = phi_1 y_(t-1) + phi_2 y_(t-2) + ... + phi_p y_(t-p) + epsilon_t $

  === Moving Average Models
  $ y_t = epsilon_t + theta_1 epsilon_(t-1) + ... + theta_q epsilon_(t-q) $

  === ARIMA Models
  Combine autoregressive, integrated, moving average components
]

#bips-slide(title: "Machine Learning Integration", subtitle: "Modern Extensions", text-size: 16pt)[
  #two-columns[
    *Regularized Regression:*
    - *Ridge*: $L_2$ penalty
    - *Lasso*: $L_1$ penalty + selection
    - *Elastic Net*: Combined approach

    *Tree Methods:*
    - Random forests
    - Gradient boosting
  ][
    *Key Considerations:*
    - Cross-validation
    - Bias-variance tradeoff
    - Interpretability vs. accuracy
    - Nonlinear relationships
  ]
]

#section-slide("Practical Applications")

#bips-slide(title: "Clinical Research Example", text-size: 14pt)[
  === Research Question
  Factors affecting blood pressure in hypertensive patients

  === Variables
  - *Response*: Systolic blood pressure (mmHg)
  - *Predictors*: Age, BMI, medication type, exercise level
  - *Sample size*: n = 500 patients

  === Model Development
  1. Exploratory data analysis
  2. Check for missing data patterns
  3. Transform variables if needed
  4. Fit multiple regression model
  5. Check assumptions and diagnostics
  6. Interpret results clinically
]

#bips-slide(title: "Epidemiological Study", text-size: 15pt)[
  === Case-Control Study
  Investigate risk factors for lung cancer

  === Logistic Regression Analysis
  - *Response*: Cancer status (Yes/No)
  - *Predictors*: Smoking, age, occupational exposure
  - *Effect measures*: Odds ratios with confidence intervals

  #pause

  #two-columns[
    === Results Table
    #table(
      columns: 4,
      [*Variable*], [*OR*], [*95% CI*], [*p-value*],
      [Smoking], [3.2], [2.1-4.8], [\< 0.001],
      [Age (10y)], [1.4], [1.2-1.7], [0.001],
      [Exposure], [1.8], [1.1-2.9], [0.02],
    )
  ][
    === Interpretation
    - Smoking increases odds by 220%
    - Age effect: 40% increase per decade
    - Occupational exposure significant
    - Control for confounding important
  ]
]

#bips-slide(title: "Public Health Surveillance", text-size: 15pt)[
  === Disease Monitoring
  Track infectious disease incidence over time

  === Poisson Regression Application
  - *Response*: Weekly case counts
  - *Predictors*: Time trend, seasonality, interventions
  - *Offset*: Population size (log scale)

  === Model Features
  $ ln(E[Y_t]) = ln("population"_t) + beta_0 + beta_1 t + beta_2 sin(2pi t / 52) + beta_3 cos(2pi t / 52) $

  - Population offset accounts for varying population
  - Sinusoidal terms capture seasonal patterns
  - Time trend identifies long-term changes
]

#bips-slide(title: "Environmental Health Study")[
  === Air Pollution and Mortality
  Daily time series analysis in urban area

  === Mixed Effects Approach
  - *Level 1*: Daily observations within years
  - *Level 2*: Year-to-year variation
  - *Predictors*: PM2.5, temperature, humidity, day of week

  === Challenges
  - *Nonlinear effects*: Smooth functions for temperature
  - *Lag effects*: Pollution effects may be delayed
  - *Confounding*: Weather, seasonal patterns
  - *Overdispersion*: Extra-Poisson variation in counts
]

#section-slide("Software Implementation")

#bips-slide(title: "R Implementation")[
  === Basic Linear Regression
  ```r
  # Fit model
  model <- lm(y ~ x1 + x2 + x3, data = mydata)

  # Model summary
  summary(model)

  # Diagnostics
  plot(model)

  # Predictions
  predict(model, newdata = new_observations)
  ```

  === Useful Packages
  - *broom*: Tidy model outputs
  - *car*: Advanced diagnostics
  - *MASS*: Robust methods
]

#bips-slide(title: "Logistic Regression in R")[
  ```r
  # Fit logistic regression
  model <- glm(outcome ~ predictor1 + predictor2,
               family = binomial, data = mydata)

  # Odds ratios
  exp(coef(model))
  exp(confint(model))

  # Model selection
  step(model, direction = "both")

  # ROC analysis
  library(pROC)
  roc_curve <- roc(mydata$outcome, fitted(model))
  auc(roc_curve)
  ```
]

#bips-slide(title: "Python Alternative")[
  === statsmodels Package
  ```python
  import statsmodels.api as sm
  import pandas as pd

  # Prepare data
  X = sm.add_constant(data[['x1', 'x2', 'x3']])
  y = data['y']

  # Fit model
  model = sm.OLS(y, X).fit()

  # Results
  print(model.summary())

  # Predictions
  predictions = model.predict(X_new)
  ```
]

#section-slide("Best Practices")

#bips-slide(title: "Model Building Guidelines", subtitle: "Best Practices", text-size: 16pt)[
  #two-columns[
    *Start Simple:*
    - Begin with univariate analyses
    - Add complexity gradually
    - Document decisions

    *Check Assumptions:*
    - Plot residuals routinely
    - Test normality when critical
  ][
    *Validate Results:*
    - Use holdout samples
    - Cross-validation
    - Bootstrap confidence intervals
    - Sensitivity analyses
  ]
]

#bips-slide(title: "Reporting Standards")[
  #two-columns(
    [
      === Methods Section
      - Describe model selection process
      - Report assumption checking
      - Justify transformations
      - State significance level
    ],
    [
      === Results Presentation
      - Effect sizes with confidence intervals
      - Model fit statistics (R², AIC)
      - Sample sizes clearly stated
      - Limitations acknowledged
    ],
  )


  #vfill

  #callout(type: "important")[
    Follow STROBE guidelines for observational studies.
  ]
]

#bips-slide(title: "Common Pitfalls")[
  #two-columns(
    [
      === Statistical Issues
      - *p-hacking*: Multiple testing without correction
      - *Overfitting*: Too many parameters for sample size
      - *Multicollinearity*: Highly correlated predictors
      - *Selection bias*: Non-representative samples
    ],
    [
      === Interpretation Errors
      - *Causal inference*: Correlation ≠ causation
      - *Extrapolation*: Predictions outside data range
      - *Effect size*: Focus on practical significance
      - *Missing data*: Understand missingness patterns
    ],
  )


]

#section-slide("Case Study Walkthrough")

#bips-slide(title: "Research Question", text-size: 15pt)[
  === Study Objective
  Identify factors associated with childhood obesity in a school-based sample

  === Data Description
  - *Sample*: 1,200 children ages 6-12
  - *Response*: BMI z-score (continuous)
  - *Predictors*: Age, sex, parental education, screen time, physical activity, sleep duration
  - *Design*: Cross-sectional survey

  === Analysis Plan
  1. Descriptive statistics
  2. Correlation analysis
  3. Multiple regression modeling
  4. Model diagnostics and validation
]

#bips-slide(title: "Exploratory Analysis")[
  #two-columns[
    === Summary Statistics
    #table(
      columns: 4,
      [*Variable*], [*Mean*], [*SD*], [*Range*],
      [BMI z-score], [0.3], [1.1], [-2.1, 3.4],
      [Age (years)], [9.2], [2.0], [6.0, 12.0],
      [Screen time (h/day)], [3.1], [1.8], [0.0, 8.0],
      [Physical activity (h/week)], [4.2], [2.3], [0.0, 14.0],
      [Sleep (hours)], [9.8], [1.2], [7.0, 12.0],
    )
  ][
    === Key Findings
    - BMI z-scores slightly above average
    - Wide variation in screen time
    - Some children very inactive
    - Most children meet sleep recommendations
    - 15% missing data on parental education

      #callout(type: "note")[
        Missing data analysis suggests MCAR (Missing Completely At Random) pattern.
      ]
  ]


]

#bips-slide(title: "Model Development")[
  === Initial Model
  ```
  BMI_z = β₀ + β₁(Age) + β₂(Sex) + β₃(Parent_Ed) +
          β₄(Screen_Time) + β₅(Physical_Activity) +
          β₆(Sleep) + ε
  ```

  === Model Results
  - *R² = 0.31*: Model explains 31% of BMI z-score variation
  - *Significant predictors*: Screen time (+), Physical activity (−), Sleep (−)
  - *Non-significant*: Age, sex, parental education
  - *Residual analysis*: Slight right skew, otherwise acceptable

  === Refined Model
  Remove non-significant predictors and add quadratic terms for screen time
]

#bips-slide(title: "Final Results and Interpretation", text-size: 15pt)[
  #table(
    columns: 5,
    [*Predictor*], [*Coefficient*], [*SE*], [*95% CI*], [*p-value*],
    [Intercept], [2.1], [0.4], [1.4, 2.9], [\< 0.001],
    [Screen time], [0.15], [0.03], [0.09, 0.21], [\< 0.001],
    [Screen time²], [0.02], [0.01], [0.00, 0.04], [0.03],
    [Physical activity], [−0.08], [0.02], [−0.12, −0.04], [\< 0.001],
    [Sleep duration], [−0.12], [0.04], [−0.20, −0.04], [0.004],
  )

  === Clinical Interpretation
  - Each hour of screen time increases BMI z-score by 0.15 units
  - Effect accelerates with higher screen time (quadratic term)
  - Each hour of weekly physical activity decreases BMI z-score by 0.08
  - Each hour of sleep decreases BMI z-score by 0.12
]

#section-slide("Looking Forward")

#bips-slide(title: "Advanced Methods", text-size: 15pt)[
  === Machine Learning Integration
  - *Ensemble methods*: Random forests, gradient boosting
  - *Neural networks*: Deep learning for complex patterns
  - *Causal inference*: Propensity scores, instrumental variables

  === Big Data Challenges
  - *High-dimensional data*: p >> n problems
  - *Streaming data*: Online learning algorithms
  - *Heterogeneous data*: Multi-modal integration

  === Bayesian Approaches
  - Prior information incorporation
  - Uncertainty quantification
  - Hierarchical modeling
]

#bips-slide(title: "Reproducible Research", subtitle: "Modern Statistical Practice", text-size: 16pt)[
  #two-columns[
    *Version Control:*
    - Git for code/documentation
    - Track changes systematically
    - Effective collaboration

    *Literate Programming:*
    - R Markdown/Jupyter notebooks
    - Code + results + narrative
  ][
    *Open Science:*
    - Share code and data
    - Preregistration
    - Transparent reporting
  ]

  #callout(type: "tip")[
    Start good habits early!
  ]
]

#bips-slide(title: "Course Summary", subtitle: "Key Concepts & Next Steps", text-size: 16pt)[
  #two-columns[
    *Concepts Mastered:*
    - Linear & generalized linear models
    - Model diagnostics & validation
    - Categorical predictors
    - Software implementation
    - Reproducible research

    *Skills Developed:*
    - Problem formulation
    - Model selection & checking
    - Result interpretation
  ][
    *Next Steps:*
    - Advanced courses (survival, Bayesian)
    - Real-world practice
    - Statistical consulting

    *Career Opportunities:*
    - Data scientist
    - Biostatistician
    - Research analyst
  ]
]

#thanks-slide(
  thanks-text: "Thank you for your attention!",
  contact-author: "Prof. Dr. Schlau",
  email: "example@leibniz-bips.de",
)

// Final slide count: 100 slides (including title and thanks slide)
// This demonstrates the BIPS theme performance with lecture-length content
