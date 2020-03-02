%% =============================================================================
%%
%%  CONCORDIA UNIVERSITY
%%  Department of Computer Science and Software Engineering
%%  SOEN 331-S:  Assignment 2
%%  Winter term, 2020
%%  Date submitted: 2020/03/03
%%
%%  Authors: 
%%
%%  Gordon Pham-Nguyen, 40018402, gordon.pn6@gmail.com
%%  name2, id2, email2 
%%  ...
%%
%% =============================================================================

%% =============================================================================
%%
%%  Facts
%% 
%% state(S)
%% initial state(S1, S2) indicates that S2 is the initial state of S1
%% superstate(S1, S2) implies that S1 is the superstate of S2
%% transition(Source, Destination, Event, Guard, Action)
%% 
%% =============================================================================

%% Top-level states
state(parked).
state(manual).
state(cruise).
state(panic).
state(exit).

%% States under Manual state
state('manual driving').
state(break).

%% States under Cruise state
state(cruising).
state(tailing).
state('changing lane').

%% States under Cruising state
state(navigating).

%% States under Changing Lane state
state('merging lane').

%% Initial states
initial_state(parked, null).
initial_state(manual, 'manual driving').
initial_state(cruise, cruising).
initial_state(cruising, navigating).
initial_state('changing lane', 'merging lane').

%% Superstates
superstate(manual, 'manual driving').
superstate(manual, break).
superstate(cruise, cruising).
superstate(cruise, tailing).
superstate(cruise, 'changing lane').
superstate(cruising, navigating).
superstate('changing lane', 'merging lane').

%% Transitions within the top-level
transition(parked, exit, 'shut off', null, null).
transition(parked, parked, 'cruise signal', 'destination is not set', beep).
transition(parked, manual, 'drive signal', null, null).
transition(parked, cruise, 'cruise signal', 'destination is set', null).
transition(manual, parked, 'parked signal', 'car is stopped', null).
transition(manual, manual, 'cruise signal', 'destination is not set', beep).
transition(manual, cruise, 'cruise signal', 'destination is set', null).
transition(cruise, parked, 'car arrived at destination', null, null).
transition(cruise, manual, 'manual signal', null, null).
transition(cruise, panic, 'unforeseen event', null, 'stop car; hazard lights on').
transition(panic, parked, 'panic mode off', null, 'hazard lights off').

%% Transitions within the Manual state
transition('manual driving', 'manual driving', 'accelerate signal', null, 'faster engine').
transition('manual driving', 'manual driving', 'reduce signal', null, 'slower engine').
transition('manual driving', break, 'break signal', null, 'zero speed').
transition(break, 'manual driving', 'accelerate signal', null, null).

%% Transitions within the Cruise state
transition(cruising, tailing, 'car detected ahead', 'distance is under threshold', 'reduce speed').
transition(cruising, 'changing lane', 'any change lane signal', null, null).
transition(tailing, tailing, 'after 1 second', 'distance is under threshold', 'reduce speed').
transition(tailing, cruising, 'after 1 second', 'distance is above or at threshold', 'maintain current speed').
transition(tailing, 'changing lane', 'after 1 second', 'obstacle not moving or safe distance cannot be maintained', 'change to left lane signal').
transition('changing lane', cruising, 'target lane signal', null, null).
transition('changing lane', cruising, 'panic signal', null, 'panic signal').

%% Transitions within the Cruising state
transition(navigating, navigating, 'after 1 second', 'current speed =< road speed - 5%', 'accelerate signal; increase speed').
transition(navigating, navigating, 'after 1 second', 'current speed > road speed +5%', 'reduce speed signal; decrease speed').
transition(navigating, navigating, 'after 1 second', 'car arrived at destination', 'car arrived at destination signal').
transition(navigating, navigating, 'after 1 second', 'turn right', 'turn right at next intersection').
transition(navigating, navigating, 'after 1 second', 'turn left', 'turn left at next intersection').
transition(navigating, navigating, 'after 1 second', 'destination ahead', 'change to right-most lane signal').
transition(navigating, navigating, 'after 1 second', 'right turn ahead', 'change to right-most lane signal').
transition(navigating, navigating, 'after 1 second', 'left turn ahead', 'change to left-most lane signal').

%% Transitions within the Changing Lane state
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change right lane && right lane is open', 'change to right lane; target lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change right lane && right lane is not open', 'change right lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change left lane && left lane is open', 'change to left lane; target lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change left lane && left lane is not open', 'change left lane signal').
transition('merging lane', 'merging lane', 'after 1 second && (obstacle ahead or cannot change lane)', null, 'panic signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to right-most lane && Lanes == 1 && right lane is open', 'change to right lane; target lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to right-most lane && Lanes == 1 && right lane is not open', 'change to right lane; target lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to right-most lane && Lanes > 1 && right lane is open', 'change to right lane; Lanes--; change to right-most lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to right-most lane && Lanes > 1 && right lane is not open', 'change to right-most lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to left-most lane && Lanes == 1 && left lane is open', 'change to left lane; target lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to left-most lane && Lanes == 1 && left lane is not open', 'change to left lane; target lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to left-most lane && Lanes > 1 && left lane is open', 'change to left lane; Lanes--; change to left-most lane signal').
transition('merging lane', 'merging lane', 'after 1 second', 'Signal == change to left-most lane && Lanes > 1 && left lane is not open', 'chang~e to left-most lane signal').

%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================

transition(Source, Target) :- 
    transition(Source, Target, Event, Guard, Action), 
    write("Event = "), write(Event), nl, 
    write("Guard = "), write(Guard), nl, 
    write("Action = "), write(Action), nl, !.
transition(Source, Target) :- 
    transition(Node, Target, Event, Guard, Action),
    write("Event = "), write(Event), nl, 
    write("Guard = "), write(Guard), nl, 
    write("Action = "), write(Action), nl, 
    transition(Source, Node).

interface(PairsSet) :- findall({State, Event}, transition(State, _, Event, _, _), PairsList), list_to_set(PairsList, PairsSet).
% set_prolog_flag(answer_write_options, [quoted(true), portray(true), spacing(next_argument)]).
% the previous line allows prolog to print the entire list instead of a truncated list

%% eof.