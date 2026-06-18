// Test: config-info(...) passthrough drives the title slide + PDF metadata,
// and arbitrary Touying config dicts forward through bips-theme's ..args.
#import "/bypst.typ": *
#show: bips-theme.with(
  config-info(
    title: [Talk From Info],
    subtitle: [Subtitle From Info],
    author: [Jane Doe],
    institution: [BIPS],
    date: [2026-06-15],
  ),
  // arbitrary config-common knob forwarded via ..args
  config-common(enable-pdfpc: false),
)

// No explicit args: fields fall back to config-info above
#title-slide()

// Explicit args still override config-info
#title-slide(title: "Explicit Override", author: "Someone Else")

#bips-slide(title: "Content")[Body]
