set terminal png transparent size 640,240
set size 1.0,1.0

set terminal png transparent size 640,480
set output 'commits_by_author.png'
set key left top
set xdata time
set timefmt "%s"
set format x "%Y-%m-%d"
set grid y
set ylabel "Commits"
set xtics rotate
set bmargin 6
plot 'commits_by_author.dat' using 1:2 title "Jan Zalsky" w lines, 'commits_by_author.dat' using 1:3 title "Matouš Skála" w lines, 'commits_by_author.dat' using 1:4 title "techi602" w lines, 'commits_by_author.dat' using 1:5 title "igorrogi" w lines, 'commits_by_author.dat' using 1:6 title "Tomas Jukin" w lines
