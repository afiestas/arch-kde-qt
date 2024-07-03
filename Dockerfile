FROM archlinux:latest

WORKDIR /home/afiestas/Projects/

ENV KF6=/opt/kde6
ENV QTDIR=/opt/qt6
ENV LD_LIBRARY_PATH=/opt/kde6/lib:/opt/kde6/lib64:/opt/qt6/lib:/usr/lib
ENV XDG_DATA_DIRS=$KF6/share:$XDG_DATA_DIRS:/usr/share
ENV XDG_CONFIG_DIRS=$KF6/etc/xdg:$XDG_CONFIG_DIRS:/etc/xdg
ENV PATH=$KF6/bin:$KF6/usr/bin:$QTDIR/bin:$PATH
ENV QT_PLUGIN_PATH=$KF6/lib/plugins:$KF6/lib64/plugins:$KF6/lib/x86_64-linux-gnu/plugins:$QTDIR/plugins:$QT_PLUGIN_PATH
ENV QML2_IMPORT_PATH=$KF6/lib/qml:$KF6/lib64/qml:$KF6/lib/x86_64-linux-gnu/qml:$QTDIR/qml
ENV QML_IMPORT_PATH=$QML2_IMPORT_PATH
ENV KDE_SESSION_VERSION=5
ENV KDE_FULL_SESSION=true
ENV CMAKE_MODULE_PATH=/opt/kde6/share/:$CMAKE_MODULE_PATH

COPY mirrorlist /etc/pacman.d/mirrorlist

RUN sed -i '/\[testing\]/,/Include/{s/^#//}' /etc/pacman.conf && \
    sed -i '/\[community-testing\]/,/Include/{s/^#//}' /etc/pacman.conf && \
    sed -i '/\[multilib-testing\]/,/Include/{s/^#//}' /etc/pacman.conf && \
    echo -e "\n[kde-unstable]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

RUN sed -i 's/ParallelDownloads = 5/ParallelDownloads = 20/' /etc/pacman.conf
RUN pacman-key --init && pacman -Sy --noconfirm archlinux-keyring pacman
RUN pacman -Syu --noconfirm
RUN pacman -Sy --asdeps plasma-meta krfb kdenlive kwave --noconfirm
RUN pacman -Sy git base-devel --noconfirm
RUN pacman -Sy --noconfirm \
    gperf jsoncpp ninja python vulkan-headers \
    clang jasper libmng gst-plugins-bad gst-plugins-good \
    gst-plugins-bad gst-plugins-ugly gst-libav assimp flite \
    speech-dispatcher hunspell hyphen woff2 cmake ruby libfbclient \
    mariadb-libs unixodbc postgresql-libs gtk3 cups freetds \
    perl re2  krb5 libgravatar boost perl-io-socket-ssl perl-yaml-syck python-sphinx \
    docbook-xsl doxygen libkdcraw sane ruby-test-unit swig xsd sassc python-cairo gtk2 \
    libraw llvm subversion astyle clang intltool libvncserver eigen freecell-solver    \
    python-pyqt6 quazip gsl vc opencolorio libheif sip libmtp qgpgme tinyxml2 \
    libdwarf libspectre libpwquality meson cppcheck xf86-input-libinput \
    xorg-server-devel nodejs perl-net-dbus openssl-1.1 wayland-protocols \
    djvulibre chmlib wget unzip flatpak gobject-introspection itstool gtk-doc graphviz xmlto \
    packagekit packagekit gobject-introspection itstool gtk-doc libolm xf86-input-evdev \
    libproxy libfakekey gi-docgen appstream-qt python-pip xf86-input-wacom python-html5lib \
    perl-json-xs perl-yaml-pp libdisplay-info mpv freerdp freerdp2 microsoft-gsl system-config-printer



RUN mkdir -p /opt/kde6 /opt/qt6 /home/afiestas/Projects/ /home/afiestas/Projects/kde6 /usr/lib/libffi-3.2.1/include

COPY build-qt /usr/bin/
COPY build-kde /usr/bin/
