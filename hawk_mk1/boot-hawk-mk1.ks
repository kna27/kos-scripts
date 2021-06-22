core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
CLEARSCREEN.
print ("Successful boot.").
wait 0.75.
print ("Loading 'hawk-mk1.ks'...").
runpath("0:/hawk-mk1.ks").