all: test-householder3 test-householder test-householderregex test-mm_c test-householderfolder test-householderheader
clean: clean-householder3 clean-householder clean-householderregex clean-mm_c clean-householderfolder clean-householderheader


test-%: %_dir
	@export QUIET_TEST_OUTPUT=1; cd $<; bash setup.sh && bash compile.sh && bash run.sh

clean-%: %_dir
	cd $<; bash clean.sh
