accessing
card: aMgCard
	card := aMgCard.
	card announcer when: MgCardFlippedAnnouncement send: #onFlipped to: self.
	card announcer when: MgCardDisappearAnnouncement send: #onDisappear to: self