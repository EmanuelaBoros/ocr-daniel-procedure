#!/bin/bash

DATA_DIR=$1

EN_OUTPUT=en_output
EL_OUTPUT=el_output
FR_OUTPUT=fr_output
PL_OUTPUT=pl_output
RU_OUTPUT=ru_output
ZH_OUTPUT=zh_output


for NOISE_LEVEL in ocr_clean ocr_CharDeg_0 ocr_CharDeg_1 ocr_CharDeg_2 ocr_CharDeg_3 ocr_CharDeg_4
#for NOISE_LEVEL in ocr_Phantom_0 ocr_Phantom_1 ocr_Phantom_2
do
    rm $DATA_DIR/$NOISE_LEVEL/$EN_OUTPUT
    rm $DATA_DIR/$NOISE_LEVEL/$EL_OUTPUT
    rm $DATA_DIR/$NOISE_LEVEL/$FR_OUTPUT
    rm $DATA_DIR/$NOISE_LEVEL/$PL_OUTPUT
    rm $DATA_DIR/$NOISE_LEVEL/$RU_OUTPUT
    rm $DATA_DIR/$NOISE_LEVEL/$ZH_OUTPUT
    
    #$DATA_DIR/post_process.sh $DATA_DIR/$NOISE_LEVEL/doc_el
    #$DATA_DIR/post_process.sh $DATA_DIR/$NOISE_LEVEL/doc_en
    #$DATA_DIR/post_process.sh $DATA_DIR/$NOISE_LEVEL/doc_pl
    #$DATA_DIR/post_process.sh $DATA_DIR/$NOISE_LEVEL/doc_ru
    #$DATA_DIR/post_process.sh $DATA_DIR/$NOISE_LEVEL/doc_zh
    #$DATA_DIR/post_process.sh $DATA_DIR/$NOISE_LEVEL/doc_fr
done

for RATIO in 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.99
do
    for NOISE_LEVEL in ocr_clean ocr_CharDeg_0 ocr_CharDeg_1 ocr_CharDeg_2 ocr_CharDeg_3 ocr_CharDeg_4
    #for NOISE_LEVEL in ocr_Phantom_0 ocr_Phantom_1 ocr_Phantom_2
    do
        echo $RATIO >> $DATA_DIR/$NOISE_LEVEL/$EN_OUTPUT
        pypy3 process_corpus.py -c $DATA_DIR/$NOISE_LEVEL/daniel_en.json -r $RATIO -e >> $DATA_DIR/$NOISE_LEVEL/$EN_OUTPUT
        
        echo $RATIO >> $DATA_DIR/$NOISE_LEVEL/$EL_OUTPUT
        pypy3 process_corpus.py -c $DATA_DIR/$NOISE_LEVEL/daniel_el.json -r $RATIO -e >> $DATA_DIR/$NOISE_LEVEL/$EL_OUTPUT
        
        echo $RATIO >> $DATA_DIR/$NOISE_LEVEL/$PL_OUTPUT
        pypy3 process_corpus.py -c $DATA_DIR/$NOISE_LEVEL/daniel_pl.json -r $RATIO -e >> $DATA_DIR/$NOISE_LEVEL/$PL_OUTPUT
        
        echo $RATIO >> $DATA_DIR/$NOISE_LEVEL/$RU_OUTPUT
        pypy3 process_corpus.py -c $DATA_DIR/$NOISE_LEVEL/daniel_ru.json -r $RATIO -e >> $DATA_DIR/$NOISE_LEVEL/$RU_OUTPUT
        
        echo $RATIO >> $DATA_DIR/$NOISE_LEVEL/$ZH_OUTPUT
        pypy3 process_corpus.py -c $DATA_DIR/$NOISE_LEVEL/daniel_zh.json -r $RATIO -e >> $DATA_DIR/$NOISE_LEVEL/$ZH_OUTPUT
        
        echo $RATIO >> $DATA_DIR/$NOISE_LEVEL/$FR_OUTPUT
        pypy3 process_corpus.py -c $DATA_DIR/$NOISE_LEVEL/doc_fr/french-docs.json -r $RATIO -e >> $DATA_DIR/$NOISE_LEVEL/$FR_OUTPUT
    done
done
