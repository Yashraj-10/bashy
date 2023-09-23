#!/bin/sh
if [ "root" != "$(whoami)" ]; then
    echo "You must run this command as root" 1>&2
    exit 1
fi

set -x

# Download and extract
if [ ! -z "${1}" ]; then
    VERSION="${1}"
else
    VERSION="0.35.1"
fi

TARBALL="/usr/src/ArgoUML-${VERSION}.tar.gz"
if [ ! -f "${TARBALL}" ]; then
    curl -L "https://github.com/argouml-tigris-org/argouml/releases/download/VERSION_$( echo ${VERSION} | tr '.' '_' )/ArgoUML-${VERSION}.tar.gz" -o "${TARBALL}"
fi

tar -xzf "${TARBALL}" -C /usr/src

# Move and create a valid symlink
mv "/usr/src/argouml-${VERSION}" "/usr/local/argouml-${VERSION}"
ln -s "/usr/local/argouml-${VERSION}/argouml.sh" "/usr/local/bin/argouml"

# Desktop shortcut
SHORTCUT="[Desktop Entry]
Name=ArgoUML ${VERSION}
Exec=/usr/local/argouml-${VERSION}/argouml.sh
Icon=/usr/local/argouml-${VERSION}/icon/ArgoIcon128x128.png
Terminal=false
Type=Application
Encoding=UTF-8
Categories=Utility;Java;Development;UML"

echo "${SHORTCUT}" > "/usr/share/applications/argouml-${VERSION}.desktop"

set +x

echo "Finish!"
exit 0