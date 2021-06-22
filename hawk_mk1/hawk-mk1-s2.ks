print("Stage 2 Active").
lock steering to heading(90, 40).
wait 3. 
doSafeStage().
lock throttle to 0.45.
wait until ship:apoapsis >= 85000.
lock throttle to 0.2.
wait until ship:apoapsis >= 89000.
lock throttle to 0.1.
wait until ship:apoapsis >= 90000.
lock throttle to 0.
print("S2 - Target apoapsis reached").
lock steering to prograde.
wait until ship:altitude >= 70000.
print("S2 - Fairing deploy...").
doSafeStage().
set apo to ship:apoapsis - 500.
wait until eta:apoapsis < 6.
lock steering to prograde.
lock throttle to 0.75.
wait until ship:periapsis >= apo OR ship:apoapsis > 92500 OR ship:periapsis > 87500.
lock throttle to 0.
wait 1.5.
print("S2 - Stable orbit achived").
print("Apoapsis Height:").
print(ship:apoapsis).
print("Periapsis Height:").
print(ship:periapsis).
wait until false.
lock throttle to 0.

function doSafeStage {
  wait until stage:ready.
  stage.
}
