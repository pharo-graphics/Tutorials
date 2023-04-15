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
			with: [ spec repository: 'github://pharo-graphics/Tutorials:dev-1.0/src' ].
		spec
			baseline: 'BlocReorderingExamples'
			with: [ spec repository: 'github://pharo-graphics/Tutorials:dev-1.0/src' ] ]

]
