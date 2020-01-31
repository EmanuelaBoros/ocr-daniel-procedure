# Manual for re-creating DAniEL-OCR experiment

### Text-2-Image conversion

* Convert text files to images using .. script
* View README.md for detailed instruction

### OCR-Noise Generation

* Noise generation using [DocCreator](https://doc-creator.labri.fr/)
* Various types of noise: Character Degradation, Phantom Character, Bleed-through, Blur, etc.
* Phantom Character is not recommended since changes are quite insignificant and has very little impact
* Use Batch Mode (Factory icon) and select Semi-Synthetic option to start converting a pre-existing directory of images

## OCR Noisy images back to a text file

* Installation instruction: [Here](https://github.com/tesseract-ocr/tesseract/wiki)
* [Download](https://github.com/tesseract-ocr/tessdata_best) the appropriate language model
* Run "run_tesseract.sh" to start the OCR process:

``` ./run_tesseract.sh IMAGE_DIRECTORY -l LANGUAGE```

For the preffered languages, install:
``` sudo apt-get install tesseract-ocr-eng  #for english
sudo apt-get install tesseract-ocr-tam  #for tamil
sudo apt-get install tesseract-ocr-deu  #for deutsch (German)
``` 

* Rename all output files and remove all suffixes to match file names from the corpus

```./rename.sh TEXT_DIRECTORY EXTENSION```

* Either keep images and xml files and move them to another directory, or remove them using the following commands:

```find TEXT_DIRECTORY -name "\*.IMAGE_EXTENSION" -type f -exec rm {} \\;```
```find TEXT_DIRECTORY -name "\*.xml" -type f -exec rm {} \\;```

* Remove unecessary blank lines ("by-product" of Tesseract-OCR):

```./post-process.sh TEXT_DIRECTORY```

Note: This script uses sed. Because of this, modify it to match the version of sed your system is using

## Experiment with DAniEL

### Putting the noisy corpus into DAniEL

* Make sure that documents location matches of that described in the corpus file
* Run the following script to start to process the whole corpus:

```./daniel-loop.sh Dataset_Directory```

What this script will do is loop through each level of noise, assuming that you have different directories for different level (and you should), and process the whole corpus with a cut-off ratio ranging from 0 to 0.99 with 0.1 increment
* There will be an output file for each language, containing annotations made by DAniEL and evaluations comparing to the ground-truth file, which will show the number of TP, TN, FP, FN, and calculate Recall, Precision, and F1-score 

### Process the result, and plot ROC

* Run this script to process output files of the previous step

```./roc-stat.sh Directory_Containing_DAniEL_Output_File Language_Code```

* To plot the ROC curves based on stats that were extracted:

```python numpy_plot.py Dataset_Directory Noise_Folder_Family Language_Code```


