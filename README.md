# List of time series augmentation methods

| Group | Augmentor Name | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Short&nbsp;description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Parameters&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | reversible | random | changing TS length | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Example&nbsp;(click&nbsp;to&nbsp;enlarge)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
| :-- | :----------- | :-------------- | :------- | :------: | :--: | :--------------: | :---: |
|value|Outliers|Augmenter adds outliers using a Bernoulli process and substitutes the affected samples by user defined values.|p, substitute|no|yes|no|![image outliers](Add_outliers.png)|
|value|WhiteNoise|Augmenter adding Gaussian (i.e. white) noise to each time series.|standard deviation of noise|no|yes|no|![image white noise](White_noise.png)|
|value|Noise| |noise distribution description|no|yes|no|![Outliers](Noise.png)|
|value|Invert|Augmenter inverting the time series (i.e. multiply each value with -1).| |yes|no|no|![image invert](Invert.png)|
|value|Scale|Augmenter scaling the time series by a constant factor.|scale factor|yes|no|no|![image scale](Scale.png)|
|value|Offset|Augmenter adding a constant offset to the time series.|offset|yes|no|no|![image offset](Offset.png)|
|value|Drift|Augmenter adding a random Wiener Process to time series.|standard deviation of Wiener process|no|yes|no|![image drift](Drift.png)|
|value|Clip|Augmenter clipping the time series between definable min and max values.|standard deviation of Wiener process|no|no|no|![image clip](Clip.png)|
|value|Quantize|Augmenter quantizes time series (down) to defined resolution.|standard deviation of Wiener process|no|no|no|![image quantize](Quantize.png)|
|value|RandomDowntime| |downtime percentage, mean and standard deviation of a downtime's duration, substitute|no|yes|no|![image random Drift](Random_downtime.png)|
