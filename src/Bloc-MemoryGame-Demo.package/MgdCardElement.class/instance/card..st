accessing
card: aMgdCardModel
	"Attach a card model and subscribe to its announcements.
	aMgdCardModel must not be nil"
	
	self
		assert: [ aMgdCardModel isNotNil ]
		description: [ 'Card model must not be nil' ].
	
	card := aMgdCardModel.

	card announcer when: MgdCardFlippedAnnouncement send: #onFlipped to: self.
	card announcer when: MgdCardDisappearAnnouncement send: #onDisappear to: self