#!/bin/sh

E=""
[ `uname` = "Interix" ] && E=.exe # Hack for running script with Microsoft SFU

echo "GMT tutorial"

# First Session
## First sample
psbasemap${E} -R10/70/-3/8 -JX4i/3i -B10/1:."My first plot": -P > plot.ps

## Logarithmic scale
psbasemap${E} -R1/10000/1e20/1e25 -JX9il/6il -B2:"Wavelength (m)":/a1pf3:"Power (W)":WS > plot.ps

## Mercator projection (Latin America view)
#pscoast${E} -R-90/-70/0/20 -JM6i -P -B5g5 -Gchocolate > map.ps
pscoast${E} -R270/290/0/20 -JM6i -P -B5g5 -W0.25p -V -Na > map.ps

## Conic projection (France view)
pscoast${E} -R-5/10/40/53 -JB2.5/0/45/55/6i -B5g1:."Conic Projection": -N1/thickest -N2/thinnest -A500 -Ggray -Wthinnest -P > map-conic.ps

# Second session (with custom data)
minmax${E} data.txt

# Draw symbols connected by a line (first use of overlay -O/-K options: draw the line then symbols)
psxy${E} data.txt -R -J -P -B -Wthinner -K > plot-data.ps
psxy${E} data.txt -R -J -O -W -Sc0.5 -Gchocolate >> plot-data.ps

# Sample with France map
pscoast${E} -R-5/10/40/53 -JB2.5/0/45/55/6i -B5g1:."Conic Projection": -N1/thickest -N2/thinnest -A500 -Ggray -Wthinnest -P -K > plot-data-fr.ps
psxy${E} data.txt -R -J -O -P -B -Wthinner -K >> plot-data-fr.ps
psxy${E} data.txt -R -J -O -W -Sc0.5 -Gchocolate >> plot-data-fr.ps
