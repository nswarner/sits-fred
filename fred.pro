#*******************************************************************************
# fred Copyright (c) 2024 by SITS Sarl                                         *
#                                                                              *
# Author(s):                                                                   *
#   Gillen Daniel <development@sits.lu>                                        *
#                                                                              *
# This program is free software: you can redistribute it and/or modify it      *
# under the terms of the GNU General Public License as published by the Free   *
# Software Foundation, either version 3 of the License, or (at your option)    *
# any later version.                                                           *
#                                                                              *
# This program is distributed in the hope that it will be useful, but WITHOUT  *
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or        *
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for     *
# more details.                                                                *
#                                                                              *
# You should have received a copy of the GNU General Public License along with *
# this program. If not, see <http://www.gnu.org/licenses/>.                    *
#*******************************************************************************

# Generate compileinfo.h
system(bash compileinfo.sh > compileinfo.h)
#compileinfo.target   = compileinfo.h
#compileinfo.commands = $$PWD/compileinfo.sh > compileinfo.h
#QMAKE_EXTRA_TARGETS += compileinfo
#PRE_TARGETDEPS      += compileinfo.h

# Check command line args
!isEmpty(HIVEX_STATIC) {
  DEFINES       += "HIVEX_STATIC"
}

# Configure fred
QMAKE_CXXFLAGS  += -Wall \
                   -I$$PWD

QT              += core \
                   widgets \
                   printsupport \
                   script

CONFIG          += console

TARGET           = fred

TEMPLATE         = app

SOURCES         += src/main.cpp \
                   src/mainwindow.cpp \
                   src/registrynode.cpp \
                   src/registrynodetreemodel.cpp \
                   src/registrykey.cpp \
                   src/registrykeytablemodel.cpp \
                   src/dlgabout.cpp \
                   src/qhexedit/qhexedit_p.cpp \
                   src/qhexedit/qhexedit.cpp \
                   src/reporttemplate.cpp \
                   src/registryhive.cpp \
                   src/qtscript_types/bytearray.cpp \
                   src/qtscript_types/bytearrayprototype.cpp \
                   src/qtscript_types/bytearrayiterator.cpp \
                   src/dlgreportviewer.cpp \
                   src/registrykeytable.cpp \
                   src/registrynodetree.cpp \
                   src/dlgsearch.cpp \
                   src/threadsearch.cpp \
                   src/searchresultwidget.cpp \
                   src/tabwidget.cpp \
                   src/argparser.cpp \
                   src/datainterpretertable.cpp \
                   src/datainterpreterwidget.cpp \
                   src/hexeditwidget.cpp \
                   src/settings.cpp \
                   src/searchresulttabledelegate.cpp \
                   src/registrynodetreemodelproxy.cpp \
                   src/reports.cpp \
                   src/reportengine.cpp \
                   src/dlgreportchooser.cpp \
                   src/dlgpreferences.cpp \
                   src/dlgaddkey.cpp

HEADERS         += src/mainwindow.h \
                   src/registrynode.h \
                   src/registrynodetreemodel.h \
                   src/registrykey.h \
                   src/registrykeytablemodel.h \
                   src/dlgabout.h \
                   src/qhexedit/qhexedit_p.h \
                   src/qhexedit/qhexedit.h \
                   src/reporttemplate.h \
                   src/registryhive.h \
                   src/qtscript_types/bytearray.h \
                   src/qtscript_types/bytearrayprototype.h \
                   src/qtscript_types/bytearrayiterator.h \
                   src/dlgreportviewer.h \
                   src/registrykeytable.h \
                   src/registrynodetree.h \
                   src/dlgsearch.h \
                   src/threadsearch.h \
                   src/searchresultwidget.h \
                   src/tabwidget.h \
                   src/argparser.h \
                   src/datainterpretertable.h \
                   src/datainterpreterwidget.h \
                   src/hexeditwidget.h \
                   src/settings.h \
                   src/searchresulttabledelegate.h \
                   src/registrynodetreemodelproxy.h \
                   src/reports.h \
                   src/reportengine.h \
                   src/dlgreportchooser.h \
                   src/dlgpreferences.h \
                   src/dlgaddkey.h

FORMS           += src/mainwindow.ui \
                   src/dlgabout.ui \
                   src/dlgreportviewer.ui \
                   src/dlgsearch.ui \
                   src/dlgreportchooser.ui \
                   src/dlgpreferences.ui \
                   src/dlgaddkey.ui

!isEmpty(HIVEX_STATIC) {
  LIBS          += $$PWD/src/hivex/lib/.libs/libhivex.a
} else {
  LIBS          += -lhivex
}

win32:LIBS      += -liconv
mac:LIBS        += -liconv

RESOURCES       += src/fred.qrc
RC_FILE          = src/fred.rc
ICON             = src/resources/fred.icns

DESTDIR = build
OBJECTS_DIR = $${DESTDIR}
MOC_DIR = $${DESTDIR}
RCC_DIR = $${DESTDIR}
UI_DIR = $${DESTDIR}

