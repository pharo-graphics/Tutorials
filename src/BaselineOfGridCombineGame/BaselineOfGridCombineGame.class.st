"
I'm a baseline to load a Bloc demo that consists on a game. This game is a generalization of a well-known game called 2048.

Check comment of `GCGame` for more information.
"
Class {
	#name : #BaselineOfGridCombineGame,
	#superclass : #BaselineOf,
	#category : #BaselineOfGridCombineGame
}

{ #category : #baselines }
BaselineOfGridCombineGame >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: #'BlocPac'
			with: [ spec repository: 'github://pharo-graphics/bloc-pac:dev-1.0/src' ].
		spec
			package: #'Bloc-GridCombineGame';
			package: #'Bloc-GridCombineGame-Tests' with: [
				spec requires: #( #'Bloc-GridCombineGame' ) ];
			package: #'Bloc-GridCombineGame-UI' with: [
				spec requires: #( #'Bloc-GridCombineGame' #'BlocPac' ) ]
		]

]
