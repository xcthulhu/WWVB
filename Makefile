# $Id$

EXECUTABLES=wwvbaq tuneup

all :	$(EXECUTABLES)

wwvbaq : wwvbaq.c param.h
	$(CC) -o wwvbaq -lm -lcomedi -lrt wwvbaq.c

tuneup : param.h tuneup.c
	$(CC) -o tuneup -lm tuneup.c

clean :
	rm $(EXECUTABLES)
	
# $Log$
# Revision 1.6  2010-08-03 14:54:55  jpd
# Added Matt's revisions:
# - Data acquisition code in wwvbaq.c now uses real time priority; Makefile hacked accordingly
#
# - wwvbred.py no longer uses memmap; wwvbred now reads single lines of data
#   off of a bitstream piped to it from wwvbaq. The scrupt wwvbaq.sh is now pipelined
#
# - wwvbred.py reads the time off of the signal piped to it to it using the
#   codes described here: http://en.wikipedia.org/wiki/WWVB#Time_Code_Format
#   - Initially, wwvbred throws data into a buffer until it detects the time,
#     then opens a file wwvb-YYYYMMDDhhmmss-epoch.tsv where "epoch" is the number
#     of seconds since midnight January 1, 1970
#   - Every day at midnight UTC, wwvbred.py changes to outputting to a new file
#
# - wwvbred.py corrects for the 45 degree phase shift that happens between 10
#   and 15 minutes on the hour, as documented here:
#   http://en.wikipedia.org/wiki/WWVB#Station_ID
#
# - wwvbaq_rename.py renames legacy datafiles using the same logic and conventions from in wwvbred.py
#
# - Created directory "fermi":
#   - proc_fermi_grbs.sh is a toplevel script that does the following:
#     - Grabs http://gcn.gsfc.nasa.gov/fermi_grbs.html with curl
#     - pipes that to parse_fermi_grbs.awk
#     - optionally pipes that to find_fermi_events.py (currently disabled)
#   - parse_fermi_grbs.awk generates an XEphem database of fermi gamma-ray burst events
#   - find_fermi_events.py reads the database generated by parse fermi grbs, uses the local
#     latitude and longitude of Noqsi aerospace (40.00953472, -105.20454705)
#     and calculates whether the event was above the local horizon using PyEphem
#
# Revision 1.5  2009-07-15 19:39:33  jpd
# Tuneup timing.
#
# Revision 1.4  2009-07-05 22:09:19  jpd
# Make complex real data from complex integer samples.
#
# Revision 1.3  2009-06-22 00:35:38  jpd
# First light.
#
# Revision 1.2  2009-06-21 22:04:57  jpd
# Share parameters.
# Tuneup filter.
#
# Revision 1.1  2009-06-16 00:02:18  jpd
# Timing test.
#
