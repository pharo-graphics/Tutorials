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
			baseline: 'NewBrick'
			with: [ spec repository: 'github://pharo-graphics/Brick/src' ].
		spec
			package: #'Brick-Examples-Reordering' with: [
				spec requires: #( #NewBrick ) ] ]

]
