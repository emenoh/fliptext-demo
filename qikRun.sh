#!/bin/bash
#
###################   Functions
function weCanParseJSON { 
  jq --version >/dev/null 2>&1
  if [[ 0 -ne $? ]]; then
    echo ""
    echo "You need the JSON parser 'jq' if you want to be able to set meteor command line parameters from your settings.json file."
    echo "Please execute the following command : "
    echo "sudo apt-get -y install jq"
    exit
  fi
  if [ ! -f "settings.json" ]; then
    echo "Please copy 'example.settings.json' to 'settings.json' and make any necessary corrections. "
    echo "cp example.settings.json settings.json "
    exit
  fi
}

function parseJSON {
  local __PARM=$1
  local TMP=$(cat settings.json | jq .$1 | sed "s/\"//g")
  eval $__PARM="'${TMP}'"
}

function parseJSON_public {
  local __PARM=$1
  local TMP=$(cat settings.json | jq .public.$1 | sed "s/\"//g")
  eval $__PARM="'${TMP}'"
}

function addOrRemoveMocha {
  parseJSON MOCHA
  if [ ${MOCHA} == "yes" ]; then
    meteor add mike:mocha
    echo "Mocha added"
  else
    meteor remove mike:mocha
    echo "Mocha removed"
  fi

}

function addOrRemoveCucumber {
  parseJSON CUCUMBER
  if [ ${CUCUMBER} == "yes" ]; then
    meteor add xolvio:webdriver
    meteor add xolvio:cucumber
    echo "Cucumber added"
  else
    meteor remove xolvio:webdriver
    meteor remove xolvio:cucumber
    echo "Cucumber removed"
  fi
}

###################   Main Program
#
weCanParseJSON
parseJSON MONGO_PORT
parseJSON MONGO_SERVER
parseJSON MONGO_DB
export MONGO_URL=mongodb://${MONGO_SERVER}:${MONGO_PORT}/${MONGO_DB}
#
addOrRemoveMocha
addOrRemoveCucumber
#
parseJSON demo_mode
#
echo "### Configuration is . . . "
echo "   ~  Connect to  Mongo server : " ${MONGO_URL}
echo "   ~      Running in demo mode : " ${demo_mode}
echo "   ~  Velocity "
echo "   ~                     Mocha : " ${MOCHA}
echo "   ~                  Cucumber : " ${CUCUMBER}
echo "### ~   ~   ~   ~   ~   ~   ~   ~   ~   ~    "
#
meteor --settings=settings.json


