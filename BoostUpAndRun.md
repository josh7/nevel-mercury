

This page was based on the tutorial of [Matt Galloway](http://iphone.galloway.me.uk/2010/09/compiling-boost-1-44-for-iphone/). Thanks :-)

## Introduction ##

Q: What's boost?
A: This wiki page may not fit for you. Just go to [Boost](http://www.boost.org).

Boost library includes two separate parts: Header only and separately-compiled. You can include header-only files into your program directly. Separately-compiled files needs to be compiled and static linked into iOS apps manually.

## About version ##

The lastest version of boost is 1.46.1, this tutorial is based on boost 1.44 and XCode 4 or higher. You can get all releases of boost library from [here](http://www.boost.org/users/history/).

Note:

I have tried to compile higher version of boost by the approach provided in this tutorial and got some compiling errors. These may due to some new features that g++ 4.2 cannot support. But it doesn't affects those libraries which are build successfully.

## Edit the compiling profile ##

Create a customized bjam configuration file in your home folder to include the following:

```
using darwin : 4.3~iphone
   : /Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc-4.2 -arch armv7 -mthumb -fvisibility=hidden -fvisibility-inlines-hidden
   : <striper>
   : <architecture>arm <target-os>iphone
   ;
 
using darwin : 4.3~iphonesim
   : /Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc-4.2 -arch i386 -fvisibility=hidden -fvisibility-inlines-hidden
   : <striper>
   : <architecture>x86 <target-os>iphone
   ;
```

Bjam will build libraries for both iphone simulator and device.

## Build boost libraries ##
Then, follow these steps to install:

```
tar xvzf boost_1_44_0.tar.gz
cd boost_1_44_0
./bootstrap.sh
```

This will build the bjam tool fit for our environment. Then, set the SDK\_VERSION:

```
export SDK_VERSION="4.3"
```

Execute the following command to install libraries for device:

```
./bjam --prefix=${HOME}/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDK_VERSION}.sdk/usr toolset=darwin architecture=arm target-os=iphone macosx-version=iphone-${SDK_VERSION} define=_LITTLE_ENDIAN link=static install
```

Execute the following command to install libraries for simulator:

```
./bjam --prefix=${HOME}/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${SDK_VERSION}.sdk/usr toolset=darwin architecture=x86 target-os=iphone macosx-version=iphonesim-${SDK_VERSION} link=static install
```

Here, all libraries should be build successfully. You can find them at

```
${HOME}/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS${SDK_VERSION}.sdk/usr/lib
```

for device and

```
${HOME}/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator${SDK_VERSION}.sdk/usr/lib
```

for simulator.


**NOTE:**

Not all separately compiled libraries of boost could be build for iOS (Due to hardware reasons? I don't know), even the libraries fit for simulator, might not be run on device.

## Configure in the XCode ##

We must add header search path and library to make boost up and run.

In project **Build Settings**, add header and libraries search:

![http://www.kerneldiy.com/images/boost_header_path.png](http://www.kerneldiy.com/images/boost_header_path.png)

These search path are non-recursive.

For those separately compiled libraries, add them into XCode manually:

![http://www.kerneldiy.com/images/boost_complied_lib.png](http://www.kerneldiy.com/images/boost_complied_lib.png)

## Try it ##

Click [here](http://www.kerneldiy.com/files/asio.zip) to download a simple boost asio demo project to test whether boost can work well with your environment. Good luck
:-)