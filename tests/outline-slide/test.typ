// Test: outline-slide lists section slides with their first slide number
#import "/bypst.typ": *
#show: bips-theme

#outline-slide()
#outline-slide(title: "Agenda")

#section-slide("Introduction")
#bips-slide(title: "A")[a #pause b]
#section-slide(
  "A longer section title that is likely to wrap onto a second line",
)
#bips-slide(title: "B")[b]
