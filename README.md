# Homework Grading Scripts

Simple scripts to automate a bit of the homework grading process for instructors and TA's.

Scripts include:  

* `batch_submit_issues.sh`   
* `batch_pull_grades.sh`


## Installation of Required Tools

The shell scripts use the `github/hub` tool to create and read issues by command line. Follow the [installation instructions](https://github.com/github/hub) found at their github page to install the tool on your device.

For more information about the `Hub` tool, user documentation can be found [here](https://hub.github.com/hub.1.html).


## `batch_submit_issues.sh`

This script will batch submit the homework grades (github issues) for all the student homework repos. The script should be placed in the parent directory where you have all the homework repos stored locally. Grade all the homeworks by modifying the `ISSUE_TEMPLATE.md` file in each repo. Then, run the shell script _once_ in the parent directory (one level above all homework repos) to batch submit all the grades.

#### Features
* Will submit grades for students simultaneously to ensure all students receive feedback at the same time for homework. This eliminates the need to manually create a feedback issue on each student's homework repo.

#### Limitations
* Only student homework repos can be located in the directory with this script. The shell script moves into each sub-directory (homework repo) and tries to submit an issue, even for directories that are not github repos.

#### Usage
1. Download all the homework repos to your local machine. When grading the homework, modify the ```ISSUE_TEMPLATE.md``` file in each repo rather than making an issue through the github webiste.
2. Copy ```batch_submit_issues.sh``` into the parent directory of all the homework repos.
3. Decide on your title for the issues, e.g. "SEDS HW1 Feedback"
4. Once you are ready to send out the issues to _all_ the students, simply run the shell script using your issue title as the first and only argument.  Don't forget to use quotes to encapsulate the argument if it has spaces.


## `batch_pull_grades.sh`


#### Features
* Filters out issues and comments made by anyone else but the specified grader.  
* Handles multiple re-grades by recording only first and last grades noted by the grader.

#### Limitations
* Only student homework repos can be located in the directory with this script. The shell script moves into each sub-directory (homework repo) and tries to submit an issue, even for directories that are not github repos.
* All grades must be submitted in grading issues with the same title. This will be true if `batch_submit_issues.sh` was used to submit the original grades.  
* All re-grades should be given as comments to the original grading issue.  
* Grades must be given in the form `x/5` for the script to find the scores.

#### Usage

1. Download all the homework repos to your local machine.
2. Copy ```batch_pull_grades.sh``` into the parent directory of all the homework repos.
3. Note the issue title where grading occurred, e.g. "SEDS HW1 Feedback".
4. Decide on the csv filename for recording grades, e.g. "grades.csv".
5. Once you are ready to pull grades, simply run the shell script with the following arguments, suing quotes to encapsulate arguments with spaces:

`batch_pull_grades.sh <grader's github username> <issue title> <filename>`



