Class {
	#name : #'Day5_SunnyAsteroids',
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #AdventOfCode
}

{ #category : #running }
Day5_SunnyAsteroids class >> run: program [ 
	| runner |
	runner := self new.
	runner state: program.
	^ runner computeResult.
]

{ #category : #run }
Day5_SunnyAsteroids >> computeResult [
	| step |
	step := 1.
	[ (self state at: step) = 99 ]
		whileFalse: [ | opcode modes stepsize |
			opcode := (self state at: step) % 100.
			modes := (self state at: step) // 100.
			opcode = 1
				ifTrue: [ self doAdd: step modes: modes.
					stepsize := 4 ]
				ifFalse: [ opcode = 2
						ifTrue: [ self doMultiply: step modes: modes.
							stepsize := 4 ]
						ifFalse: [ opcode = 3
								ifTrue: [ self doRead: step modes: modes.
									stepsize := 2 ]
								ifFalse: [ opcode = 4
										ifTrue: [ self doWrite: step modes: modes.
											stepsize := 2 ]
										ifFalse: [ self halt ] ] ] ].
			step := step + stepsize ].
	^ self state
]

{ #category : #computation }
Day5_SunnyAsteroids >> doAdd: step modes: modes [
	| result v1 v2 |
	v1 := (modes%10) >= 1
		ifTrue: [ self getImmediateAt: step + 1 ]
		ifFalse: [ self getValueAt: step + 1 ].
	v2 := (modes%100) >= 10
		ifTrue: [ self getImmediateAt: step + 2 ]
		ifFalse: [ self getValueAt: step + 2 ].
	result := v1 + v2.
	self writeAt: step + 3 value: result
]

{ #category : #computation }
Day5_SunnyAsteroids >> doMultiply: step modes: modes [
	| result v1 v2 |
	v1 := (modes%10) >= 1
		ifTrue: [ self getImmediateAt: step + 1 ]
		ifFalse: [ self getValueAt: step + 1 ].
	v2 := (modes%100) >= 10
		ifTrue: [ self getImmediateAt: step + 2 ]
		ifFalse: [ self getValueAt: step + 2 ].
	result := v1*v2.
	self writeAt:(step+3) value:result.
]

{ #category : #'as yet unclassified' }
Day5_SunnyAsteroids >> doRead: step modes: modes [ 
	
	modes = 0 ifTrue: [ |param1|
		self writeAt: step + 1 value: 1."input" 
		 ] ifFalse: [ self halt. "should not happen" ]
]

{ #category : #'as yet unclassified' }
Day5_SunnyAsteroids >> doWrite: step modes: modes [ 
	modes = 0 ifTrue: [ Transcript crShow: (self getValueAt: (step+1))] ifFalse: [ Transcript crShow: (self getImmediateAt: (step+1)) ]
]

{ #category : #accessing }
Day5_SunnyAsteroids >> getImmediateAt: position [ 
	^ self state at: position.
]

{ #category : #accessing }
Day5_SunnyAsteroids >> getValueAt: position [ 
	^ self state at: (self state at: position)+1.
]

{ #category : #setup }
Day5_SunnyAsteroids >> readProgram: program [ 
	self state: ((program substrings: ',') collect: [ :n | n asInteger  ]).
]

{ #category : #accessing }
Day5_SunnyAsteroids >> state [
	^ state
]

{ #category : #accessing }
Day5_SunnyAsteroids >> state: anArray [
	state := anArray
]

{ #category : #writing }
Day5_SunnyAsteroids >> writeAt: position value: value [ 
	self state at: (state at: position)+1 put: value
]
