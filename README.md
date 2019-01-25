# Homework Grading Scripts

Simple scripts to automate a bit of the homework grading process for instructors and TA's.

Scripts include:  
* `batch_submit_issues.sh`

## batch_submit_issues.sh

This script will batch submit the homework grades (github issues) for all the student homework repos. The script should be placed in the parent directory where you have all the homework repos stored locally. Grade all the homeworks by modifying the `ISSUE_TEMPLATE.md` file in each repo. Then, run the shell script _once_ in the parent directory (one level above all homework repos) to batch submit all the grades. See the __Usage__ section below for more details.

#### Installation of Required Tools

The shell script relies on the `github/hub` tool to create issues by command line. Follow the [installation instructions](https://github.com/github/hub) found at their github page to install the tool on your device.

User documentation for the Hub tool can be found [here](https://hub.github.com/hub.1.html). It extends many git commands and also provides new commands of its own.

#### Usage

1. Download all the homework repos to your local machine. Make sure to place them all into one _empty_ local directory. This will be the parent directory where the shell script is kept. 
2. When grading the homework, modify the `ISSUE_TEMPLATE.md` file in each repo rather than making an issue through the github webiste.
3. Place `push_hw_issues.sh` into the parent directory where all the homework repos are stored (one level above each student's repo). You should only need one copy of this script.
_NOTE: only student homework repos can be located in this directory. The shell script moves into each sub-directory (homework repo) and tries to submit an issue. It will do this even for directories that are not github repos._
4. Modify the `title` variable in the shell script as the issue title you want to specify, e.g. "SEDS HW 1 Grade".
5. Once you are ready to send out the issues to _all_ the students, simply run the shell script in the parent directory.  
_NOTE: the hub command for creating issues will automatically copy the url of the new issue to your computer's clipboard. This can be avoided by using the alternative command provided in the script. However, you will get an error as the function tries to print the url to your terminal. The issue will still be created, but it will print the url and followed by 'No such file or directory'._
