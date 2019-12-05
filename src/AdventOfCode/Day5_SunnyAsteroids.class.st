Class {
	#name : #'Day5_SunnyAsteroids',
	#superclass : #Object,
	#instVars : [
		'state',
		'operations'
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

{ #category : #accessing }
Day5_SunnyAsteroids >> computeOperations [
	| o |
	o := Dictionary new.
	o at: 1 put: [:a :b :c | self writeValue: a + b toAddressAt: (c+1) ].
	o at: 2 put: [:a :b :c | self writeValue: a * b toAddressAt: (c+1) ].
	o at: 3 put: [:a | self writeValue: 1 toAddressAt: (a+1) ].
	o at: 4 put: [:a | Transcript crShow: a ].
	^ o
]

{ #category : #run }
Day5_SunnyAsteroids >> computeResult [
	| step |
	step := 1.
	[ (self state at: step) = 99 ]
		whileFalse: [ | opcode modes arguments operation |
			opcode := (self state at: step) % 100.
			operation := self operations at: opcode.
			modes := (self state at: step) // 100.
			opcode = 3 ifTrue: [ modes := modes + 1 ].
			(#(1 2) includes: opcode) ifTrue: [ modes := modes + 100 ].
			arguments := self
				get: operation numArgs
				argsWith: modes
				from: step + 1.
			operation valueWithArguments: arguments.
			step := step + operation numArgs + 1].
	^ self state
]

{ #category : #operation }
Day5_SunnyAsteroids >> doAdd: step modes: modes [
	| result v1 v2 |
	v1 := modes % 10 >= 1
		ifTrue: [ self getImmediateAt: step + 1 ]
		ifFalse: [ self getValueAt: step + 1 ].
	v2 := modes % 100 >= 10
		ifTrue: [ self getImmediateAt: step + 2 ]
		ifFalse: [ self getValueAt: step + 2 ].
	result := v1 + v2.
	self writeValue: result toAddressAt: step + 3
]

{ #category : #operation }
Day5_SunnyAsteroids >> doMultiply: step modes: modes [
	| result v1 v2 |
	v1 := modes % 10 >= 1
		ifTrue: [ self getImmediateAt: step + 1 ]
		ifFalse: [ self getValueAt: step + 1 ].
	v2 := modes % 100 >= 10
		ifTrue: [ self getImmediateAt: step + 2 ]
		ifFalse: [ self getValueAt: step + 2 ].
	result := v1 * v2.
	self writeValue: result toAddressAt: step + 3
]

{ #category : #operation }
Day5_SunnyAsteroids >> doRead: step modes: modes [
	modes = 0
		ifTrue: [ self writeValue: 1 toAddressAt: step + 1	"input" ]
		ifFalse: [ Exception signal: 'wrong program code?' ]
]

{ #category : #operation }
Day5_SunnyAsteroids >> doWrite: step modes: modes [
	modes = 0
		ifTrue: [ Transcript crShow: (self getValueAt: step + 1) ]
		ifFalse: [ Transcript crShow: (self getImmediateAt: step + 1) ]
]

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> get: numArgs argsWith: modes from: position [
 	| p m args |
	p := position.
	m := modes.
	args := OrderedCollection new.
	numArgs timesRepeat: [ 
		m % 10 = 1
		ifTrue: [ args add: (self getImmediateAt: p) ]
		ifFalse: [ args add: (self getValueAt: p) ].
		p := p + 1.
		m := m//10.
	].
	^ args
]

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> getImmediateAt: position [ 
	^ self state at: position.
]

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> getValueAt: position [
 	| address |
	address := (self state at: position) + 1.
	^ self state at: address.
]

{ #category : #accessing }
Day5_SunnyAsteroids >> operations [
	^ operations ifNil: [ operations:= self computeOperations ]
]

{ #category : #accessing }
Day5_SunnyAsteroids >> operations: anObject [
	operations := anObject
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

{ #category : #'state wrapper' }
Day5_SunnyAsteroids >> writeValue: value toAddressAt: address [
	self state at: address put: value
]
