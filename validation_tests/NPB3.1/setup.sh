#!/bin/bash
. ../../setup.sh
#spackLoadUnique mpich
spackLoadUniqueNoRootVars tau #@develop  #NoR version turns off the -r to spack load, so no dependencies are auto-loaded
#retVal=$?
#if [ $retVal -ne 0 ] ; then
#  exit $retVal
#fi

