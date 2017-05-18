notifying
notifyFlipped
	"Notify all observers that my flipped state was changed (from flipped to not or the other way around)"
	self announcer announce: MgCardFlippedAnnouncement new