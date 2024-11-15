#!/bin/bash
#
# produce a list of files to be packaged
# usage:
# clear ; ./run -a do_scan_to_list_file
do_scan_to_list_file() {

  mkdir -p $PROJ_PATH/cnf/lst/
  product=$(basename $PROJ_PATH)

  # contains the regex partterns  to be excluded while packaging
  component_exclude_list_fle=$PROJ_PATH/cnf/lst/$product.exclude.lst

  # contains the files to be included while packaging
  component_include_list_fle=$PROJ_PATH/cnf/lst/$product.include.lst
  echo cnf/lst/$product.include.lst >$component_include_list_fle

  # build a string like (.git|node_modules|.venv|.log)
  exclude_list='('
  while read -r p; do
    exclude_list="$exclude_list""$p"'|'
  done < <(cat $component_exclude_list_fle)
  exclude_list=${exclude_list/%?/}')' # chop off the last '|'

  while read -r f; do
    echo $f >>$component_include_list_fle
  done < <(find . -type f | cut -c 3- | grep -Ev "$exclude_list" | sort)

  do_log INFO produced the $component_include_list_fle file

  test -f $component_include_list_fle && export EXIT_CODE="0"

}
