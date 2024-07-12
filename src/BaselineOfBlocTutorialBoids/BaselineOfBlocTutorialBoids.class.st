Class {
	#name : #BaselineOfBlocTutorialBoids,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocTutorialBoids
}

{ #category : #baselines }
BaselineOfBlocTutorialBoids >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: #'Bloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:master/src' ].
		spec
			package: #'BlocTutorials-Boids'
			with: [ spec requires: #( #'Bloc' ) ].
		spec
			package: #'BlocTutorials-Boids-Tests'
			with: [ spec requires: #( #'BlocTutorials-Boids' ) ]
		]
]
