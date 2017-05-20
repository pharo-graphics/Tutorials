printing
printOn: aStream
	aStream
		nextPutAll: 'Card';
		nextPut: Character space;
		nextPut: $(;
		nextPut: self symbol;
		nextPut: $)