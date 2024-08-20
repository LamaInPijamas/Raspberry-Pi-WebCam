Stream video using Raspberry Pi and USB Webcam.

Fundamentals: MJPEG Streamer - MJPG-Streamer is a command-line application that copies JPEG frames from one or more input plugins to multiple output plugins. It can be used to stream JPEG files over an IP-based network from a webcam to various types of viewers such as Chrome, Firefox, Cambozola, VLC, mplayer, and other software capable of receiving MJPG streams.

How to set up:

Step 1 - make sure your raspberry is up to date. 
```
sudo apt-get update
```
Step 2 - Installing the packages.

Install the libjpeg8-dev package that contains the development files for the JPEG library version 8, which are necessary for compiling software that relies on JPEG image processing.
```
sudo apt-get install libjpeg8-dev
```

The ImageMagick package is a powerful software suite used for creating, editing, converting, and displaying bitmap images. It supports a wide range of image formats, making it a versatile tool for image processing tasks.
```
sudo apt-get install imagemagick
```

The libv4l-dev package provides the development files for the libv4l library, which is a collection of libraries that allow for video capturing through the Video4Linux (V4L) API. Here’s a breakdown of what this package is and what it does:
```
sudo apt-get install libv4l-dev
```

The libjpeg-dev package provides the development files for the JPEG image library.
```
sudo apt-get install libjpeg-dev
```

CMake is an open-source, cross-platform build system generator. It is used to manage the build process of software projects.
```
sudo apt-get install cmake
```
Step 3 - Download, install and set mjepg. 
```
wget https://github.com/jacksonliam/mjpg-streamer/archive/master.zip
```

```
unzip master.zip
```
```
cd mjpg-streamer
```
```
cd mjpg-streamer-experimental
```
```
make clean all
```
```
sudo make install
```
Step 4 - Camera and MJPEG configuration.

First check if your webcam is supported on Raspberry Pi 

```
 ls -al /dev/ |grep video
```

If so , we can start streaming images using mjpeg. 
```
*In the mjepg mjpg-streamer-experimental dir.*
```
```
./mjpg_streamer -i "/usr/local/lib/mjpg-streamer/input_uvc.so -y -d /dev/video0 -n -f 6 -r 640x480" -o "/usr/local/lib/mjpg-streamer/output_http.so -p 8084 -w /usr/local/share/mjpg-streamer/www"
```

Note: If your webcam device is not set to be on /dev/video0 by default, you will need to specify which output it’s on. Run the following command and change it to your needs (e.g., /dev/video2, /dev/video3).
```
./mjpg_streamer -i "/usr/local/lib/mjpg-streamer/input_uvc.so -y -d /dev/video2 -n -f 6 -r 640x480" -o "/usr/local/lib/mjpg-streamer/output_http.so -p 8085 -w /usr/local/share/mjpg-streamer/www"
```

Step 5 - Install Ruby on Rails (RoR).

Ruby on Rails requires several dependencies. Install them with the following command:
```
sudo apt install -y curl git nodejs libsqlite3-dev build-essential libssl-dev libreadline-dev zlib1g-dev libyaml-dev libcurl4-openssl-dev libffi-dev
```
Install a Ruby Version Manager (RVM or rbenv) - (used RVM in this project)
```
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
```
After installing RVM, you need to install Ruby:
```
rvm install 3.2.2
rvm use 3.2.2 --default
```

Step 6 - Clone this repo and set it up on your raspberry.

Step 7 - All done. Now just run the server with 
```
rails s
```
You can access the live camera feed on "home" page , and stats of yours raspberry on "stats" page. 


BUG FIXES:
If you encounter this error: 
```
To allow requests to these hosts, make sure they are valid hostnames (containing only numbers, letters, dashes and dots), then add the following to your environment configuration:
config.hosts << "raspberrypi.local:3000"
```
The message you’re seeing is a part of Rails’ security feature that prevents Host Header attacks. When you try to access your Rails application using a hostname or IP address that isn’t explicitly allowed, Rails will block the request by default. To allow requests to raspberrypi.local:3000, you need to add this hostname to your application’s configuration.
 ```
nano config/environments/development.rb
```
Scroll to the bottom of the file (or anywhere appropriate) and add the following line:
```
config.hosts << "raspberrypi.local:3000"
```