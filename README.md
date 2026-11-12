# sits-fred
This is a fork of the SITS fred software after updating the software to run on Apple Silicon Macs 27.0.1. If you're unfamiliar with fred, please see https://www.sits.lu/fred

3.0 Addendum: Building on macOS with Homebrew (unofficial)
  NOTE: This addendum was added to a modified copy of fred and is not part of
        the official SITS release. Section 2.3.3 above describes an older
        process that no longer works: autogen.sh does not support
        '--platform=mac'. Use the steps below instead.

  3.1 Modifications
    This copy of fred was modified by <YOUR NAME> on 2026-11-12 so that it
    builds against Qt 5.15 as packaged by Homebrew:

    - The report viewer (src/dlgreportviewer.*) uses QTextBrowser instead of
      QWebEngineView, because Homebrew's qt@5 no longer ships QtWebEngine.
      Reports are shown as basic HTML; JavaScript and advanced CSS in report
      output are not supported.
    - fred.pro no longer requests the "webenginewidgets" Qt module.

  3.2 Tested configuration
    Apple Silicon Mac, Xcode Command Line Tools, Homebrew qt@5 5.15.19 and
    Homebrew hivex.

  3.3 Important: Qt 5 is end-of-life
    Qt 5 is no longer supported upstream. Homebrew has deprecated the qt@5
    formula and, according to "brew info qt@5", will disable it on
    2027-05-19. After that date it can no longer be installed with brew, so
    install it beforehand. An already installed copy should keep working.
    Pinning prevents "brew upgrade" from changing it:

    $ brew pin qt@5

    Porting fred to Qt 6 is not trivial: the report engine relies on
    QtScript, which was removed in Qt 6.

  3.4 Build
    1. Install the prerequisites:

       $ xcode-select --install
       $ brew install qt@5 hivex

    2. Put Qt 5's qmake first in your PATH (qt@5 is "keg-only", so Homebrew
       does not link it for you) and locate hivex:

       $ export PATH="$(brew --prefix qt@5)/bin:$PATH"
       $ HIVEX="$(brew --prefix hivex)"
       $ qmake --version

       The last command must report Qt version 5.15.x.

    3. Configure and build from the fred source directory. Do not use
       autogen.sh on macOS:

       $ qmake fred.pro "INCLUDEPATH+=$HIVEX/include" "LIBS+=-L$HIVEX/lib"
       $ make -j"$(sysctl -n hw.ncpu)"

       The application is created as build/fred.app. These warnings can be
       ignored: "The selected platform is no longer supported by libc++" and
       "linking with dylib ... which was built for newer version".

    4. Run it:

       $ open build/fred.app

       The app links against Homebrew's Qt and hivex, so it only runs while
       those remain installed. To start over, run "make distclean".

  3.5 Report templates
    The build does not install the report templates, so the "Generate
    report" dialog is empty at first. Copy them to fred's default user
    location:

       $ mkdir -p ~/.fred/report_templates
       $ cp -R report_templates/. ~/.fred/report_templates/

    Alternatively, add the report_templates folder of the source tree under
    Preferences > Reports. Reopen the "Generate report" dialog afterwards.
