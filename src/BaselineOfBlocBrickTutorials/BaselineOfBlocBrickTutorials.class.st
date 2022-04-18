Class {
	#name : #BaselineOfBlocBrickTutorials,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocBrickTutorials
}

{ #category : #baselines }
BaselineOfBlocBrickTutorials >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: 'Memory'
			with: [ spec repository: 'github://pharo-graphics/Tutorials:dev-1.0/src' ].
		spec
			baseline: 'BrickExamplesReordering'
			with: [ spec repository: 'github://pharo-graphics/Tutorials:dev-1.0/src' ] ]

]
