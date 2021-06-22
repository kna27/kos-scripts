//Pre-launch
print ("'hawk-mk1' successfully loaded.").
wait 0.75.
print ("Hawk MkI flight.").
wait 0.75.
print("If timewarp does not automatically begin within five seconds of liftoff, click outside of the terminal.").
wait 0.75.
print("All systems are norminal, safe to launch.").
wait 0.75.
print("Press 'control + c' at any time to abort program.").
wait 0.75.
print ("5...").
wait 1.
SET HAWK TO SHIP.
print ("4...").
wait 1.
print ("3...").
wait 1.
print ("2...").
wait 1.
lock throttle to 0.7.
print ("1...").
wait 1.
doSafeStage().
print("Liftoff!").
//Ascent
lock steering to UP.
wait 1.
warpmax().
wait until ship:altitude >= 5000.
lock throttle to 0.6.
wait until ship:altitude >= 8000.
print("Gravity turn").
lock steering to heading(90, 82.5).
lock throttle to 0.55.
wait until ship:altitude >= 12500.
lock steering to heading(90,75).
lock throttle to 0.4.
wait until ship:altitude >= 15000.
lock throttle to 0.35.
lock steering to heading(90, 70).
wait until ship:altitude >= 20000.
lock steering to heading(90, 60).
wait until STAGE:liquidfuel <= 425.
lock throttle to 0.2.
wait until STAGE:liquidfuel <= 420.
set kuniverse:timewarp:warp to 0.
lock throttle to 0.
unlock throttle.
print("Ready to stage.").
doSafeStage().
wait 0.25. 
SET STAGE2 TO VESSEL("Hawk Mk I").
print("S1 - Successful staging.").
//Landing
wait 1.
RCS ON.
lock steering to heading(270, 0).
wait 6.
print("S1 - Boostback Burn").
wait 1.
print("S1 - Adjusting Longitude").
KUniverse:FORCESETACTIVEVESSEL(SHIP).
lock throttle to 1.
wait until addons:tr:impactpos:lng < -73.
lock throttle to 0.25.
wait until addons:tr:impactpos:lng < -74.
lock throttle to 0.1.
//nice
wait until addons:tr:impactpos:lng < -74.6.
lock throttle to 0.
print("S1 - Adjusting Latitude").
SET COMPLETE TO 0.
if addons:tr:impactpos:lat <= -0.05{
lock steering to heading(360,0).
wait 7.
lock throttle to 0.02.
wait until addons:tr:impactpos:lat > -0.05.
SET COMPLETE TO 1.
}
if addons:tr:impactpos:lat > -0.05085 AND COMPLETE = 0{
lock steering to heading(180,0).
wait 7.
lock throttle to 0.02.
wait until addons:tr:impactpos:lat <= -0.05.
}
lock throttle to 0.
RCS OFF.
wait 0.1.
print("S1 - Crusing back to the KSC.").
warpmax().
lock steering to ship:srfretrograde.
LOCK STEERING TO (-1) * SHIP:VELOCITY:SURFACE.
wait 7.
RCS ON.
SET LANDED TO FALSE.
SET t TO 0.0.
WAIT UNTIL SHIP:ALTITUDE < 1000.
set kuniverse:timewarp:warp to 0.
WAIT UNTIL SHIP:ALTITUDE < 651.
KUniverse:FORCESETACTIVEVESSEL(SHIP).
WHEN SHIP:ALTITUDE < 650 AND SHIP:VELOCITY:SURFACE:MAG > 10 AND NOT LANDED THEN
{
  print("S1 - Suicide Burn").
	SET t TO 1.0.
  GEAR ON.
}

WHEN SHIP:VELOCITY:SURFACE:MAG < 10 AND NOT LANDED THEN
{
    LOCK STEERING TO HEADING(90, 90).
	SET t TO (1 * ((9.81 * SHIP:MASS) / SHIP:MAXTHRUST)).
	PRESERVE.
}
LOCK THROTTLE TO t.

WHEN SHIP:STATUS = "LANDED" THEN
{
	SET LANDED TO TRUE.
}
BRAKES ON.
WAIT UNTIL LANDED.
print("S1 - Landing Successful").
KUniverse:FORCESETACTIVEVESSEL(STAGE2).

//functions

function doSafeStage {
  wait until stage:ready.
  stage.
}

function warpmax{
  set kuniverse:timewarp:warp to 5.
  wait 1.
  until kuniverse:timewarp:warp = 3{ 
    set kuniverse:timewarp:warp to 5.
    wait 1.
  }
}
