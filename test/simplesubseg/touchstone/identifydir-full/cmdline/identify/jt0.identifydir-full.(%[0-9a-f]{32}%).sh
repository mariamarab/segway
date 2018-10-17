#!/usr/bin/env bash
(%[^ ]+%)/segway-task run posterior identifydir-full/posterior/posterior%s.0.bed chr1 0 8000 1 0 2 2 full ../simplesubseg.genomedata asinh_norm 0,1 1 -base 3 -cCliquePrintRange 1:1 -cliqueTableNormalize 0.0 -componentCache F -cppCommandOptions (%'(?=.*-\bDCARD_SEG=2\b)(?=.*-\bDCARD_FRAMEINDEX=2000000\b)(?=.*-\bDCARD_SUBSEG=2\b)(?=.*-\bDSEGTRANSITION_WEIGHT_SCALE=1\.0\b)(?=.*-\bDCARD_SUPERVISIONLABEL=-1\b)(?=.*-\bDINPUT_PARAMS_FILENAME=traindir/params/params\.params\b).*'%) -deterministicChildrenStore F -doDistributeEvidence T -eCliquePrintRange 1:1 -fmt1 binary -fmt2 binary -hashLoadFactor 0.98 -inputMasterFile traindir/params/input.master -island T -iswp1 F -iswp2 F -jtFile identifydir-full/log/jt_info.posterior.txt -lst 100000 -nf1 2 -nf2 0 -ni1 0 -ni2 2 -obsNAN T -of1 identifydir-full/observations/float32.list -of2 identifydir-full/observations/int.list -pCliquePrintRange 1:1 -strFile traindir/segway.str -triFile identifydir-full/triangulation/segway.str.2.2.posterior.trifile -verbosity 0
