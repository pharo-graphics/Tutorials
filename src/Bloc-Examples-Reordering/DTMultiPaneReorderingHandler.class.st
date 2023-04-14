"
In planning boards, we want to drag and drop tasks from one pane to another. This event handler supports that. The container is the space where the dragging and dropping is to happen, the panes are the elements that contain tasks
"
Class {
	#name : #DTMultiPaneReorderingHandler,
	#superclass : #DTReorderingHandler,
	#instVars : [
		'container',
		'panes'
	],
	#category : #'Bloc-Examples-Reordering'
}
