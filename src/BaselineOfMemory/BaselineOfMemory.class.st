Class {
	#name : #BaselineOfMemory,
	#superclass : #BaselineOf,
	#category : #BaselineOfMemory
}

{ #category : #baselines }
BaselineOfMemory >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'NewBloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc/src' ].
		spec package: #'Bloc-Memory' with: [ spec requires: #( #NewBloc ) ] ]
]
