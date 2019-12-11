#!/bin/bash

RESFOLDER=res_01_FWHMx
TASK=hrf
DS=TR600
mkdir -p ${RESFOLDER}

for sdx in {01..17}
do
    for rdx in {01..06}
    do
        INFILE=fmriflows/preproc_func/sub-${sdx}/sub-${sdx}_task-${TASK}_run-${rdx}_tFilter_5.0.100.0_sFilter_LP_0.0mm.nii.gz
        OUTFILE=${RESFOLDER}/sub-${sdx}_run-${rdx}_fmriflows_5.0
        fslmaths ${INFILE} -Tmean temp_mean.nii.gz
        N4BiasFieldCorrection -i temp_mean.nii.gz -d 3 -o temp_n4.nii.gz
        bet temp_n4.nii.gz temp_brain.nii.gz -R -m
        fslmaths ${INFILE} -mul temp_brain_mask.nii.gz temp_func.nii.gz
        3dFWHMx -acf -detrend 2 -automask -input temp_func.nii.gz > ${OUTFILE}.out
        mv 3dFWHMx.1D.png ${OUTFILE}.png
        rm 3dFWHMx.1D temp_*.nii.gz

        INFILE=fmriflows/preproc_func/sub-${sdx}/sub-${sdx}_task-${TASK}_run-${rdx}_tFilter_None.100.0_sFilter_LP_0.0mm.nii.gz
        OUTFILE=${RESFOLDER}/sub-${sdx}_run-${rdx}_fmriflows_None
        fslmaths ${INFILE} -Tmean temp_mean.nii.gz
        N4BiasFieldCorrection -i temp_mean.nii.gz -d 3 -o temp_n4.nii.gz
        bet temp_n4.nii.gz temp_brain.nii.gz -R -m
        fslmaths ${INFILE} -mul temp_brain_mask.nii.gz temp_func.nii.gz
        3dFWHMx -acf -detrend 2 -automask -input temp_func.nii.gz > ${OUTFILE}.out
        mv 3dFWHMx.1D.png ${OUTFILE}.png
        rm 3dFWHMx.1D temp_*.nii.gz

        INFILE=fmriprep/sub-${sdx}/func/sub-${sdx}_task-${TASK}_run-${rdx}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz
        OUTFILE=${RESFOLDER}/sub-${sdx}_run-${rdx}_fmriprep
        fslmaths ${INFILE} -Tmean temp_mean.nii.gz
        N4BiasFieldCorrection -i temp_mean.nii.gz -d 3 -o temp_n4.nii.gz
        bet temp_n4.nii.gz temp_brain.nii.gz -R -m
        fslmaths ${INFILE} -mul temp_brain_mask.nii.gz temp_func.nii.gz
        3dFWHMx -acf -detrend 2 -automask -input temp_func.nii.gz > ${OUTFILE}.out
        mv 3dFWHMx.1D.png ${OUTFILE}.png
        rm 3dFWHMx.1D temp_*.nii.gz

        INFILE=fsl_feat/sub-${sdx}/sub-${sdx}_task-${TASK}_run-${rdx}_bold_norm.nii.gz
        OUTFILE=${RESFOLDER}/sub-${sdx}_run-${rdx}_fsl_feat
        fslmaths ${INFILE} -Tmean temp_mean.nii.gz
        N4BiasFieldCorrection -i temp_mean.nii.gz -d 3 -o temp_n4.nii.gz
        bet temp_n4.nii.gz temp_brain.nii.gz -R -m
        fslmaths ${INFILE} -mul temp_brain_mask.nii.gz temp_func.nii.gz
        3dFWHMx -acf -detrend 2 -automask -input temp_func.nii.gz > ${OUTFILE}.out
        mv 3dFWHMx.1D.png ${OUTFILE}.png
        rm 3dFWHMx.1D temp_*.nii.gz

        INFILE=spm/sub-${sdx}/wasub-${sdx}_task-${TASK}_run-${rdx}_bold.nii.gz
        OUTFILE=${RESFOLDER}/sub-${sdx}_run-${rdx}_spm
        fslmaths ${INFILE} -Tmean temp_mean.nii.gz
        N4BiasFieldCorrection -i temp_mean.nii.gz -d 3 -o temp_n4.nii.gz
        bet temp_n4.nii.gz temp_brain.nii.gz -R -m
        fslmaths ${INFILE} -mul temp_brain_mask.nii.gz temp_func.nii.gz
        3dFWHMx -acf -detrend 2 -automask -input temp_func.nii.gz > ${OUTFILE}.out
        mv 3dFWHMx.1D.png ${OUTFILE}.png
        rm 3dFWHMx.1D temp_*.nii.gz

        echo sub-${sdx}_run-${rdx} done.

    done
done
