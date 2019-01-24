#!/bin/bash

# Change variable 'title' to set a common name of all issues.
title="SEDS HW 1 Grade"

# Issues will be sent for all github repos (homework repos) in this parent directory.
# Alternatively, you can set a leading path to all the homework repos on your local machine.
hwdir="`PWD`/*/"

# loop through each student's homework repo in this directory
for i in $hwdir
do

echo $i
cd $i

# A temporary file is needed to specify both issue title and content at once.
# The title needs to be the first line separated by an empty line from content.
echo $title > temp_issue_header.txt
echo "" >> temp_issue_header.txt
cat ISSUE_TEMPLATE.md >> temp_issue_header.txt

# removing the temporary file
`mv temp_issue_header.txt ISSUE_TEMPLATE.md`

# creating the issue, url of new issue will be copied to your computer clipboard
# using the alternative command will not copy to your clipboard, but will print an error line insted
`hub issue create -c -F ISSUE_TEMPLATE.md`
#`hub issue create -F ISSUE_TEMPLATE.md` # alternative command

done

