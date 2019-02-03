# A quick utility script to print the grade from each repo
# after the grade has been filled in the ISSUE_TEMPLATE.md
# file.

for d in ls -d */
do
  # print directory name
  echo $d
  # prints the 9th line of the ISSUE_TEMPLATE.md file.
  # assumes the grade is on the 9th line of the file.
  sed '9q;d' $d/ISSUE_TEMPLATE.md
done
