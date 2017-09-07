gt-inspector
gtInspectorCardIn: aComposite
	<gtInspectorPresentationOrder: 1>
	
	aComposite fastTable 
		title: 'Card' translated;
		display: [ {
			#Symbol: -> self symbol printString.
			#'Visible side:' -> (self isFlipped ifTrue: [ 'Face' ] ifFalse: [ 'Back' ])
		} ];
		column: 'Name' evaluated: [ :each | each key ];
		column: 'Value' evaluated: [ :each | each value ]