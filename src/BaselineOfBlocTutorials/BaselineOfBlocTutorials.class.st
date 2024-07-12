Class {
	#name : #BaselineOfBlocTutorials,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocTutorials
}

{ #category : #baselines }
BaselineOfBlocTutorials >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: 'Memory'
			with: [ spec repository: 'github://pharo-graphics/Tutorials:master/src' ].
		spec
			baseline: 'ReorderingExamples'
			with: [ spec repository: 'github://pharo-graphics/Tutorials:master/src' ] ]

]
