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
%% initial_state(S1, S2) indicates that S2 is the initial state of S1
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
state(manual_driving).
state(break).

%% States under Cruise state
state(cruising).
state(tailing).
state(changing_lane).

%% States under Cruising state
state(navigating).

%% States under Changing Lane state
state(merging_lane).

%% Initial states
initial_state(parked, null).
initial_state(manual, manual_driving).
initial_state(cruise, cruising).
initial_state(cruising, navigating).
initial_state(changing_lane, merging_lane).

%% Superstates
superstate(manual, manual_driving).
superstate(manual, break).
superstate(cruise, cruising).
superstate(cruise, tailing).
superstate(cruise, changing_lane).
superstate(cruising, navigating).
superstate(changing_lane, merging_lane).

%% Transitions within the top-level
transition(parked, exit, shut_off, null, null).
transition(parked, parked, cruise_signal, destination_is_not_set, beep).
transition(parked, manual, drive_signal, null, null).
transition(parked, cruise, cruise_signal, destination_is_set, null).
transition(manual, parked, parked_signal, car_is_stopped, null).
transition(manual, manual, cruise_signal, destination_is_not_set, beep).
transition(manual, cruise, cruise_signal, destination_is_set, null).
transition(cruise, parked, car_arrived_at_destination, null, null).
transition(cruise, manual, manual_signal, null, null).
transition(cruise, panic, unforeseen_event, null, stop_car_and_hazard_lights_on).
transition(panic, parked, panic_mode_off, null, hazard_lights_off).

%% Transitions within the Manual state
%% Transitions within the Cruise state
%% Transitions within the Cruising state
%% Transitions within the Changing Lane state

%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================


%% eof.