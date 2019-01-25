# Homework Grading Scripts

Simple scripts to automate a bit of the homework grading process for instructors and TA's.

Scripts include:  
* ```batch_submit_issues.sh```

## batch_submit_issues.sh

This script will batch submit the homeowrk grading issues for all github repos (student homework repos) in the current path. This is to be used after you have graded all the homework repos on your local machine by modifying the ```ISSUE_TEMPLATE.md``` file that is automatically generated in the homework repos. It eliminates the need to manually create an issue and fill out the grade online in github/github classroom. 

#### Installation of Required Tools

The shell script relies on the ``` github/hub ``` tool to create issues by command line. Follow the [installation instructions](https://github.com/github/hub) found at their github page to install the tool on your device.

User documentation for the Hub tool can be found [here](https://hub.github.com/hub.1.html). It extends many git commands and also provides new commands of its own.

#### Usage

1. Download all the homework repos to your local machine. When grading the homework, modify the ```ISSUE_TEMPLATE.md``` file in each repo rather than making an issue through the github webiste.
2. Copy ```batch_submit_issues.sh``` into the parent directory of all the homework repos.
3. Decide on your title for the issues, e.g. "SEDS HW1 Feedback"
4. Once you are ready to send out the issues to _all_ the students, simply run the shell script using your issue title as the first and only argument.  Don't forget to use quotes to encapsulate the argument if it has spaces.
_NOTE: the hub command for creating issues will automatically copy the url of the new issue to your computer's clipboard. This can be avoided by using the alternative command provided in the script. However, you will get an error as the function tries to print the url to your terminal. The issue will still be created, but it will print the url and followed by 'No such file or directory'._
