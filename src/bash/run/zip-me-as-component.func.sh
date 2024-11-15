#!/bin/bash
#
# create a component zip file to be unzipped to the component project back
# usage:
# COMPONENT=run.sh ./run -a do_zip_me_as_component
#
do_zip_me_as_component() {

  mkdir -p $PROJ_PATH/cnf/lst/
  cd $PROJ_PATH
  do_require_var COMPONENT $COMPONENT

  # contains the files to be included while packaging
  component_include_list_fle=$PROJ_PATH/cnf/lst/$COMPONENT.include.lst

  zip_file=$BASE_PATH/$ORG_DIR/$COMPONENT.zip
  test -f $zip_file && rm -v $zip_file

  while read -r f; do

    # if the file still exists in the bigger project add it
    test -f $PROJ_PATH/$f && zip $zip_file $f

    # if the file does not exist, remove it from the list file
    test -f $f || perl -pi -e 's|^'"$f"'\n\r||gm' $component_include_list_fle

  done < <(cat $component_include_list_fle)

  do_log "INFO produced the $zip_file file"

  test -f $component_include_list_fle && export EXIT_CODE="0"

}
