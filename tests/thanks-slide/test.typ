// Test: thanks-slide with various configurations
#import "/bips-typst.typ": *
#show: bips-theme
#title-slide(title: "Test")

#thanks-slide(
  thanks-text: "Thank you!",
  contact-author: "Dr. Jane Doe",
  email: "jane@example.com",
)

#thanks-slide(
  thanks-text: "Thanks for listening!",
  contact-author: "John Smith",
  email: "john@example.com",
  qr-url: "https://example.com",
)
