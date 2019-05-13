We have multiple test rigs and it's handy to have a semi-standard for reusing the raspberry pis as a test controller for these test rigs.

So we opted for a raspberry pi zero, but with a Adafruit 128x64 1.3' OLED Bonnet as the user interface, with the GPIOs exposed at the bottom so it can be slotted into a test rig.

We also designed a custom 3d printed case for this test controller, so it can easily be slotted into various test rigs.

The test rig will provide power for the raspberry pi zero.

Key design decision of this, is the need for a custom 3D printed case. This is since most cases assumes that the header is exposed at the top. Also we want the parts to snap together and stand up on the test rig and withstand the user pressing on the OLED bonnet buttons and joystick.

## Get these parts

Print these 3 parts

* RPI_Zero_W_Test_Controller_Top.stl
* RPI_Zero_W_Test_Controller_Bottom.stl
* Board_Clip_Compact.scad (Configured for this item)

You will need 

* Adafruit 128x64 1.3' OLED Bonnet (Used for displaying test status)
* Stackable Header for Raspberry Pi (Jaycar Product ID: HM3228) (17mm socket, 20mm pin depth )
* Raspberry Pi Zero W
* A preconfigured SD card (Make it yourself for each test)
* A test rig (depends on the problem)

## Construction Step

1. Solder the stackable header to the bottom of the raspberry pi Zero.
2. Slot RPI_Zero_W_Test_Controller_Top to the top of the raspberry pi z
3. Slot in the Adafruit 128x64 1.3' OLED Bonnet to the top. DO NOT SOLDER IT DOWN (If the screen breaks you want to be able to replace it)
4. Place the RPI_Zero_W_Test_Controller_Bottom at the bottom of the raspberry pi Zero
5. Push the retaining 4 board clips "Board_Clip_Compact" to the bottom of the raspberry pi zero
6. Load in a preconfigured SD card
7. Slot into test rig