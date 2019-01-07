OPENSCAD = /usr/bin/openscad
CP       = /bin/cp -a
RM       = /bin/rm -f

Files   = TV/BatteryDummyD.stl   \
	  TV/BatteryDummyC.stl   \
	  TV/BatteryDummyAA.stl  \
	  TV/BatteryDummyAAA.stl \
	  TV/BatteryDummyDemo.png\
	  TV/BatteryDummy.scad   \
          TV/BatteryDummy1.jpg   \
          TV/BatteryDummy2.jpg   \
          TV/BatteryDummy3.jpg   \

ALL:	$(Files)

Clean:
	$(RM) TV/*

file2param = $(subst TV/BatteryDummy,,$(subst .$(2),,$(1)))

TV/BatteryDummy%.stl: BatteryDummy.scad
	$(OPENSCAD) -o $@ -D BatteryDummy_type='"'$(call file2param,$@,stl)'"' $<

TV/BatteryDummy%.png: BatteryDummy.scad
	$(OPENSCAD) -o $@ -D BatteryDummy_type='"'$(call file2param,$@,png)'"' --imgsize=800,600 --autocenter --projection=p --render $<

TV/BatteryDummy.scad: BatteryDummy.scad
	$(CP) $< $@

TV/BatteryDummy%.jpg: Images/BatteryDummy%.jpg
	$(CP) $< $@