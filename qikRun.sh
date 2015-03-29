#!/bin/bash
#
if [ ! -f "config.sh" ]; then
  echo "Please copy 'example.config.sh' to 'config.sh' and make any necessary corrections. "
  echo "cp example.config.sh config.sh "
  exit
fi
source config.sh
echo "### Configuration is :"
echo "   ~  Connect to  Mongo server : " $MONGO_URL
echo "   ~  Running in demo mode : " $DEMO_MODE
echo "### ~   ~   ~    "


if [ ${MOCHA} ]; then
  meteor add mike:mocha
  echo "mocha"
else
  meteor remove mike:mocha
  echo "NO mocha"
fi

if [ ${CUCUMBER} ]; then
  meteor add xolvio:webdriver
  meteor add xolvio:cucumber
  echo "cucumber"
else
  meteor remove xolvio:webdriver
  meteor remove xolvio:cucumber
  echo "NO cucumber"
fi

meteor



