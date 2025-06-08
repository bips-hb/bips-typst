#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#title-slide(
  title: "QR Code Integration Demo",
  subtitle: "Sharing presentations made easy",
  author: "Presenter Name",
  institute: "BIPS",
  date: datetime.today().display(),
)

#bips-slide(
  title: "QR Code Feature",
  subtitle: "Modern presentation sharing",
)[
  The BIPS theme includes built-in QR code generation:

  - Automatically generated on thanks slides
  - Links directly to your presentation
  - Styled with BIPS blue colors
  - Clean integration with existing layout

  Perfect for conferences and workshops where audience members want quick access to slides!
]

#bips-slide(title: "How It Works")[
  Add a `qr-url` parameter to your thanks slide:

  ```typst
  #thanks-slide(
    contact-author: "Your Name",
    email: "your.email@leibniz-bips.de",
    qr-url: "https://your-slides-url.com",
  )
  ```

  The QR code will automatically appear in the center of the slide, making it easy for your audience to access the presentation materials.
]

#thanks-slide(
  thanks-text: "Scan to access slides!",
  contact-author: "Demo Author",
  email: "demo@leibniz-bips.de",
  qr-url: "https://github.com/bips-hb/bips-typst",
)
