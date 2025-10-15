#!/bin/bash
#creates an app reminder for students to remind them of pending assignments

#ask for the user input and create a directory submission_reminder_{userinput}
read -p "Enter your name:" name
mkdir -p submission_reminder_$name

lance_dir="submission_reminder_$name"
#create subdirectories
mkdir -p "$lance_dir/app"
mkdir -p "$lance_dir/modules"
mkdir -p "$lance_dir/assets"
mkdir -p "$lance_dir/config"

#create the files in their respective subdirectories with their contents

echo '# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2' > $lance_dir/config/config.env

echo "student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Keza, Shell Basics, submitted
Ben, Git, not submitted
Ines, Shell Navigation, submitted
Diana, Shell Basics, not submitted
Nshuti, Git, submitted
 " > $lance_dir/assets/submissions.txt

echo '#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}' > $lance_dir/modules/functions.sh

#reminder script to notify students of pending assignments
echo '#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file' > $lance_dir/app/reminder.sh

#checking if reminder exists
echo '
#!/bin/bash
if [ -f "./app/reminder.sh" ]; then
    ./app/reminder.sh
else
    echo "Failed to create reminder.sh not found in app/ directory"
exit 1
fi
' > $lance_dir/startup.sh
#scripts excecutable
chmod +x $lance_dir/app/reminder.sh
chmod +x $lance_dir/modules/functions.sh
chmod +x $lance_dir/startup.sh
