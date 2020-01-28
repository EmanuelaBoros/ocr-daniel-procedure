# Manual for re-creating DAniEL-OCR experiment

## Dataset

* 2089 documents in 5 languages: English, Greece, Polish, Russian, Chinese
* 2733 documents in French
* Documents are separated in different folders via languages 
* Corpus files are also divided based on languages
* 1 large corpus file that include every articles

## OCR-Noise Injection

### Text-2-Image conversion

* Convert text files to images using [text2ImgDoc](https://github.com/nnkhoa/text2ImgDoc) script
* View README.md for detailed instruction

### OCR-Noise Generation

* Noise generation using [DocCreator](https://doc-creator.labri.fr/)
* Various types of noise: Character Degradation, Phantom Character, Bleed-through, Blur, etc.
* Phantom Character is not recommended since changes are quite insignificant and has very little impact
* Use Batch Mode (Factory icon) and select Semi-Synthetic option to start converting a pre-existing directory of images

## OCR Noisy images back to text file

* OCR Engine: [Tesseract](https://github.com/tesseract-ocr/tesseract)
* Installation instruction: [Here](https://github.com/tesseract-ocr/tesseract/wiki)
* [Download](https://github.com/tesseract-ocr/tessdata_best) the appropriate language model
* Run "Script-Name-Here" to start the OCR process:
``` ./tesseract-new.sh Noisy Data Directory Path to Tesseract language model```

* Rename all output files and remove all suffixes to match file names from the corpus
> ./rename.sh \<OCR-ed documents Directory\> \<Extension To Be Removed\>

* Either keep images and xml files and move them to another directory, or remove them using the following commands:
> find \<OCR-ed documents Directory\> -name "\*.\<Image-Extension\>" -type f -exec rm {} \\;
> find \<OCR-ed documents Directory\> -name "\*.xml" -type f -exec rm {} \\;

* Remove unecessary blank lines ("by-product" of Tesseract-OCR):
> ./post-process.sh \<OCR-ed documents Directory\>

Note: This script uses sed. Because of this, modify it to match the version of sed your system is using

## Experiment with DAniEL

### Putting the noisy corpus into DAniEL

* Make sure that documents location matches of that described in the corpus file
* Run the following script to start process the whole corpus:
> ./daniel-loop.sh \<Dataset Directory\>

What this script will do is loop through each level of noise, assuming that you have different directories for different level (and you should), and process the whole corpus with cut-off ratio ranging from 0 to 0.99 with 0.1 increment
* There will be an output file for each language, containing annotations made by DAniEL and evaluations comparing to the groundtruth file, which will show number of TP, TN, FP, FN, and calculate Recall, Precision, and F1-score 

### Process the result, and plot ROC

* Run this script to process output files of previous step
> ./roc-stat.sh \<Directory Containing DAniEL Output File\> \<Language Code\>

* To plot the ROC curves based on stats that were extracted:
> python3.7 numpy_plot.py \<Dataset Directory\> \<Noise Folder Family\> \<Language Code\>


