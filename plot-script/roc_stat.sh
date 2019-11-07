#!/bin/bash


LANG=$1
RESULT_FILE="$LANG"_output_new
OUTPUT="$LANG"_ROC_NEW
for NOISE_LEVEL in ocr_clean ocr_CharDeg_0 ocr_CharDeg_1 ocr_CharDeg_2 ocr_CharDeg_3 ocr_CharDeg_4
do 
    DATA=$(grep "$LANG {" $NOISE_LEVEL/$RESULT_FILE)
    echo $DATA |sed -e 's/'$LANG' /\'$'\n/g'|sudo tee $NOISE_LEVEL/$OUTPUT
done
