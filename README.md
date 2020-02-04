# SwiftCV

Minimal Swift for TensorFlow OpenCV4 bindings, partially ported from [gocv](https://github.com/hybridgroup/gocv).

OpenCV Functions exposed:
 * resize
 * getRotationMatrix2D
 * warpAffine
 * copyMakeBorder
 * GaussianBlur
 * remap
 * imdecode
 * imread
 * cvtColor
 * flip
 * transpose
 * VideoCapture (Not supported on Colab)
 * ImShow (Not supported on Colab)
 * WaitKey
 
OpenCV's `Mat` can be converted to S4TF's `Tensor` and `ShapedArray` types. 
 
See [`Extra/Tests.ipynb`](Extra/Tests.ipynb) and [`Tests`](Tests/SwiftCVTests/SwiftCVTests.swift) as an example of usage.

Try demo [notebook in Colab](https://colab.research.google.com/github/vvmnnnkv/SwiftCV/blob/master/Extra/Tests.ipynb).

## Usage
### Installation
Include as SwiftPM package:

```swift
.package(url: "https://github.com/vvmnnnkv/SwiftCV.git", .branch("master"))
```

In a Jupyter Notebook:

```swift
%system curl -sL https://github.com/vvmnnnkv/opencv-colab/raw/master/opencv4.tar.gz | tar zxf - -C / && ldconfig /opt/opencv-4.1.0/lib/ && ln -s /opt/opencv-4.1.0/lib/pkgconfig/opencv4.pc /usr/lib/pkgconfig/opencv4.pc

%install-location $cwd/swift-packages
%install '.package(url: "https://github.com/vvmnnnkv/SwiftCV.git", .branch("master"))' SwiftCV
```

> **NOTE: OpenCV4 must installed in order for package to compile.**

Run the `install/install_cv4.sh` script ([written by Jeremy Howard](https://github.com/fastai/course-v3/blob/master/nbs/swift/SwiftCV/install/install_cv4.sh)) to install opencv4.

### API
#### Loading an image
```swift
// load image in memory
let url = "https://live.staticflickr.com/2842/11335865374_0b202e2dc6_o_d.jpg"
let imgContent = Data(contentsOf: URL(string: url)!)

// make opencv image
var cvImg = imdecode(imgContent)
// convert color scheme to RGB
cvImg = cvtColor(cvImg, nil, ColorConversionCode.COLOR_BGR2RGB)
show_img(cvImg)
```

#### Rotate

```swift
resize(cvImg, nil, Size(100, 50), 0, 0, InterpolationFlag.INTER_AREA)
```

#### Zoom / Crop

```swift
let zoomMat = getRotationMatrix2D(Size(cvImg.cols, cvImg.rows / 2), 0, 2)
warpAffine(cvImg, nil, zoomMat, Size(600, 600))
```

#### Rotate

```swift
let rotMat = getRotationMatrix2D(Size(cvImg.cols / 2, cvImg.rows / 2), 20, 1)
warpAffine(cvImg, nil, rotMat, Size(cvImg.cols, cvImg.rows))
```

#### Pad

```swift
copyMakeBorder(cvImg, nil, 40, 40, 40, 40, BorderType.BORDER_CONSTANT, RGBA(0, 127, 0, 0))
```

#### Blur

```swift
GaussianBlur(cvImg, nil, Size(25, 25))
```

#### Flip

```swift
flip(cvImg, nil, FlipMode.HORIZONTAL)
```

#### Transpose

```swift
transpose(cvImg, nil)
```

#### Viewing webcam

```swift
let cap = VideoCapture(0)
// Optional, reduces latency a bit
cap.set(VideoCaptureProperties.CAP_PROP_BUFFERSIZE, 1)

let frame = Mat()

while true {
    cap.read(into: frame)
    ImShow(image: frame)
    WaitKey(delay: 1)
}
```

#### Lightning / Contrast

> This requires [Swift for TensorFlow](https://github.com/tensorflow/swift).
```swift
// convert image to floats Tensor
var imgTens = Tensor<Float>(Tensor<UInt8>(cvMat: cvImg)!) / 255
let contr:Float = 1.8
let lightn:Float = 0.2
let mean = imgTens.mean()
imgTens = (imgTens - mean) * contr + mean + lightn
```

#### Noise
> This requires [Swift for TensorFlow](https://github.com/tensorflow/swift).
```swift
// convert image to Tensor
var imgTens = Tensor<Float>(Tensor<UInt8>(cvMat: cvImg)!) / 255
let randTens = Tensor<Float>(randomNormal: imgTens.shape) * 0.1
imgTens += randTens
```

## Disclaimer
Currently this package is just an example of OpenCV/S4TF integration with no safety checks and guarantees to work properly :)

## License
OpenCV C API, (c) Copyright [gocv](https://github.com/hybridgroup/gocv) authors. 
