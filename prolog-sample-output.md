# Driverless car system sample output

```prolog
?- transition(parked, panic).
Event = unforeseen event
Guard = null
Action = stop car; hazard lights on
Event = cruise signal
Guard = destination is set
Action = null
true.

?- set_prolog_flag(answer_write_options, [quoted(true), portray(true), spacing(next_argument)]).
true.

?- interface(PairsSet).
PairsSet = [{parked, 'shut off'}, {parked, 'cruise signal'}, {parked, 'drive signal'}, {manual, 'parked signal'}, {manual, 'cruise signal'}, {cruise, 'car arrived at destination'}, {cruise, 'manual signal'}, {cruise, 'unforeseen event'}, {panic, 'panic mode off'}, {'manual driving', 'accelerate signal'}, {'manual driving', 'reduce signal'}, {'manual driving', 'break signal'}, {break, 'accelerate signal'}, {cruising, 'car detected ahead'}, {cruising, 'any change lane signal'}, {tailing, 'after 1 second'}, {'changing lane', 'target lane signal'}, {'changing lane', 'panic signal'}, {navigating, 'after 1 second'}, {'merging lane', 'after 1 second'}].
```
