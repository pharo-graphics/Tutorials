accessing
card: aMgCard
	card := aMgCard.
	card announcer when: MgdCardFlippedAnnouncement send: #onFlipped to: self.
	card announcer when: MgdCardDisappearAnnouncement send: #onDisappear to: self