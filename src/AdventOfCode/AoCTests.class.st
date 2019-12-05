"
I am holding the test cases of AoC Tasks.
"
Class {
	#name : #AoCTests,
	#superclass : #TestCase,
	#category : #'AdventOfCode-Tests'
}

{ #category : #tests }
AoCTests >> testDay2_1_ex1 [
	"1,0,0,0,99 becomes 2,0,0,0,99 (1 + 1 = 2)."

	| program result |
	program := ('1,0,0,0,99' substrings: #,)
		collect: [ :n | n asInteger ].
	result := ('2,0,0,0,99' substrings: #,) collect: [ :n | n asInteger ].
	self assert: (Day2_1202ProgramAlarm run: program) equals: result
]

{ #category : #tests }
AoCTests >> testDay2_1_ex2 [
	"2,3,0,3,99 becomes 2,3,0,6,99 (3 * 2 = 6)."

	| program result |
	program := ('2,3,0,3,99' substrings: #,)
		collect: [ :n | n asInteger ].
	result := ('2,3,0,6,99' substrings: #,) collect: [ :n | n asInteger ].
	self assert: (Day2_1202ProgramAlarm run: program) equals: result
]

{ #category : #tests }
AoCTests >> testDay2_1_ex3 [
	"2,4,4,5,99,0 becomes 2,4,4,5,99,9801 (99 * 99 = 9801)."

	| program result |
	program := ('2,4,4,5,99,0' substrings: #,)
		collect: [ :n | n asInteger ].
	result := ('2,4,4,5,99,9801' substrings: #,)
		collect: [ :n | n asInteger ].
	self assert: (Day2_1202ProgramAlarm run: program) equals: result
]

{ #category : #tests }
AoCTests >> testDay2_1_ex4 [
	"1,1,1,4,99,5,6,0,99 becomes 30,1,1,4,2,5,6,0,99."

	| program result |
	program := ('1,1,1,4,99,5,6,0,99' substrings: #,)
		collect: [ :n | n asInteger ].
	result := ('30,1,1,4,2,5,6,0,99' substrings: #,)
		collect: [ :n | n asInteger ].
	self assert: (Day2_1202ProgramAlarm run: program) equals: result
]

{ #category : #tests }
AoCTests >> testDay3_1_ex1 [
	| paths result |
	paths := 'R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83'.
	result := 159.
	self assert: (Day3_CrossedWires run: paths) equals: result
]

{ #category : #tests }
AoCTests >> testDay3_1_ex2 [
	| paths result |
	paths := 'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'.
	result := 135.
	self assert: (Day3_CrossedWires run: paths) equals: result
]

{ #category : #tests }
AoCTests >> testDay3_2_ex1 [
	| paths result |
	paths := 'R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83'.
	result := 610.
	self assert: (Day3_CrossedWires run_2: paths) equals: result
]

{ #category : #tests }
AoCTests >> testDay3_2_ex2 [
	| paths result |
	paths := 'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'.
	result := 410.
	self assert: (Day3_CrossedWires run_2: paths) equals: result
]

{ #category : #tests }
AoCTests >> testDay4_1_ex1 [
	| container |
	container := Day4_SecureContainer from: 146810 to: 612564.
	self assert: (container isValid: '111111')
]

{ #category : #tests }
AoCTests >> testDay4_1_ex2 [
	| container |
	container := Day4_SecureContainer from: 146810 to: 612564.
	self deny: (container isValid: '223450').
]

{ #category : #tests }
AoCTests >> testDay4_1_ex3 [
	| container |
	container := Day4_SecureContainer from: 146810 to: 612564.
	self deny: (container isValid: '123789')
]

{ #category : #tests }
AoCTests >> testDay4_2_ex1 [
	| container |
	container := Day4_SecureContainer from: 146810 to: 612564.
	self assert: (container isValid_2: '112233').
]

{ #category : #tests }
AoCTests >> testDay4_2_ex2 [
	| container |
	container := Day4_SecureContainer from: 146810 to: 612564.
	self deny: (container isValid_2: '123444').
]

{ #category : #tests }
AoCTests >> testDay4_2_ex3 [
	| container |
	container := Day4_SecureContainer from: 146810 to: 612564.
	self assert: (container isValid_2: '111122').
]

{ #category : #tests }
AoCTests >> testDay4_2_ex4 [
	| container |
	container := Day4_SecureContainer from: 146810 to: 612564.
	self assert: (container isValid_2: '112222').
]

{ #category : #tests }
AoCTests >> testDay5_1 [
	| result |
	result := InputRunner runDay5_1.
	self assertCollection: result allButLast hasSameElements: #(0).
	self assert: result last equals: 7692125
]

{ #category : #tests }
AoCTests >> testDay5_2_ex1 [
	| program result1 result2 |
	program := '3,9,8,9,10,9,4,9,99,-1,8'.
	program := (program substrings: #,) collect: #asInteger.
	result1 := Day5_SunnyAsteroids run: program startInput: 8.
	self assert: result1 last equals: 1.
	result2 := Day5_SunnyAsteroids run: program startInput: 5.
	self assert: result2 last equals: 0.
]

{ #category : #tests }
AoCTests >> testDay5_2_ex2 [
	| program result1 result2 result3 |
	program := '3,9,7,9,10,9,4,9,99,-1,8'.
	program := (program substrings: #,) collect: #asInteger.
	result1 := Day5_SunnyAsteroids run: program startInput: 8.
	self assert: result1 last equals: 0.
	result2 := Day5_SunnyAsteroids run: program startInput: 5.
	self assert: result2 last equals: 1.
	result3 := Day5_SunnyAsteroids run: program startInput: 15.
	self assert: result3 last equals: 0.
]

{ #category : #tests }
AoCTests >> testDay5_2_ex3 [
	| program result1 result2 |
	program := '3,3,1108,-1,8,3,4,3,99'.
	program := (program substrings: #,) collect: #asInteger.
	result1 := Day5_SunnyAsteroids run: program startInput: 8.
	self assert: result1 last equals: 1.
	result2 := Day5_SunnyAsteroids run: program startInput: 5.
	self assert: result2 last equals: 0.
]

{ #category : #tests }
AoCTests >> testDay5_2_ex4 [
	| program result1 result2 result3 |
	program := '3,3,1107,-1,8,3,4,3,99'.
	program := (program substrings: #,) collect: #asInteger.
	result1 := Day5_SunnyAsteroids run: program startInput: 8.
	self assert: result1 last equals: 0.
	result2 := Day5_SunnyAsteroids run: program startInput: 5.
	self assert: result2 last equals: 1.
	result3 := Day5_SunnyAsteroids run: program startInput: 15.
	self assert: result3 last equals: 0.
]
