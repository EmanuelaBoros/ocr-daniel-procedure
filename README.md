# Manual for re-creating DAniEL-OCR experiment

## Dataset

* 2089 documents in 5 languages: English, Greece, Polish, Russian, Chinese
* Documents are separated in different folders via languages 
* Corpus files are also divided based on languages
* 1 large corpus file that include every articles

## OCR-Noise Injection

### Text-2-Image conversion

* Convert text files to images using [text2ImgDoc](https://github.com/nnkhoa/text2ImgDoc)
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
> ./tesseract-new.sh \<Noisy Data Directory\> \<Path to Tesseract language model\>

* Rename all output files and remove all suffixes to match file names from the corpus
> ./rename.sh \<OCR-ed documents Directory\> \<Extension To Be Removed\>

* Either keep images and xml files and move them to another directory, or remove them using the following commands:
> find \<OCR-ed documents Directory\> -name "\*.\<Image-Extension\>" -type f -exec rm {} \;
> find \<OCR-ed documents Directory\> -name "\*.\<Image-Extension\>" -type f -exec rm {} \;

* Remove unecessary blank lines ("by-product" of Tesseract-OCR):
> ./post-processing.sh \<OCR-ed documents Directory\>

Note: This script uses sed. Because of this, modify it to match the version of sed your system is using