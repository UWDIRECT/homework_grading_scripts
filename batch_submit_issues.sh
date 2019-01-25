#!/bin/bash

#
# This script will batch submit the homeowrk grading issues for all github 
# repos (student homework repos) in the current path. This is to be used 
# after you have graded all the homework repos on your local machine by 
# modifying the ```ISSUE_TEMPLATE.md``` file that is automatically generated 
# in the homework repos. It eliminates the need to manually create an issue 
# and fill out the grade online in github/github classroom. 
#

# set variable 'title' to set a common name of all issues.
if [ "$1" != "" ]; then
	title="$1"
	echo "using '$title' as the issue title"
else
	echo "usage: $0 <issue title>"
	exit 1
fi

# get a temporary file for preparing the issue text
tmpfile=$(mktemp /tmp/bash_submit_issues.sh.XXXXXXXXXX) || { echo "failed to create a tmp file"; exit 1; }

# Issues will be sent for all github repos (homework repos) in this parent directory.
# Alternatively, you can set a leading path to all the homework repos on your local machine.
hwdir="`PWD`/*/"

# loop through each student's homework repo in this directory
for dir in $hwdir
do

	echo $dir
	cd $dir

	if [ ! -e ISSUE_TEMPLATE.md ]; then
		echo "WARNING: unable to find an ISSUE_TEMPLATE.md file, skipping this directory..."
		continue
	fi

	# A temporary file is needed to specify both issue title and content at once.
	# The title needs to be the first line separated by an empty line from content.
	echo $title > $tmpfile
	echo "" >> $tmpfile
	cat ISSUE_TEMPLATE.md >> $tmpfile

	# creating the issue, url of new issue will be copied to your computer clipboard
	# using the alternative command will not copy to your clipboard, but will print an error line insted
	hub issue create -c -F $tmpfile
	# uncomment below for debugging
	# cat $tmpfile

	# removing the temporary file
	rm $tmpfile
done

