#!/bin/bash

# The script will batch pull grades from the homework repo issues for all
# github repos (student homework repos) in the current path. It will record both
# the initial and final (if a re-grade was performed) for all students. It
# eliminates the need to record grades manually for individual students. All
# scores will be recorded as a csv file with the name specified while running
# the script.

# set variable 'grader' to the grading instructor's GitHub username
if [ "$1" != "" ]; then
	grader="$1"
	echo "looking for scores recorded by '$grader'"
else
	echo "usage: $0 <grader's username> <issue title> <filename to store grades>"
	exit 1
fi

# set variable 'title' to filter issues containing grades
if [ "$2" != "" ]; then
	title="$2"
	echo "looking in issue titled '$title'"
else
	echo "usage: $0 <grader's username> <issue title> <filename to store grades>"
	exit 1
fi

# set variable 'filename' to set designated storage location of scores
if [ "$3" != "" ]; then
	filename="$3"

	if [ -e $filename ]; then
		echo "ERROR: '$filename' already exists. Remove file or choose a new name."
		exit 1
	else
		touch $filename
		echo "# Student, Initial Grade, Final Grade" >> $filename
		echo "recording scores in '$filename'"
	fi

else
	echo "usage: $0 <grader's username> <issue title> <filename to store grades>"
	exit 1
fi


# Grades will be recorded for all student repos in this parent directory.
hwdir=$(ls -d */ | sort -f)

#loop through each student's homework repo in this directory
for dir in $hwdir
do

name=${dir%/}

cd $dir

# finds the issue number matching the grader and title provided
# this helps eliminate issues that the student may create themselves
number=$(hub issue -c $grader | grep "$title")
number=${number#*'#'}
number=${number:0:1}

# if no grading issue is found, check the closed issues
if [ "$number" == "" ]; then
	number=$(hub issue -c $grader -s closed | grep "$title")
	number=${number#*'#'}
	number=${number:0:1}
fi

# if still no grading issue is found, skip this student's repo
if [ "$number" == "" ]; then
	echo "WARNING: unable to locate grading issue for '$name'"
	cd ..
	echo "$name,," >> $filename
	continue
fi

# sorting through issue comments to find grades and participating users
comments=$(hub issue show $number | grep "comment by @\|/5")

# first grade found in the issue is listed as initial grade
# the original 'hub' issue command filtered issues not submitted by grader
# if no initial grade is found, student's repo is skipped
initial=${comments%%'comment by @'*}
if [[ $initial == *'/5'* ]]; then
	initial=${initial%%'/5'*}
	initial=${initial: -1}
else
	echo "WARNING: unable to find any grades for '$name'"
	cd ..
	echo "$name,," >> $filename
	continue
fi

# final grade is found in last grader comment
# final grade could be the same as the initial grade
# comments made by other individuals are removed

final=''

# immediately transfer initial grade to final grade if at full credit
if [[ $initial == "5" ]]; then
	final=$initial

# will search for a re-grade in the comments submitted by the grader
elif [[ $comments == *"comment by @$grader"* ]]; then

	# isolate the last grader comment
	beg=${comments%"comment by @$grader"*}
	end=${comments##*"comment by @$grader"}
	# remove comments from other users
	end=${end%%"comment by @"*}

	# will search grader comments from the end of the issue in search of re-grade
	n=1
	while [[ $final == '' ]] || [[ n -lt 100 ]]
	do
		# re-grade is found, while loop will end
		if [[ $end == *'/5'* ]]; then
			end=${end%%'/5'*}
			final=${end: -1}

		# re-grade is not found, will check for more grader comments to search
		elif [[ $beg != *"comment by @$grader"* ]]; then
			break

		# will reset next loop with next-last grader comment
		else
			end=${beg##*"comment by @$grader"}
			end=${end%%"comment by @"*}
			beg=${beg%"comment by @$grader"*}
		fi

		# will prevent loop from running more than 100 iterations
		(( n++ ))
	done

# will alert the grader if no re-grade is found for a student
# initial grade will be transferred to final grade
else
	echo "WARNING: no re-grade for '$name'"
	final=$initial
fi


cd ..
echo "$name,$initial,$final" >> $filename
done
