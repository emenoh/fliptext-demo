#!/bin/bash
#
if [ ! -f "config.sh" ]; then
  echo "Please copy 'example.config.sh' to 'config.sh' and make any necessary corrections. "
  echo "cp example.config.sh config.sh "
  echo " "
  exit
fi
#
if [ ! -f "settings.json" ]; then
  echo "Please copy 'example.settings.json' to 'settings.json' and make any necessary corrections. "
  echo "cp example.settings.json settings.json "
  echo " "
  exit
fi
#
export PROJ=${PWD##*/}
#
source config.sh
export TARGET_SERVER_URL="https://${TARGET_SERVER}/"
#
export TARGET_DIRECTORY=${BUILD_DIRECTORY}/${PROJ}
mkdir -p ${TARGET_DIRECTORY}
#
echo "### Configuration for your '"${PROJ}"' project is :"
echo "   ~                                      Target Server is  : " ${TARGET_SERVER_URL}
echo "   ~ Align android-sdk bundle on "$ALIGNMENT"-byte boundary when using : " $ZIPALIGN_PATH
echo "   ~                              Temporary build directory : " ${BUILD_DIRECTORY}
echo "### ~   ~   ~    " 
export KS="${HOME}/.${PROJ}.keystore"
if [ ! -f ${KS} ]; then
  echo " *** Not able to find your key store : ${KS} *** "
  echo "Please execute the following command and provide the requested details ..."
  echo "keytool -genkey -v -keystore ${KS} -alias ${PROJ} -keyalg RSA -keysize 2048 -validity 10000"
  echo ""
  exit
fi

echo "Found key store."
#
echo "Checking/installing Android capabilities : "
meteor install-sdk android
#
echo ""
echo ""
echo "**NOT** Checking/installing iOS capabilities : "
#meteor install-sdk ios
#
echo ""
echo ""
echo "Preparing to build project : ${PROJ} in ${BUILD_DIRECTORY}"
cp settings.json  ./public/
meteor remove xolvio:cucumber
meteor remove xolvio:webdriver
meteor add-platform android
echo ""
echo ""
echo "Building android project : ${PROJ} in ${BUILD_DIRECTORY}"
meteor build ${TARGET_DIRECTORY}         --server=${TARGET_SERVER_URL}
echo "Renaming apk file : "
echo ""
echo ""
echo "Building browser project : ${PROJ} in ${BUILD_DIRECTORY}"
mv ${TARGET_DIRECTORY}/android/unaligned.apk ${TARGET_DIRECTORY}/android/${PROJ}_unaligned.apk
meteor build ${TARGET_DIRECTORY} --debug --server=${TARGET_SERVER_URL}
rm -f ./public/settings.json
#
#
pushd ${TARGET_DIRECTORY}
pushd ./android > /dev/null
echo "Sign the unaligned APK"
jarsigner -keystore  ${KS} -storepass 34erDFCV-*-* -tsa http://timestamp.digicert.com -digestalg SHA1 ${PROJ}_unaligned.apk ${PROJ}
echo "Align to byte boundaries and verify."
${ZIPALIGN_PATH}/zipalign -f    ${ALIGNMENT} ${PROJ}_unaligned.apk ${PROJ}_aligned.apk
# ${ZIPALIGN_PATH}/zipalign -f -v ${ALIGNMENT} ${PROJ}_unaligned.apk ${PROJ}_aligned.apk
echo ".........  "
#
echo "Rename and relocate for easy deployment"
mv ${PROJ}_aligned.apk ..
mv unaligned.apk ../${PROJ}.apk
popd > /dev/null
#
echo "Uploading ${PROJ}.tar.gz & ${PROJ}.apk to . . . "
pwd
scp ${PROJ}.* ${TARGET_SERVER}:~/incoming
#
echo "Installing . . . "
ssh ${TARGET_SERVER} "sudo -u meteor /home/meteor/installProj.sh ${PROJ}"
#
echo "Patching . . . "
###########ssh ${TARGET_SERVER} "sudo -u root /home/meteor/fixFibers.sh"
#
#
echo "Restarting . . . "
ssh ${TARGET_SERVER} "sudo -u root /home/meteor/restartMeteor.sh"
#
popd > /dev/null

