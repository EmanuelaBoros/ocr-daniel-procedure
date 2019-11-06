# Manual for re-creating DAniEL-OCR experiment

## Dataset

* 2089 documents in 5 languages: English, Greece, Polish, Russian, Chinese
* Documents are separated in different folders via languages 
* Corpus files are also divided based on languages
* 1 large corpus file that include every articles

## OCR Noise Injection

### Text-2-Image conversion

* Convert text files to images using [text2ImgDoc](https://github.com/nnkhoa/text2ImgDoc)
* View README.md for detailed instruction

### OCR Noise Generation

* Noise generation using [DocCreator](https://doc-creator.labri.fr/)
* Various types of noise: Character Degradation, Phantom Character, Bleed-through, Blur, etc.
* Phantom Character is not recommended since changes are quite insignificant and has very little impact
* Use Batch Mode (Factory icon) and select Semi-Synthetic option to start converting a pre-existing directory of images

