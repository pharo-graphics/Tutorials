accessing
cardType
	^ cardType ifNil: [ cardType := MgRawCardElement ]