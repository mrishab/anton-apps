#
# Use a temporary image to compile and test the libraries
#
FROM nextcloud:29.0.0-apache as builder
# Build and install dlib on builder
#
RUN apt-get update ; \
    apt-get install -y build-essential wget cmake libx11-dev libopenblas-dev

ARG DLIB_BRANCH=v19.19
RUN wget -c -q https://github.com/davisking/dlib/archive/$DLIB_BRANCH.tar.gz \
    && tar xf $DLIB_BRANCH.tar.gz \
    && mv dlib-* dlib \
    && cd dlib/dlib \
    && mkdir build \
    && cmake -S .. -B build -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release \
    && cd build \
    && make \
    && make install

# Build and install PDLib on builder
ARG PDLIB_BRANCH=master
RUN apt-get install unzip
RUN wget -c -q https://github.com/matiasdelellis/pdlib/archive/$PDLIB_BRANCH.zip \
    && unzip $PDLIB_BRANCH \
    && mv pdlib-* pdlib \
    && cd pdlib \
    && phpize \
    && ./configure \
    && make \
    && make install

# Enable PDlib on builder

# If necesary take the php settings folder uncommenting the next line
# RUN php -i | grep "Scan this dir for additional .ini files"
RUN echo "extension=pdlib.so" > /usr/local/etc/php/conf.d/pdlib.ini

# Install bzip2 needed to extract models

RUN apt-get install -y libbz2-dev
RUN docker-php-ext-install bz2

# Test PDlib instalation on builder

RUN apt-get install -y git
RUN git clone https://github.com/matiasdelellis/pdlib-min-test-suite.git \
    && cd pdlib-min-test-suite \
    && make

#
# If pass the tests, we are able to create the final image.
#
FROM nextcloud:29.0.0-apache

# Install dependencies to image

RUN apt-get update ; \
    apt-get install -y libopenblas-dev

# Install dlib and PDlib to image

COPY --from=builder /usr/local/lib/libdlib.so* /usr/local/lib/

# If is necesary take the php extention folder (/usr/local/lib/php/extensions/no-debug-non-zts-20180731) uncommenting the next line
# RUN php -i | grep extension_dir
COPY --from=builder /usr/local/lib/php/extensions/no-debug-non-zts-20220829/pdlib.so /usr/local/lib/php/extensions/no-debug-non-zts-20220829/

# Enable PDlib on final image
RUN echo "extension=pdlib.so" > /usr/local/etc/php/conf.d/pdlib.ini

# Increse memory limits
RUN echo memory_limit=1024M > /usr/local/etc/php/conf.d/memory-limit.ini

# Pdlib is already installed now on final image without all build dependencies.
# You could test again if everything is correct, uncommenting the next lines.
#
# RUN apt-get install -y git wget
# RUN git clone https://github.com/matiasdelellis/pdlib-min-test-suite.git \
#    && cd pdlib-min-test-suite \
#    && make

#
# At this point you meet all the dependencies to install the application
# You can skip this step and install the application from the application store
#
ARG FR_BRANCH=master
ENV PHP_MEMORY_LIMIT=2048M
RUN apt-get install -y wget unzip nodejs npm
RUN wget -c -q -O facerecognition https://github.com/matiasdelellis/facerecognition/archive/$FR_BRANCH.zip \
  && unzip facerecognition \
  && mv facerecognition-*  /usr/src/nextcloud/facerecognition \
  && cd /usr/src/nextcloud/facerecognition \
  && sed -i 's/webpack --node-env production/NODE_ENV=production webpack/g' package.json \
  && sed -i 's/webpack --node-env development/NODE_ENV=development webpack/g' package.json \
  && npm ci \
  && make
