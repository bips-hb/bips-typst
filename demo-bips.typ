#import "bips-theme.typ": *

#show: bips-theme

// ============================================================================
// BIPS PRESENTATION DEMO
// ============================================================================
//
// This demo shows the essential features you'll need for most presentations.
// Copy this file and customize it for your own talks!

#title-slide(
  title: "Your Research Project",
  subtitle: "Findings and Implications",
  author: "Your Name",
  institute: "BIPS",
  date: "December 2024",
  occasion: "Department Meeting", // Optional - remove if not needed
)

#bips-slide(title: "Introduction")[
  Welcome to your BIPS presentation! This template gives you:

  - *Professional BIPS branding* - colors, fonts, logo
  - *Fast compilation* - no more waiting for LaTeX
  - *Simple syntax* - much easier than Beamer
  - *Beautiful math* - $ E = m c^2 $ just works

  Perfect for conference talks, seminars, and research presentations.
]

#bips-slide(
  title: "Study Overview",
  subtitle: "Research design and objectives"
)[
  === Objectives
  - Investigate relationship between X and Y
  - Assess impact of intervention Z
  - Evaluate long-term outcomes

  === Methods
  - Randomized controlled trial
  - n = 500 participants
  - 12-month follow-up period

  #callout(type: "note")[
    Ethics approval obtained from institutional review board
  ]
]

#section-slide[Results]

#bips-slide(title: "Key Findings")[
  #two-columns[
    === Primary Outcome
    - Significant effect found
    - p < 0.001 (95% CI: 0.2-0.8)
    - Effect size: Cohen's d = 0.65

    === Secondary Outcomes
    - Improved quality of life
    - Reduced healthcare utilization
    - High participant satisfaction
  ][
    === Statistical Analysis
    We used standard regression models:

    $ y_i = beta_0 + beta_1 x_i + epsilon_i $

    Where:
    - $y_i$ = outcome for participant $i$
    - $x_i$ = treatment indicator
    - $epsilon_i$ = random error term

    #callout(type: "tip")[
      All analyses performed in R with significance at α = 0.05
    ]
  ]
]

#bips-slide(title: "Step-by-Step Results")[
  Let's walk through the main finding:

  First, we see a clear baseline difference:
  - Control group: 45.2 ± 8.1
  - Treatment group: 44.8 ± 7.9

  #pause

  After 6 months, we observe:
  - Control group: 46.1 ± 8.3 (minimal change)
  - Treatment group: 52.7 ± 6.2 (*significant improvement*)

  #pause

  At 12 months, the effect persists:
  - Control group: 45.8 ± 8.5
  - Treatment group: 54.1 ± 5.8

  #callout(type: "important")[
    Sustained improvement demonstrates intervention effectiveness
  ]
]

#bips-slide(title: "Limitations")[
  This study has several limitations:

  #callout(type: "warning", title: "Study Limitations")[
    - Single-center design limits generalizability
    - 15% dropout rate, though comparable across groups
    - Follow-up limited to 12 months
    - Self-reported outcomes may introduce bias
  ]

  === Future Research
  - Multi-center replication study planned
  - Extended follow-up (24-month) study approved
  - Cost-effectiveness analysis in progress
]

#section-slide[Conclusion]

#bips-slide(title: "Take-Home Messages")[
  === What We Found
  1. Intervention shows *strong, sustained effects*
  2. Benefits persist at 12-month follow-up
  3. Effect size is clinically meaningful
  4. Implementation appears feasible in practice

  === Clinical Implications
  - #green[Ready for broader implementation]
  - #blue[Training protocols developed]
  - #orange[Cost-benefit analysis favorable]

  === Next Steps
  - Prepare results for publication
  - Apply for implementation funding
  - Develop practitioner guidelines
]

#thanks-slide(
  contact-author: "Your Name",
  email: "your.email@leibniz-bips.de",
  // qr-url: "https://your-presentation-url.com", // Uncomment to add QR code
)