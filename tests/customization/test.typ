// Test: per-slide and global customization
#import "/bypst.typ": *
#show: bips-theme

#title-slide(title: "Test")

// Per-slide text size override
#bips-slide(title: "Small Text", text-size: 14pt)[
  This slide uses 14pt text.
]

// Per-slide title size override
#bips-slide(title: "Big Title", title-size: 36pt)[
  The title above should be 36pt.
]

// Per-slide code scale override
#bips-slide(title: "Code Scale", code-block-scale: 0.7)[
  ```python
  def hello():
      print("world")
  ```
]
