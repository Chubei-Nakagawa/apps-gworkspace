#!/bin/bash

ALLS=()
while read LINE ;do
  ALLS+=( ${LINE} )
done << EOS
libx11-dev
libxext-dev
libxrandr-dev
libwings-dev
libpango1.0-dev
libxres-dev
gnustep-devel
libsteptalk-dev
libpantomime-dev
libpreferencepanes-dev
libaddressview-dev
libdbuskit-dev
libgnustep-corebase-dev
libgnustep-dl2-dev
libinspector-dev
libinterfacebuilder-dev
libnetclasses-dev
EOS

PACKAGES=()
for DD in "${ALLS[@]}" ;do
  dpkg -l ${DD} 2>/dev/null | grep ^ii >/dev/null
  RV="$?"
  if [ $RV -eq 0 ];then
    echo "$DD installed"
  else
    PACKAGES+=( $DD )
  fi
done

if [[ ${#PACKAGES[@]} -ne 0 ]]; then
  echo "install ${PACKAGES[@]}"
  apt-get install -y "${PACKAGES[@]}"
fi
