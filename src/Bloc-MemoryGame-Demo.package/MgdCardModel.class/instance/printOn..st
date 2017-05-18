printing
printOn: aStream
	aStream
		nextPutAll: 'Card';
		nextPut: Character space;
		nextPut: $(;
		nextPutAll: self symbol asString;
		nextPut: $)