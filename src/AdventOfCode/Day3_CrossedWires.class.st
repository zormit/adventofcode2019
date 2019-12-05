Class {
	#name : #'Day3_CrossedWires',
	#superclass : #Object,
	#instVars : [
		'wireA',
		'wireB',
		'amount'
	],
	#category : #AdventOfCode
}

{ #category : #running }
Day3_CrossedWires class >> run: paths [ 
	| runner wires|
	runner := self new.
	wires := paths substrings.
	runner wireA: ((wires at: 1) substrings: #,).
	runner wireB: ((wires at: 2) substrings: #,).
	^ runner computeResult.
]

{ #category : #running }
Day3_CrossedWires class >> run_2: paths [ 
	| runner wires|
	runner := self new.
	wires := paths substrings.
	runner wireA: ((wires at: 1) substrings: #,).
	runner wireB: ((wires at: 2) substrings: #,).
	^ runner computeResult_2.
]

{ #category : #computing }
Day3_CrossedWires >> computeResult [
	| occupiedCoordinates direction currentPosition overlappingCoordinates aBlock bBlock |
	occupiedCoordinates := Set new.
	currentPosition := 0 @ 0.
	aBlock := [ :by | 
	amount
		timesRepeat: [ currentPosition := currentPosition translateBy: by.
			occupiedCoordinates add: currentPosition copy ] ].
	self wireA
		do: [ :instruction | 
			direction := instruction at: 1.
			amount := instruction allButFirst asInteger.
			direction = $R
				ifTrue: [ aBlock value: 1 @ 0 ].
			direction = $L
				ifTrue: [ aBlock value: -1 @ 0 ].
			direction = $U
				ifTrue: [ aBlock value: 0 @ 1 ].
			direction = $D
				ifTrue: [ aBlock value: 0 @ -1 ] ].
	currentPosition := 0 @ 0.
	overlappingCoordinates := Set new.
	bBlock := [ :by | amount
		timesRepeat: [ currentPosition := currentPosition translateBy: by.
			(occupiedCoordinates includes: currentPosition)
				ifTrue: [ overlappingCoordinates add: currentPosition copy ] ] ].
	self wireB
		do: [ :instruction | 
			direction := instruction at: 1.
			amount := instruction allButFirst asInteger.
			direction = $R
				ifTrue: [ bBlock value: 1 @ 0 ].
			direction = $L
				ifTrue: [ bBlock value: -1 @ 0 ].
			direction = $U
				ifTrue: [ bBlock value: 0 @ 1 ].
			direction = $D
				ifTrue: [ bBlock value: 0 @ -1 ] ].
	^ (overlappingCoordinates collect: [ :p | p x abs + p y abs ]) min
]

{ #category : #computing }
Day3_CrossedWires >> computeResult_2 [
	| occupiedCoordinates direction currentPosition overlappingCoordinates coordinateSteps overlappingCoordinateSteps aBlock bBlock steps |
	occupiedCoordinates := Set new.
	coordinateSteps := Dictionary new.
	currentPosition := 0 @ 0.
	steps := 1.
	aBlock := [ :by | 
	amount
		timesRepeat: [ currentPosition := currentPosition translateBy: by.
			occupiedCoordinates add: currentPosition copy.
			coordinateSteps at: currentPosition put: steps.
			steps := steps + 1 ] ].
	self wireA
		do: [ :instruction | 
			direction := instruction at: 1.
			amount := instruction allButFirst asInteger.
			direction = $R
				ifTrue: [ aBlock value: 1 @ 0 ].
			direction = $L
				ifTrue: [ aBlock value: -1 @ 0 ].
			direction = $U
				ifTrue: [ aBlock value: 0 @ 1 ].
			direction = $D
				ifTrue: [ aBlock value: 0 @ -1 ] ].
	currentPosition := 0 @ 0.
	overlappingCoordinates := Set new.
	overlappingCoordinateSteps := Dictionary new.
	steps := 1.
	bBlock := [ :by | 
	amount
		timesRepeat: [ currentPosition := currentPosition translateBy: by.
			(occupiedCoordinates includes: currentPosition)
				ifTrue: [ overlappingCoordinates add: currentPosition copy.
					overlappingCoordinateSteps
						at: currentPosition
						put: (coordinateSteps at: currentPosition) + steps.
					].steps := steps + 1 ] ].
	self wireB
		do: [ :instruction | 
			direction := instruction at: 1.
			amount := instruction allButFirst asInteger.
			direction = $R
				ifTrue: [ bBlock value: 1 @ 0 ].
			direction = $L
				ifTrue: [ bBlock value: -1 @ 0 ].
			direction = $U
				ifTrue: [ bBlock value: 0 @ 1 ].
			direction = $D
				ifTrue: [ bBlock value: 0 @ -1 ] ].
	^ overlappingCoordinateSteps values min
]

{ #category : #accessing }
Day3_CrossedWires >> wireA [
	^ wireA
]

{ #category : #accessing }
Day3_CrossedWires >> wireA: anObject [
	wireA := anObject
]

{ #category : #accessing }
Day3_CrossedWires >> wireB [
	^ wireB
]

{ #category : #accessing }
Day3_CrossedWires >> wireB: anObject [
	wireB := anObject
]
