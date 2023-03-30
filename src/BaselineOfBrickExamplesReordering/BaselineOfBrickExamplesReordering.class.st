Class {
	#name : #BaselineOfBrickExamplesReordering,
	#superclass : #BaselineOf,
	#category : #BaselineOfBrickExamplesReordering
}

{ #category : #baselines }
BaselineOfBrickExamplesReordering >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: 'Brick'
			with: [ spec repository: 'github://pharo-graphics/Brick:dev-1.0/src' ].
		spec
			package: #'Brick-Examples-Reordering' with: [
				spec requires: #( #Brick ) ];
			package: #'Brick-Examples-Reordering-Tests' with: [
				spec requires: #( #'Brick-Examples-Reordering' ) ]
		]


]
