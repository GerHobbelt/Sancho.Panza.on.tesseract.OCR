# Scratch

URL: https://groups.google.com/g/tesseract-ocr/c/B2-EVXPLovQ/m/lP0zQVApAAAJ

Hi Guys , i will start development OCR using image and Pdf to text extraction what are the steps i need to follow , can you pleasse refer me the best model , already i had used the pytesseract engine but i did not get proper extraction ...  
  
Best Regards,  
  
Sandhiya

--------


_PDF. OCR. text extraction. best language models? not a lot of success yet..._

  

🤔 

  

Broad subject.  Learning curve ahead. 🚧 Workflow diagram included today.  

  

  

**Tesseract does not live alone**

  

Tesseract is an engine, which takes an image as input and produces text output; several output formats are available. If you are unsure, start with HOCR output as that's close to modern HTML and carries almost all info tesseract produces during the OCR process.  

If it isn't an image you've got, you need a preprocess (and consequently additional tools) to produce images you can feed tesseract. tesseract is designed to process a SINGLE IMAGE. (Yes, that means you may want to 'merge' its output: postprocessing)

     _To complicate matters immediately, tesseract can deal with "multipage TIFF" images and can accept multiple images to process via its commandline. Keep thinking "one page image in, bunch of text out" and you'll be okay until you discover the additional possibilities._

  

_Advice Number 1:_ get a tesseract executable, invoke it using its commandline interface. If you can't build tesseract yourself, Uni Mannheim may have binaries for you to download and install. Linuxes often have tesseract binaries and mandatory language models available as packages, BUT many Linuxes are more or less far behind the curve: latest tesseract release as of this writing is 5.3.4: [https://github.com/tesseract-ocr/tesseract/releases](https://github.com/tesseract-ocr/tesseract/releases) so VERIFY your rig has the latest tesseract installed. Older releases are older and "previous" for a reason!

  

**_Preprocessing_ is the chorus of this song**

  

As you say "PDF", you therefor need to convert that thing to _page images_. My personal favorite is the Artifex mupdf toolkit, using mutool or mudraw / etc. tools from that commandline toolkit to render accurate, high-rez page images. Others will favor other means but it all ends up doing the same thing: anything, PDFs et al, is to be converted to one image per page and fed to tesseract that way. The rendered page images MAY require additional *image preprocessing*: 

  

  

**This next bit cannot be stressed enough:** tesseract is designed and engineered to work on plain printed book pages, i.e. BLACK TEXT on PLAIN WHITE BACKGROUND. As I observe everyone and their granny dumping holiday snapshots, favorite CD, LP and fancy colourful book covers straight into tesseract and complaining "nothing sensible is coming out" that's because you're feeding it a load of dung as far as the engine concerned: it expects BLACK TEXT on PLAIN WHITE BACKGROUND like a regular dull printed page in a BOOK, so anything with nature backgrounds, colourful architectural backgrounds and such is begging for a disaster. And I only emphasize with the grannies. <drama + rant mode off/>   This is why [https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html](https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html) is mentioned almost every week in this mailing list, for example. It's very important, but you'll need more...

  

  

The take-away? You'll need additional tools for image preprocessing until you can produce greyscale or B&W images that look almost as if these were plain old boring book pages: no or very little fancy stuff, black text (anti-aliased or not), white background. 

Bonus points for you when your preprocess removes non-text image components, e.g. photographs, in the page image: it can only confuse the OCR engine so when you strive for perfection, that's one more bit to deal with BEFORE you feed it into tesseract and wait expectantly... (Besides, tesseract will have less discovery to do so it'll be faster too. Of little importance, relatively speaking, but there you have it.)

As also mentioned at [https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html](https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html) : tools of interest re image processing are leptonica (parts used by tesseract, but don't count on it doing your preprocessing for you as it's a highly scenario/case-dependent activity and therefor not included in tesseract itself) Also check out: OpenCV (a library, not a tool, so you'll need scaffolding there before you can use it), ImageMagick, (Adobe Photoshop or open source: Krita: great for what-can-I-get experiments but not suitable for bulk), etc.etc.

  

  

**Tesseract bliss and the afterglow: postprocessing**

  

Once you are producing page images like they were book pages, and feeding them into tesseract, you get output, being it "plain text", HOCR or otherwise.

  

Personally I favor HOCR but that's because it's closest to what _my_ workflow needs. You must look into "postprocessing" anyway: being it additional tooling to recombine the OCR-ed text into PDF "overlay", PDF/A production, or anything else; advanced usage may require additional postprocessing steps, e.g. pulling the OCR-ed text through a spellchecker+corrector such as hunspell, if that floats your boat. You'll also need to get and set up and/or program postprocess tooling if you otherwise wish to merge multiple images' OCR results. You may want to search the internet for this; I don't have any toolkit's name present off the top off my head for that as I'm using tesseract in a slightly different workflow, where it is part of a custom, _augmented_ mupdf toolkit: PDF in, PDF + HOCR + misc document metadata out, so all that preprocessing and postprocessing I hammer on is done by yours truly's custom toolchain. Under development, so I'm not working with the diverse python stuff most everybody else will dig up after a quick google search, I'm sure. Individual project's requirements' differences and such, so your path will only be obvious to you.

  

  

  

**How to be trolling an OCR engine** 😋

  

Oh, before I forget: some peeps drop shopping bills and such into off-the-shelf tesseract: _cute_ but not anything like a "plain printed book page" so they encounter all kinds of "surprises":    [https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html](https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html)  is important but it doesn't tell you _everything_. "plain printed book pages" are, by general assumption, pages of text, or, more precisely: _stories_. Or other tracts with paragraphs of text. Bills, invoices and other financial stuff is not just "tabulated semi-numeric content" instead of "paragraphs of text" but those types of inputs also fail grade F regarding the other implicit assumption that comes with human "paragraphs of text": the latter are series of words, technically each a bunch of alphabet glyphs (_alpha_numerics), while financials often mix currency symbols and numeric values: while these were part of tesseract's training set, I am sure, they are not its focal point hence have been given less attention than the words in your language dictionary. And scanning those SKUs will fare even worse as they're just a jumbled _codes_, rather than _language_. Consequently you'll need to retrain tesseract if your CONTENT does not suit these mentioned assumptions re "plain printed book page". Haven't done that yet myself; it's not for the faint of heart and since Google did the training for the "official" tesseract language models everyone downloads and uses, you can bet your bottom retraining isn't going to be "nice" for the less well funded either. Don't expect instant miracles and expect a long haul when you decide you must go this route [of training tesseract], or you will meet Captain Disappointment. Y'all have been warned. 😉

  

  

  

  

**Why your preprocess is more important than kickstarting tesseract, by blowing ether* up its carburetor**

  

**Why is that "plain printed book page is like human stories and similar tracts: paragraphs of text" mantra so important?** Well, tesseract uses a lot of technology to get the OCR quality it achieves, including using language dictionaries. While some smarter people will find switches in tesseract where _explicit_ dictionary usage can be turned off, it cannot switch off the _implicit_ use due to how the latest and best core engine: LSTM+CTC (since tesseract v4) actually works: it slowly moves its gaze across each word it is fed (jargon: _image segmentation_ preprocess inside tesseract produces these word images) and LSTM is so good at recognizing text, because it has "learned context": that context being the characters surrounding the one it is gazing at right now. Which means LSTM can be argued to act akin to a _hidden Markov model_ (see wikipedia) and thus will deliver its predictions based on what "language" (i.e. _dictionary_) it was fed during training: human text which is used in professional papers and stories. Dutch VAT codes didn't feature in the training set, as one member of the ML discovered a while ago. Financial amounts, e.g. "EUR7.95" are also not prominently featured in LSTMs training so you can now guess the amount of confusion the LSTM will experience when scanning across such a thing: reading "EUR" has it expect "O" with high confidence, as in "eur" obviously leading to the word "euro", but what the heck is that "digit 7" doing there?! That's _highly_ unexpected, hence OCR probabilities drop, pass decision-making thresholds and you get WTF results, simply because the engine went WTF _first_.

Ditto story/drama for calligraphed signs outside shops, and, _oh! oh!, license plates_!! (google LPR/ALPR if you want any of that) and _anything else_ that's _not_ reams of text and thus you wouldn't expect to find in a plain story- or textbook.

(And for the detail-oriented folks: yes, tesseract had/has a module on board for recognizing math, but I haven't seen that work very well with my inputs and not seen a lot of happy noises out there about it either, but the Google engineer(s) surely must have anticipated OCRing that kind of stuff alongside paragraphs of text. For us mere mortals, I'ld consider this bit "an historic attempt" and forget about it.)

  

  

_Advice Number 2:_ when rendering page images, the ppi (pixels per inch) resolution to select would be best adjusted to produce regular lines of text in those images where the capital-height of the text is around 30 pixels. Typography people would rather like to refer to _x-height_, so that would be a little lower in pixel height. Line height would be larger as that includes stems and interline spacing. However, from an OCR engine perspective, these (x-height & line-height) are very much dependent of the font used and the page layout used, so they are more variable than the reported optimal capital-D-height at ~32px. As no-one measures this up-front, as an initial guess, 300dpi in the render/print-to-image dialog of your render tool of choice would be reasonable start but when you want more accuracy, tweaking this number can already bring some quality changes. Of course, when the source is (low rez) bitmap images already (embedded in PDF or otherwise), there's little you can do, but then there's still scaling, sharpening, etc. image preprocessing to try. This advice is driven by the results published here: [https://groups.google.com/g/tesseract-ocr/c/Wdh_JJwnw94/m/24JHDYQbBQAJ](https://groups.google.com/g/tesseract-ocr/c/Wdh_JJwnw94/m/24JHDYQbBQAJ) (and google already quickly produced one other who does something like that and published a small bit of tooling: [https://gist.github.com/rinogo/294e723ac9e53c23d131e5852312dfe8](https://gist.github.com/rinogo/294e723ac9e53c23d131e5852312dfe8) )

  

  

*) the old-fash way to see if a rusty engine will still go (or blow, alas). Replace with "SEO'd blog pages extolling instant success with ease" to take this into the 21st century.)

  

  

  

**The mandatory readings list:**

  

- [https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html](https://tesseract-ocr.github.io/tessdoc/ImproveQuality.html)

- [https://tesseract-ocr.github.io/tessdoc/](https://tesseract-ocr.github.io/tessdoc/)  

  

  

  

  

**The above in diagram form (suggested tesseract workflow ;-) )**

  

![diagram.png](https://groups.google.com/group/tesseract-ocr/attach/29504133fd94/diagram.png?part=0.0.1&view=1)  

(diagram PikChr source + SVG attached)

