QT -= gui

QT += quick



CONFIG += c++17
#QT += network
QT += websockets

#CONFIG += c++17 console
#CONFIG -= app_bundle
MOC_DIR     += generated/mocs
UI_DIR      += generated/uis
RCC_DIR     += generated/rccs
OBJECTS_DIR += generated/objs


# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

DEFINES += QT_DEPRECATED_WARNINGS



SOURCES += \
        Modlogic.cpp \
        backend.cpp \
        main.cpp

RESOURCES += qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Modlogic.h \
    backend.h \
    modbus_exception.h

DISTFILES += \
    Description \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml


RESOURCES += \
    qml.qrc

ANDROID_ABIS = armeabi-v7a

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
