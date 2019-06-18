OPENCV_VERSION='4.1.0'

mkdir -p ~/opencv
pushd ~/opencv

curl -sLO https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
unzip -qqo ${OPENCV_VERSION}.zip
rm -f ${OPENCV_VERSION}.zip
mv opencv-${OPENCV_VERSION} OpenCV
cd OpenCV
mkdir build
cd build
cmake \
  -D BUILD_LIST=core,imgproc,imgcodecs \
  -D CMAKE_BUILD_TYPE=Release \
  -D OPENCV_GENERATE_PKGCONFIG=YES \
  -D WITH_CSTRIPES=OFF \
  -D WITH_PTHREADS_PF=OFF \
  -D WITH_QT=OFF \
  -D WITH_OPENGL=OFF \
  -D WITH_OPENCL=OFF \
  -D WITH_OPENMP=OFF \
  -D WITH_TBB=ON \
  -D WITH_GDAL=ON \
  -D WITH_XINE=ON \
  -D BUILD_DOCS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF \
  -D ENABLE_PRECOMPILED_HEADERS=OFF \
  -D WITH_IPP=ON \
  -D CPU_BASELINE=NATIVE \
  -D ENABLE_FAST_MATH=ON \
  .. | tee install_cv4.log
make -j $(nproc --all)
sudo make install
sudo ldconfig
popd