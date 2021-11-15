FROM archlinux

WORKDIR /home/afiestas/Projects/

ENV KF5=/opt/kde5
ENV QTDIR=/opt/qt5
ENV LD_LIBRARY_PATH=/opt/kde5/lib:/opt/kde5/lib64:/opt/qt5/lib:/usr/lib
ENV XDG_DATA_DIRS=$KF5/share:$XDG_DATA_DIRS:/usr/share
ENV XDG_CONFIG_DIRS=$KF5/etc/xdg:$XDG_CONFIG_DIRS:/etc/xdg
ENV PATH=$KF5/bin:$KF5/usr/bin:$QTDIR/bin:$PATH
ENV QT_PLUGIN_PATH=$KF5/lib/plugins:$KF5/lib64/plugins:$KF5/lib/x86_64-linux-gnu/plugins:$QTDIR/plugins:$QT_PLUGIN_PATH
ENV QML2_IMPORT_PATH=$KF5/lib/qml:$KF5/lib64/qml:$KF5/lib/x86_64-linux-gnu/qml:$QTDIR/qml
ENV QML_IMPORT_PATH=$QML2_IMPORT_PATH
ENV KDE_SESSION_VERSION=5
ENV KDE_FULL_SESSION=true
ENV CMAKE_MODULE_PATH=/opt/kde5/share/:$CMAKE_MODULE_PATH

COPY pacman.conf /etc/pacman.conf

#RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
#    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
#    bsdtar -C / -xvf "$patched_glibc"

RUN pacman -Syu --noconfirm
RUN pacman -Sy --asdeps plasma-meta phonon-qt5-vlc krfb kdenlive kwave --noconfirm
RUN pacman -Sy git base-devel --noconfirm
RUN pacman -Sy --noconfirm \
                'python2' 'gperf' 'jsoncpp' 'ninja' 'python' 'vulkan-headers' \
                clang 'jasper' 'libmng' 'gst-plugins-bad' gst-plugins-good \
                gst-plugins-bad gst-plugins-ugly gst-libav assimp flite \
                speech-dispatcher hunspell hyphen woff2 cmake ruby 'libfbclient' \
                'mariadb-libs' 'unixodbc' 'postgresql-libs' 'gtk3' 'cups' 'freetds' \
                perl re2  'krb5' libgravatar boost perl-io-socket-ssl perl-yaml-syck python-sphinx \
                docbook-xsl doxygen libkdcraw sane ruby-test-unit swig xsd sassc python-cairo gtk2 \
                libraw llvm subversion astyle clang intltool libvncserver eigen freecell-solver    \
                python-sip python-pyqt5 quazip gsl vc opencolorio libheif sip libmtp qgpgme tinyxml2 \
                libdwarf libspectre libpwquality meson cppcheck xf86-input-evdev xf86-input-libinput \
                xorg-server-devel



RUN mkdir -p /opt/kde5 /opt/qt5 /home/afiestas/Projects/ /home/afiestas/Projects/kde5 /usr/lib/libffi-3.2.1/include

COPY build-qt /usr/bin/
COPY build-kde /usr/bin/
