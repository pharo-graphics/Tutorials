gt-inspector
gtInspectorCardIn: aComposite
	<gtInspectorPresentationOrder: 1>
	
	self card ifNotNil: [ :aCardModel | aCardModel gtInspectorCardIn: aComposite ]