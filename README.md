# sits-fred

TLDR: If you ended up here, you likely want [the `fred` build process for Mac, section 3.0](https://github.com/nswarner/sits-fred#30-addendum-building-on-macos-with-homebrew-unofficial).

This is a fork of the SITS fred software after updating the software to run on Apple Silicon Macs 27.0.1. If you're unfamiliar with fred, please see https://www.sits.lu/fred. I will not be updating this software beyond what exists here, you are welcome to fork it and continue with upstream updates.

All credit for the creation of fred software goes to the original creator(s) and current maintainer(s). This was a minimal effort to get fred to work again on Mac after support for Mac was dropped in the 1.0.0 release. 

I am preserving the content of the older README, only noting that the sections 2.1.2 and 2.3.3 are deprecated, and that the proper build information for Apple Silicon Macs is located in 3.0 onward. The 1.0.0 release from SITS did not include a Mac binary, nor did the build scripts support the "mac" platform. That is why you'll notice manually building with qmake rather than the autogen script. All information provided for 3.0 has been tested on the following system:

* M4 Mac Air
* Mac OS 27.0.1
* XCode Command Line Tools Version: 27.0.0.0.1788430756
* Homebrew qt@5 5.15.19 (deprecated, Homebrew will be disabling this in 2027)
* Homebrew Hivex 1.3.25
* Homebrew ocaml 5.5.2
* Homebrew pkgconf 3.0.10
* Homebrew autoconf 1.20
* Homebrew libtool 2.6.2
* Homebrew gettext 1.0

Anything needed outside of this was previously installed.


# Table of contents

* 0.0 Author and license stuff
* 0.1 Used external libraries
* 1.0 What is fred? - A short description
* 2.0 Installation instructions
  * 2.1 Prerequisits
    * 2.1.1 Linux
    * 2.1.2 Mac OSX (Deprecated, see section 3)
    * 2.1.3 Windows
  * 2.2 Installing a prebuild binary package
  * 2.3 Installing from source
    * 2.3.1 Shared vs static libhivex
    * 2.3.2 Linux
      * 2.3.2.1 Prerequisites
      * 2.3.2.2 Compilation and installation
    * 2.3.3 Mac OSX (Deprecated, see section 3)
      * 2.3.3.1 Prerequisites
      * 2.3.3.2 Compiling
    * 2.3.4 Crosscompiling for Windows
      * 2.3.4.1 Prerequisites
        * 2.3.4.1.1 Compiler
        * 2.3.4.1.2 Qt
      * 2.3.4.2 Compiling
* 3.0 Addendum: Building on macOS with Homebrew (unofficial)
* 3.1 Modifications
* 3.2 Tested Configuration
* 3.3 Important Note on QT5
* 3.4 Build
* 3.5 Report Templates 

# 0.0 Author and license stuff
  fred Copyright (c) 2024 by SITS Sarl

  Author(s):
    Gillen Daniel <development@sits.lu>

  This program is free software: you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free Software
  Foundation, either version 3 of the License, or (at your option) any later
  version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along with
  this program. If not, see <http://www.gnu.org/licenses/>.

## 0.1 Used external libraries
  fred relies on various other external open source libraries:

  --- hivex

    Copyright (C) 2009-2010 Red Hat Inc.
    Derived from code by Petter Nordahl-Hagen under a compatible license:
    Copyright (C) 1997-2007 Petter Nordahl-Hagen.
    Derived from code by Markus Stephany under a compatible license:
    Copyright (C) 2000-2004 Markus Stephany.

  --- QHexEdit

    Copyright (c) 2010 by Simon Winfried

  --- Qt

    Copyright (C) 2020 The Qt Company Ltd and other contributors.

# 1.0 What is fred? - A short description
  Forensic Registry EDitor (fred) is a cross-platform M$ registry hive editor.
  This project was born out of the need for a reasonably good registry hive
  viewer for Linux to conduct forensic analysis. Therefore it includes some
  functions not found in normal "free" registry editors like a hex viewer with
  data interpreter and a reporting function that can easily be extended with
  custom ECMAScript report templates.

# 2.0 Installation instructions

## 2.1 Prerequisits
    If you are not going to use our prebuild packages, in addition to the
    prerequisits below you probably will also need Richard W.M. Jones's libhivex
    available from https://github.com/libguestfs/hivex.

### 2.1.1 Linux
      Any Linux with Qt v5.x libraries.

### 2.1.2 Mac OSX (Deprecated, see section 3)
      OSX v10.5 or above with Qt v5.x libraries.

### 2.1.3 Windows
      Windows XP or newer with Qt v5.x libraries.

## 2.2 Installing a prebuild binary package
    Chances are we provide prebuild binary packages for your OS (generally
    Debian/Ubuntu, Mac OSX and Windows). If so, you can simply download them
    from https://www.sits.lu/fred.

    For Debian/Ubuntu, add our repository (https://www.sits.lu/repository) and
    execute the following command:

    $ sudo apt-get install fred fred-reports

    For Mac OSX and Windows, execute the installer and follow the on-screen
    instructions.

    If we have no prebuild binary packages for your OS, you will have to compile
    fred by yourself. In this case, read the instructions under "Installing from
    source".

## 2.3 Installing from source
    NOTE: Any Windows / OSx instructions below are from an older release and
          will probably not work anymore with the current one. Once we have
          updated our build scripts for these platforms, we will update the
          instructions below.

    Start by getting the source code from https://code.sits.lu/foss/fred and
    unpack it to some temporary directory. Under Linux and Mac OSX, use:

    $ cd /some/temp/dir/
    $ tar xfvz fred-x.x.x.tar.gz

    Under Windows, use 7zip or alike to decompress the tar.gz file.

### 2.3.1 Shared vs static libhivex
      When compiling fred from source, you have two possibilities how to include
      libhivex. When using Linux, chances are your distribution has a package
      for it available. In this case, you may install the binary and developper
      version of it and go ahead to build fred. If your distribution has no
      libhivex package available (Mac OSX and Windows definitely haven't), or
      you want to use the latest version of it available that might fix some
      bugs, make sure you use the "--static-hivex" command line option when
      running my bootstrap.sh script. This will checkout, compile and statically
      link the latest libhivex compatible with fred while building.

### 2.3.2 Linux

#### 2.3.2.1 Prerequisites
        $ sudo apt install qtbase5-dev qtscript5-dev qtwebengine5-dev \
          qtpositioning5-dev libhivex-dev qttools5-dev-tools

#### 2.3.2.2 Compilation and installation
        Compiling under Linux for Linux should be very simple. Just execute the
        following commands:

        $ cd /path/to/fred/source/
        $ ./autogen.sh --platform=linux
        $ make install

        Or, if you want to use the static libhivex:

        $ cd /path/to/fred/source/
        $ ./autogen.sh --static-hivex --platform=linux
        $ make install

### 2.3.3 Mac OSX (Deprecated, see section 3)

Section kept for historical record, but section is deprecated. See section 3.0
to build on Apple Silicon Mac.

      NOTE: Any Windows / OSx instructions below are from an older release and
          will probably not work anymore with the current one. Once we have
          updated our build scripts for these platforms, we will update the
          instructions below.

#### 2.3.3.1 Prerequisites
        In order to compile fred under Mac OSX, you need to install the
        following software:

        - XCode from Apple
        - Git from http://code.google.com/p/git-osx-installer/
        - MacPorts from http://www.macports.org
        - Qt 5.x library from http://qt-project.org

        Aditionally, after installing MacPorts, install the following packages:

        $ sudo port install ocaml libxml2 pkgconfig autoconf gettext

#### 2.3.3.2 Compiling
        Compilation should be straight forward executing the following command:

        $ cd /path/to/fred/source/
        $ ./autogen.sh --static-hivex --platform=mac

### 2.3.4 Crosscompiling for Windows
      NOTE: Any Windows / OSx instructions below are from an older release and
          will probably not work anymore with the current one. Once we have
          updated our build scripts for these platforms, we will update the
          instructions below.

#### 2.3.4.1 Prerequisites
        The following instructions are for Debian / Ubuntu like distros. If you
        are using another distro, you will need to get the compiler and Qt on
        your own.

##### 2.3.4.1.1 Compiler
          You need the mingw-w64 gcc and g++ compiler. When using Debian/Ubuntu
          install the following packages:

          $ sudo apt-get install mingw-w64 mingw-w64-tools g++-mingw-w64 \
            gcc-mingw-w64 mingw-ocaml autopoint

##### 2.3.4.1.2 Qt
          After you have a compiler, you will need to crosscompile Qt as it is
          currently not available as package. Start by getting the source:

          $ cd /some/temp/dir/
          $ QTU="http://download.qt-project.org/archive/qt/4.8/4.8.4"
          $ QTP="qt-everywhere-opensource-src-4.8.4"
          $ wget $QTU/$QTP.tar.gz
          $ tar xfvz $QTP.tar.gz
          $ cd $QTP

          Unfortunately, Qt won't build until you apply three small patches:

          $ SRC="/path/to/fred/source/qt_patches"
          $ patch -p1 <"$SRC/mingw32-qt-4.8.0-no-webkit-tests.patch"
          $ patch -p1 <"$SRC/qt-4.8.4-fix-sse-suppport-build-regression.patch"
          $ patch -p1 <"$SRC/qt-4.8.0-fix-include-windows-h.patch"

          Now configure, compile and install Qt:

          $ sudo ./configure -prefix /opt/qt-4.8.4-mingw -opensource \
                             -no-qt3support -no-multimedia -no-audio-backend \
                             -no-phonon -no-phonon-backend -no-javascript-jit \
                             -nomake examples -nomake demos -nomake docs \
                             -xplatform win32-g++-4.6 \
                             -device-option CROSS_COMPILE=i686-w64-mingw32-
          $ sudo make
          $ sudo make install

#### 2.3.4.3 LIBXML2
        $ wget ftp://xmlsoft.org/libxml2/libxml2-2.9.1.tar.gz
        $ tar xfvz libxml2-2.9.1.tar.gz
        $ cd libxml2-2.9.1/
        $ ./configure --prefix /opt/libxml2-2.9.1-mingw --host i686-w64-mingw32 --without-python
        $ make
        $ sudo make install

#### 2.3.4.3 Compiling
        If all the above worked, you are ready to crosscompile fred:

        $ cd /path/to/fred/source/
        $ cd hivex/gnulib; patch -p1 <../../hivex_patches/gnulib.patch; cd -
        $ ./autogen.sh --static-hivex --platform=win32

        The build process of hivex will probably complain and might even fail
        with an error but normally the lib gets build before that without errors,
        so just ignore it.

# 3.0 Addendum: Building on macOS with Homebrew (unofficial)

NOTE: This addendum was added to a modified copy of fred and is not part of the official SITS release. Section 2.3.3 above describes an older process that no longer works: autogen.sh does not support '--platform=mac'. Use the steps below instead.

## 3.1 Modifications

This copy of fred was modified by Nicholas Stephen Warner on 2026-11-12 so that it builds against Qt 5.15 as packaged by Homebrew:

* The report viewer (src/dlgreportviewer.*) uses QTextBrowser instead of QWebEngineView, because Homebrew's qt@5 no longer ships QtWebEngine. Reports are shown as basic HTML; JavaScript and advanced CSS in report output are not supported.
* fred.pro no longer requests the "webenginewidgets" Qt module.

## 3.2 Tested configuration

Apple Silicon Mac, Xcode Command Line Tools, Homebrew qt@5 5.15.19 and Homebrew hivex.

## 3.3 Important: Qt 5 is end-of-life

Qt 5 is no longer supported upstream. Homebrew has deprecated the qt@5 formula and, according to "brew info qt@5", will disable it on 2027-05-19. After that date it can no longer be installed with brew, so install it beforehand. An already installed copy should keep working. Pinning prevents "brew upgrade" from changing it:

```BASH
brew pin qt@5
```

Porting fred to Qt 6 is not trivial: the report engine relies on QtScript, which was removed in Qt 6. I will not be performing this work.

## 3.4 Build

1. Install the prerequisites:

```BASH
xcode-select --install
brew install qt@5 hivex ocaml libxml2 pkgconf autoconf automake libtool gettext
```

2. Put Qt 5's qmake first in your PATH (qt@5 is "keg-only", so Homebrew does not link it for you) and locate hivex:

```BASH
export PATH="$(brew --prefix qt@5)/bin:$PATH"
HIVEX="$(brew --prefix hivex)"
qmake --version
```

The last command must report Qt version 5.15.x.

3. Configure and build from the fred source directory. Do not use autogen.sh on macOS:

```BASH
qmake fred.pro "INCLUDEPATH+=$HIVEX/include" "LIBS+=-L$HIVEX/lib"
make -j"$(sysctl -n hw.ncpu)"
```

The application is created as build/fred.app. These warnings can be ignored: "The selected platform is no longer supported by libc++" and "linking with dylib ... which was built for newer version". Generally, it should build properly despite plenty of warnings. I will not be fixing the warnings.

4. Run it:

```BASH
open build/fred.app
```

The app links against Homebrew's Qt and hivex, so it only runs while those remain installed. To start over, run "make distclean".

## 3.5 Report templates

The build does not install the report templates, so the "Generate report" dialog is empty at first. Copy them to fred's default user location:

```BASH
mkdir -p ~/.fred/report_templates
cp -R report_templates/. ~/.fred/report_templates/
```

Alternatively, add the report_templates folder of the source tree under Preferences > Reports. Reopen the "Generate report" dialog afterwards.

