set targAlt to 200.

//countdown().
ascend().
land().
exit().

function countdown {
  lock throttle to 0.
  print ("'F9 Hop' successfully loaded.").
  wait 0.75.
  print (targAlt + " meter hop test.").
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
  lights on.
  rcs on.
  gear off.
  lock steering to up.
  set t to 0.
  lock throttle to t.
  set groundHeight to alt:radar.
  stage.
  until alt:apoapsis >= targAlt{
    set t to t + 0.01.
  }
  lock throttle to 0.
  wait until ship:altitude >= targAlt.
  print ("Target altitude reached.").
  gear on.
  wait 2.
}

function land {
  set t to 0.1.
  lock throttle to t.
  until ship:status = "LANDED" {
    if (alt:radar < targAlt and alt:radar > groundHeight + 20) {
      set desVel to 10.
    } else if (alt:radar < groundHeight + 20) {
      set desVel to 0.5.
    }

    if (ship:velocity:surface:mag > desVel) {
      set t to min(1, t + 0.01).
    } else if (ship:verticalSpeed > 0) {
      set t to 0.
    } else {
      set t to max((9.81 * SHIP:MASS) / SHIP:MAXTHRUST, t - 0.1).
    }
  }
}

function exit {
  lock throttle to 0.
  BRAKES ON.
  print("Landed.").
  wait 0.25.
  wait until ship:status = "LANDED".
  print(targAlt + " meter hop test succesful.").
}