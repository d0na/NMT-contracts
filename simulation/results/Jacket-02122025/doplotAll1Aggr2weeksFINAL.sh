
outff=png
outf=png
size="600,400"
#size="1024,768"
#max=20
#font="font \"/Library/Fonts/Courier New.ttf\" fsize 14"
font=""
title=""


#time	gasTotalMean	gasTotalStd	gasNewCreatorMean	gasNewCreatorStd	gasNewAssetMean	gasNewAssetStd	gasHolderPolicyUpdateMean	gasHolderPolicyUpdateStd	gasCharacteristicUpdateMean	gasCharacteristicUpdateStd	gasTransferMean	gasTransferStd	TotalNumCreators	maxCreators	minCreators	avgCreators	stdCreators	TotalNumAssets	maxAssets	minAssets	avgAssets	stdAssets

same="set terminal $outff $font size $size\n\
set xlabel 'seconds'\n\
set ylabel 'gas'\n\
set grid ytics\n\
show grid\n\
set xrange [0:1209600]\n\
set yrange [0:*]\n\
set xtics font 'Times-New-Roman,15 \n\
set ytics font 'Times-New-Roman,15 \n\
set xlabel font 'Times-New-Roman,18 \n\
set ylabel font 'Times-New-Roman,18 \n\
set title font 'Times-New-Roman,18 \n\
set key outside center below \n\
set key font 'Times-New-Roman,18 \n";
#set yrange [0:3000000]\n\
#set logscale y\n\
#set xdata time\n\
#set timefmt \"%Y-%m-%d\"\n\
#set format x \"%Y-%m-%d\"\n\
#set xrange ['2024-07-14':'2024-07-21']\n\
#set xtics ('2024-07-15','2024-07-16','2024-07-17','2024-07-18','2024-07-19', '2024-07-20')";

#set yrange [0:6800000]\n\

fileIn1=simResultsTest5Scaledt1209600a60
fileOut="simGraph1Variance"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set title 'Single peak'\n\
plot   '$fileIn1.tsv' using 1:(\$2-\$3):(\$2+\$3) with filledcurves lc \"skyblue\" fs transparent solid 0.35 title 'std', '$fileIn1.tsv' using 1:2 lc \"skyblue\" pt 9 title 'mean', '$fileIn1.tsv' using 1:2 with lines title 'bezier' smooth bezier lw 3 lc \"medium-blue\"\n"  | gnuplot -persist

fileIn2=simResultsTest6Scaledt1209600a60
fileOut="simGraph2Variance"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set title 'Boom and bust'\n\
plot   '$fileIn2.tsv' using 1:(\$2-\$3):(\$2+\$3) with filledcurves lc \"skyblue\" fs transparent solid 0.35 title 'std', '$fileIn2.tsv' using 1:2 lc \"skyblue\" pt 9 title 'mean', '$fileIn2.tsv' using 1:2 with lines title 'bezier' smooth bezier lw 3 lc \"medium-blue\"\n"  | gnuplot -persist

fileOut="simGraph1Creators"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set ylabel 'number of creators'\n\
set title 'Single peak'\n\
plot   '$fileIn1.tsv' using 1:(\$17-\$18):(\$17+\$18) with filledcurves lc \"skyblue\" fs transparent solid 0.35 title 'std', '$fileIn1.tsv' using 1:17 lc \"skyblue\" pt 9 title 'mean', '$fileIn1.tsv' using 1:17 with lines title 'bezier' smooth bezier lw 3 lc \"medium-blue\", '$fileIn1.tsv' using 1:15 with lines title 'max' smooth bezier lw 3 lc \"red\", '$fileIn1.tsv' using 1:16 with lines title 'min' smooth bezier lw 3 lc \"green\"\n"  | gnuplot -persist

fileOut="simGraph1Assets"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set ylabel 'number of assets'\n\
set title 'Single peak'\n\
plot   '$fileIn1.tsv' using 1:(\$22-\$23):(\$22+\$23) with filledcurves lc \"skyblue\" fs transparent solid 0.35 title 'std', '$fileIn1.tsv' using 1:22 lc \"skyblue\" pt 9 title 'mean', '$fileIn1.tsv' using 1:22 with lines title 'bezier' smooth bezier lw 3 lc \"medium-blue\", '$fileIn1.tsv' using 1:20 with lines title 'max' smooth bezier lw 3 lc \"red\", '$fileIn1.tsv' using 1:21 with lines title 'min' smooth bezier lw 3 lc \"green\"\n"  | gnuplot -persist

fileOut="simGraph2Creators"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set ylabel 'number of creators'\n\
set title 'Boom and bust'\n\
plot   '$fileIn2.tsv' using 1:(\$17-\$18):(\$17+\$18) with filledcurves lc \"skyblue\" fs transparent solid 0.35 title 'std', '$fileIn2.tsv' using 1:17 lc \"skyblue\" pt 9 title 'mean', '$fileIn2.tsv' using 1:17 with lines title 'bezier' smooth bezier lw 3 lc \"medium-blue\", '$fileIn2.tsv' using 1:15 with lines title 'max' smooth bezier lw 3 lc \"red\", '$fileIn2.tsv' using 1:16 with lines title 'min' smooth bezier lw 3 lc \"green\"\n"  | gnuplot -persist

fileOut="simGraph2Assets"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set ylabel 'number of assets'\n\
set title 'Boom and bust'\n\
plot   '$fileIn2.tsv' using 1:(\$22-\$23):(\$22+\$23) with filledcurves lc \"skyblue\" fs transparent solid 0.35 title 'std', '$fileIn2.tsv' using 1:22 lc \"skyblue\" pt 9 title 'mean', '$fileIn2.tsv' using 1:22 with lines title 'bezier' smooth bezier lw 3 lc \"medium-blue\", '$fileIn2.tsv' using 1:20 with lines title 'max' smooth bezier lw 3 lc \"red\", '$fileIn2.tsv' using 1:21 with lines title 'min' smooth bezier lw 3 lc \"green\"\n"  | gnuplot -persist







#fileOut="simGraph1Operations"
#size="600,600"
#echo -e "set output \"$fileOut.$outf\"\n\
#$same\n\
#set ylabel 'gas'\n\
#set title 'Single peak'\n\
#set yrange [0:70100000]\n\
#set terminal $outff $font size $size\n\
#plot   '$fileIn1.tsv' using 1:2 with lines title 'Total' smooth bezier lw 3 lc \"medium-blue\", '$fileIn1.tsv' using 1:12 with filledcurves smooth bezie title 'transferFrom' lc \"light-red\",  '$fileIn1.tsv' using 1:10 with filledcurves smooth bezie title 'setColor' lc \"goldenrod\", '$fileIn1.tsv' using 1:8 with filledcurves smooth bezie title 'hPolicyUpdate' lc \"dark-yellow\", '$fileIn1.tsv' using 1:6 with filledcurves smooth bezie title 'newAsset' lc \"dark-orange\", '$fileIn1.tsv' using 1:4 with filledcurves smooth bezie title 'newCreator' lc \"green\"\n"  | gnuplot -persist


fileOut="simGraph1Operations"
size="600,600"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set ylabel 'gas'\n\
set title 'Single peak'\n\
set yrange [0:90000000]\n\
set terminal $outff $font size $size\n\
plot   '$fileIn1.tsv' using 1:2 with lines title 'Total' smooth bezier lw 3 lc \"medium-blue\", '$fileIn1.tsv' using 1:12 with filledcurves smooth bezie title 'assetTransfer' lc \"light-red\",  '$fileIn1.tsv' using 1:10 with filledcurves smooth bezie title 'attributeUpdate' lc \"goldenrod\", '$fileIn1.tsv' using 1:8 with filledcurves smooth bezie title 'holderPolicyUpdate' lc \"dark-yellow\", '$fileIn1.tsv' using 1:6 with filledcurves smooth bezie title 'newAssetCreation' lc \"dark-orange\", '$fileIn1.tsv' using 1:4 with filledcurves smooth bezie title 'newCreatorCreation' lc \"green\"\n"  | gnuplot -persist


fileOut="simGraph2Operations"
size="600,600"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set ylabel 'gas'\n\
set title 'Boom and bust'\n\
set yrange [0:105000000]\n\
set terminal $outff $font size $size\n\
plot   '$fileIn2.tsv' using 1:2 with lines title 'Total' smooth bezier lw 3 lc \"medium-blue\", '$fileIn2.tsv' using 1:12 with filledcurves smooth bezie title 'assetTransfer' lc \"light-red\",  '$fileIn2.tsv' using 1:10 with filledcurves smooth bezie title 'attributeUpdate' lc \"goldenrod\", '$fileIn2.tsv' using 1:8 with filledcurves smooth bezie title 'holderPolicyUpdate' lc \"dark-yellow\", '$fileIn2.tsv' using 1:6 with filledcurves smooth bezie title 'newAssetCreation' lc \"dark-orange\", '$fileIn2.tsv' using 1:4 with filledcurves smooth bezie title 'newCreatorCreation' lc \"green\"\n"  | gnuplot -persist







size="600,600"
fileOut="simGraph12Bezier"
echo -e "set output \"$fileOut.$outf\"\n\
$same\n\
set yrange [1000000:1800100000]\n\
set logscale y\n\
plot   '$fileIn1.tsv' using 1:2 with lines title 'Single peak' smooth bezier lw 3 lc \"medium-blue\", '$fileIn2.tsv' using 1:2 with lines title 'Boom and bust' smooth bezier lw 3 lc \"forest-green\", 150000000 w l lw 3 lc \"light-red\" title 'Ethereum', 1800000000 w l lw 3 lc \"dark-yellow\" title 'Optimism', 900000000 w l lw 3 lc \"dark-orange\" title 'Polygon'\n"  | gnuplot -persist



