#!/bin/bash
red=$'\e[1;31m'
end=$'\e[0m'

DIR="$1"
NAMES=$2

PRE_PATH="http://vision.middlebury.edu/stereo/results3/outputs"

TEST_IMG_TAGS=("Australia" "AustraliaP" "Bicycle2" "Classroom2" "Classroom2E" "Computer" "Crusade" "CrusadeP" "Djembe" "DjembeL" "Hoops" "Livingroom" "Newkuba" "Plants" "Staircase")
TRAINING_IMG_TAGS=("Adirondack" "ArtL" "Jadeplant" "Motorcycle" "MotorcycleE" "Piano" "PianoL" "Pipes" "Playroom" "Playtable" "PlaytableP" "Recycle" "Shelves" "Teddy" "Vintage")
ALGO_NUMS=(
"SLAC"
"SGBM2"
"SGBM1"
"SGM"
""
"SGBM1"
""
"SGBM1"
"SGM"
"SGM"
"Cens5"
"LPS"
"LPS"
"BSM"
"LAMC_DSM"
"SNCC"
"IDR"
""
"LCU"
"TSGO"
"REAF"
"PFS"
"TMAP"
"MeshStereo"
"MC-CNN-acrt"
"ELAS"
""
"R-NCC"
"MDP"
""
"MC-CNN+RBS"
"GCSVR"
"APAP-Stereo"
"SOU4P-net"
"INTS"
"NTDE"
"MC-CNN-fst"
""
"MCCNN_Layout"
"LS-ELAS"
""
"MPSV"
"ICSG"
"MeshStereoExt"
"Glstereo"
"HLSC_cor"
"JEM"
"PMSC"
"LPU"
"SED"
"SNP-RSM"
"LFSIR"
"LW-CNN"
"SIGMRF"
"SPS"
""
""
""
""
"MC-CNN-WS"
"UCNN"
"MCSC"
"ADSM"
"IGF"
"3DMST"
""
""
"SGMEPi"
"MC-CNN+TDSR"
"JMR"
"DSGCA"
"DDL"
"r200high"
"DoGGuided"
"LocalExp"
"SSR"
"FEN-D2DRR"
""
""
"CBMV"
"CGPT"
"OVOD"
"SMSSR"
"DF"
"SDR"
"NOSS"
""
""
"SGM_ROB"
"SGM-Forest"
"DTS"
"MEDIAN_ROB"
"AVERAGE_ROB"
"ELAS_ROB"
"ISM"
"PSMNet_ROB"
"WCMA_ROB"
""
""
"PDS"
"DN-CSS_ROB"
"LALA_ROB"
"ETED_ROB"
"XPNet_ROB"
"NOSS_ROB"
"PWCDC_ROB"
"DLCB_ROB"
""
"FBW_ROB"
"iResNet_ROB"
"CBMV_ROB"
"DPSimNet_ROB"
"NaN_ROB"
"PDISCO_ROB"
""
"CBMBNet"
"MSMD_ROB"
"DCNN"
"MotionStereo"
"Dense-CNN"
"DISCO"
"iResNet"
"IEBIMst"
"HSM"
"MBM"
""
""
"MSFNetA"
"EHCI_net"
""
"FASW"
"MCV-MFC"
"AMNet"
"DAWA-F"
""
""
"FFE"
"SM-AWP"
"3DMST-CM"
"WDMC"
"TCSCSM"
"tMGM-16"
"VN"
"PSMNet_2000"
"PWCA_SGM"
"DeepPruner_ROB"
"EdgeStereo"
)

IFS=' ' read -r -a ALGOS <<< "$NAMES"
FLAG=false

for ALGO in "${ALGOS[@]}"
do
    FLAG=false
    for NUM in "${!ALGO_NUMS[@]}"
    do
        if [ "${ALGO_NUMS[$NUM]}" == $ALGO ]
        then
            FLAG=true
            FULL_NUM=$(printf "%04d" $NUM)
            printf "%s %s\n" $ALGO $FULL_NUM
        fi
    done

    if [ "$FLAG" == false ]
    then

        printf "${red}Could not find %s${end}\n" $ALGO
        continue
    fi
    
    COUNT=0
    for TEST_TAG in "${TEST_IMG_TAGS[@]}"
    do
        wget -i "$PRE_PATH/alg$FULL_NUM/test/$TEST_TAG/disp-600.jpg" -P "$DIR/test/$ALGO/" &> /dev/null
        wget -i "$PRE_PATH/alg$FULL_NUM/test/$TEST_TAG/err2.0-nocc-600.jpg" -P "$DIR/test/$ALGO/" &> /dev/null
        mv "./$DIR/test/$ALGO/disp-600.jpg" "./$DIR/test/$ALGO/${COUNT}_result_disp_img.jpg"
        mv "./$DIR/test/$ALGO/err2.0-nocc-600.jpg" "./$DIR/test/$ALGO/${COUNT}_errors_disp_img.jpg"
        ((COUNT++))
    done

    COUNT=0
    for TRAINING_TAG in "${TRAINING_IMG_TAGS[@]}"
    do
        wget -i "$PRE_PATH/alg$FULL_NUM/training/$TRAINING_TAG/disp-600.jpg" -P "$DIR/training/$ALGO/" &> /dev/null
        wget -i "$PRE_PATH/alg$FULL_NUM/training/$TRAINING_TAG/err2.0-nocc-600.jpg" -P "$DIR/training/$ALGO/" &> /dev/null
        mv "./$DIR/training/$ALGO/disp-600.jpg" "./$DIR/training/$ALGO/${COUNT}_result_disp_img.jpg"
        mv "./$DIR/training/$ALGO/err2.0-nocc-600.jpg" "./$DIR/training/$ALGO/${COUNT}_errors_disp_img.jpg"
        ((COUNT++))
    done
done
