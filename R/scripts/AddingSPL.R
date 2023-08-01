# Loading some test data - change to your AcousticStudy
data <- readRDS('../Data/3D2PAMr_test_files/AMStudy.rds')
source('devel/MZ_SPL_devel.R')

# calculate SPL differences, rename "evNum" to "eventId" because this is
# what PAMpal wants later
splDf <- calculate_SPL_diff(data)
splDf <- rename(splDf, eventId=evNum)

# addMeasures function added in PAMpal v0.20.2
# Only use first 3 columns of splDf because we dont want "n_dets" for modeling
# Only requirement for "measures" is an "eventId" column matching event names in our data
data <- addMeasures(data, measures = splDf[1:3])
# this will show what we've added for each event
getMeasures(data)

# these will automatically get exported now with export_banter
# This should tell you that it found 2 event level measures that are exported
banterData <- export_banter(data)
# should see the band_diff_xxx data with our event data
banterData$events

# from here train your banter model as normal!
