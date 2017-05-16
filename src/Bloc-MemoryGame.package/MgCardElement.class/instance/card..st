accessing
card: aMgCard
	card := aMgCard.
	card announcer when: MgCardFlippedAnnouncement send: #onFlipped to: self
	
	"self background: (BlBackground new fill: Color )"