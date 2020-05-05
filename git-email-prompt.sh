#!/bin/bash

# https://depressiverobot.com/2015/01/05/git-email.html
# https://gist.githubusercontent.com/depressiveRobot/09e40fbdaa7b09972439/raw/1d3e1004d28c45f1c19301c97fbd6cb9d9d02bc2/git-email-prompt.sh

MAILS=(mike@cadizm.com michael.cadiz@gmail.com michael.cadiz@hulu.com)

# prompt for email
echo
echo "Choose an email address for this repository."
echo
echo "Or press [Enter] to abort..."
echo
for ((i = 0; i < ${#MAILS[*]}; i++))
do
  echo "$(tput bold)$(($i))$(tput sgr 0): ${MAILS[$i]}"
done
echo
echo -n "email: "
read email
echo
echo

# abort when pressing enter
if [[ "$email" == "" ]]
then
  echo "$(tput setaf 3)abort$(tput sgr 0): No email set."
  exit 0
fi

# error if entered number is less than 1 or greater than size of emails
if [[ $email -lt "0" || $email -gt "${#MAILS[*]} - 1" ]]
then
  echo "$(tput setaf 1)error$(tput sgr 0): Unknown email $(tput bold)$email$(tput sgr 0)"
  exit 1
fi

# set email
echo "Set '${MAILS[$(($email))]}' as email address for this repository."
git config user.email ${MAILS[$(($email))]}

exit 0

# EOF
