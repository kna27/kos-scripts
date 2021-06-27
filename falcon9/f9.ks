lock targetApoapsis to 80000.
lock targetTWR to 2.

countdown().
ascend().
boostBack().
cruise().
land().

function countdown {
  lock throttle to 0.
  print ("F9 successfully loaded.").
  wait 0.75.
  print ("Attempting to achive " + targetApoapsis + "m orbit").
  wait 0.75.
  print("All systems are norminal, safe to launch.").
  wait 0.75.
  print("Press 'control + c' and any time to abort launch.").
  wait 0.75.

  from {local cd is 5.} until cd = 0 step {set cd to cd - 1.} do {
      print cd.
      wait 1.
  }
}

function ascend {
    lock steering to heading(90,90 * (1 - (ship:altitude / body:atm:height) ^ 0.5))+ R(0,0,270).
    lock distance to SHIP:ALTITUDE + BODY("Kerbin"):RADIUS.
    lock weight to CONSTANT():G * ((SHIP:MASS* BODY("Kerbin"):MASS) / ( distance * distance )).
    safeStage().
    lock throttle to (targetTWR * weight) / (SHIP:MAXTHRUST + 0.001).
    wait until (ship:apoapsis >= targetApoapsis) or  stage:liquidfuel <= 10000.
    lock throttle to 0.
    safeStage().
}

function boostBack {
  wait 5.
  rcs on.
  lock steering to heading(270, 0).
  print(abs(steeringManager:angleerror)).
  wait until abs(steeringManager:angleerror) < 2.
  lock throttle to 0.5.
  wait until addons:tr:impactpos:lng < -74.5.
  lock throttle to 0.
  rcs off.
}

function cruise {
  lock steering to -1 * ship:velocity:surface.
  wait until ship:altitude < 500.
}

function land {
  gear on.
  rcs on.
  lock throttle to 1.

}

function safeStage {
  wait until stage:ready.
  stage.
}