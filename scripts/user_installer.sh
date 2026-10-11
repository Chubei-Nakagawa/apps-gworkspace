#!/bin/bash

ALLS=()
while read LINE ;do
  ALLS+=( ${LINE} )
done << EOS
gnustep-common
gnustep-base-runtime
gnustep-gui-runtime
libwings3
libwutil5
gnustep-back-common
gnustep-back0.32
steptalk
gnustep
libxext6
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


GDOMAP_BIN=$(which gdomap)
if [[ ! -z ${GDOMAP_BIN} ]]; then
  chmod 4755 ${GDOMAP_BIN}
fi
