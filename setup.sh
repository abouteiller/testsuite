#This is necessary in every sub-script that loads spack packages.
command -v spack >/dev/null 2>&1 || { source /spack/share/spack/setup-env.sh; }
command -v spack >/dev/null 2>&1 || { echo "Failure: Spack not found. Exiting"; exit 1; }
source ${SPACK_ROOT}/share/spack/setup-env.sh
#source ./settings.sh
#echo $BASH_SOURCE
#echo dirname $BASH_SOURCE
if [ -z ${TESTSUITE_SETTINGS_FILE+x} ]; then source `dirname $BASH_SOURCE`/settings.sh; else source $TESTSUITE_SETTINGS_FILE; fi


#alias test_run='$TEST_RUN'
rArg=" -r "
loadRoots="True"
oneSpackHash(){
	findOut="$(spack find -l $@)";
        if [ $? -ne 0 ] ; then
             echo "Package/Spec $@ not found." >&2
             exit 215;
        fi
	echo "/`echo "${findOut}" | tail -n1 | awk '{print $1;}'`" ;  
}


spackSetPackageRoot(){
	#echo ${1}
	SPAC_LOC=`spack location -i ${1}`
        SPAC_NAM=`spack find --format={name} ${1}`
	SPAC_NAM=${SPAC_NAM^^}
        SPAC_NAM=`echo $SPAC_NAM | tr '-' '_'`
	#eval "${SPAC_NAM}_ROOT"
	###BEWARE: Setting this value can 
        export ${SPAC_NAM}_ROOT=${SPAC_LOC}
	export ${SPAC_NAM}_HASH=${1}
}

spackLoadUnique(){ 

        #rArg=" -r "
#	if [ ! -z "$2" ] && [ $2 = "nor" ]; then
#		rArg=""
#	fi
	spackHash="$(oneSpackHash $@)"
	ret_val=$?
	if [ $ret_val -ne 0 ] ; then
             exit 215;
        fi
	spack load ${rArg} ${spackHash} || { echo "Package/Spec $@ or dependency not found." >&2 ; exit 215; } ;
	echo ${spackHash}
	#spackSetPackageRoot ${spackHash}	
	if [ "$loadRoots" = "True" ] ; then

	HASHES=`spack find --loaded --format={hash}`
	for HASH in $HASHES
	do
		#echo $HASH
		spackSetPackageRoot /$HASH
	done

	fi
}

spackLoadUniqueNoRootVars(){
	loadRoots="False"
	spackLoadUnique $@
	loadRoots="True"
}

spackLoadUniqueNoR(){
	#spack load $@
	rArg=""
	spackLoadUnique $@
        rArg=" -r "
}
