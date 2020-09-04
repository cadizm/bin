#!/bin/bash

JAR_DIR=${HOME}/workspace/jar

JARS=$(/bin/ls ${JAR_DIR})

for JAR in $(echo ${JARS}); do
    JAR_PATH+=${JAR_DIR}/${JAR}:
done

echo ${JAR_PATH} | sed 's/:$//'
