#import "@local/bips-typst:0.1.0": *

#show: bips-theme

#bips-slide(title: "Animation Test 1")[
  First point appears immediately.
  
  #pause
  
  Second point appears after pause.
  
  #pause
  
  Third point appears after second pause.
]

#bips-slide(title: "Animation Test 2")[
  Testing multiple pauses:
  
  - Item 1 #pause
  - Item 2 #pause  
  - Item 3 #pause
  - Item 4
]

#bips-slide(title: "No Animation")[
  This slide has no pauses and should work normally.
]