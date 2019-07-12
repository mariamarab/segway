#!/usr/bin/env bash
(%[^ ]+%)/segway-task run bundle-train '' 0 0 0 1 0 -base 3 -componentCache F -cppCommandOptions (%'(?=.*-\bDCARD_SEG=4\b)(?=.*-\bDOUTPUT_PARAMS_FILENAME=traindir/params/params\.0\.params\.3\b)(?=.*-\bDINPUT_PARAMS_FILENAME=traindir/params/params\.0\.params\.2\b)(?=.*-\bDCARD_FRAMEINDEX=2000000\b)(?=.*-\bDCARD_SUBSEG=1\b)(?=.*-\bDSEGTRANSITION_WEIGHT_SCALE=1\.0\b).*'%) -deterministicChildrenStore F -fmt1 binary -fmt2 binary -hashLoadFactor 0.98 -inputMasterFile traindir/params/input.master -island T -iswp1 F -iswp2 F -jtFile traindir/log/jt_info.txt -llStoreFile traindir/likelihood/likelihood.ll -lldp 0.001 -loadAccFile traindir/accumulators/acc.0.@D.bin -loadAccRange 0 -lst 100000 -maxEmIters 1 -nf1 2 -nf2 0 -ni1 0 -ni2 2 -objsNotToTrain traindir/auxiliary/dont_train.list -obsNAN T -of1 traindir/observations/float32.list -of2 traindir/observations/int.list -outputMasterFile traindir/params/output.master -strFile traindir/segway.str -triFile traindir/triangulation/segway.str.4.1.trifile -trrng nil -verbosity 0
