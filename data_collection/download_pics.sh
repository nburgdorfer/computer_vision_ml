#!/bin/bash
PRE_PATH="http://vision.middlebury.edu/stereo/results3/outputs"
DIR="$1"
TEST_IMG_TAGS=("Australia" "AustraliaP" "Bicycle2" "Classroom2" "Classroom2E" "Computer" "Crusade" "CrusadeP" "Djembe" "DjembeL" "Hoops" "Livingroom" "Newkuba" "Plants" "Staircase")
TRAINING_IMG_TAGS=("Adirondack" "ArtL" "Jadeplant" "Motorcycle" "MotorcycleE" "Piano" "PianoL" "Pipes" "Playroom" "Playtable" "PlaytableP" "Recycle" "Shelves" "Teddy" "Vintage")
NAMES=$2

IFS=' ' read -r -a ALGOS <<< "$NAMES"

for ALGO in "${ALGOS[@]}"
do
    for TEST_TAG in "${TEST_IMG_TAGS[@]}"
    do
        wget -P "$DIR/alg$ALGO/test/$TEST_TAG/" "$PRE_PATH/alg$ALGO/test/$TEST_TAG/disp-600.jpg"
        wget -P "$DIR/alg$ALGO/test/$TEST_TAG/" "$PRE_PATH/alg$ALGO/test/$TEST_TAG/err2.0-nocc-600.jpg"
    done

    for TRAINING_TAG in "${TRAINING_IMG_TAGS[@]}"
    do
        wget -P "$DIR/alg$ALGO/training/$TRAINING_TAG/" "$PRE_PATH/alg$ALGO/training/$TRAINING_TAG/disp-600.jpg"
        wget -P "$DIR/alg$ALGO/training/$TRAINING_TAG/" "$PRE_PATH/alg$ALGO/training/$TRAINING_TAG/err2.0-nocc-600.jpg"
    done
done
