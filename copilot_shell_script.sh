#!/bin/bash

read -p "Enter your name: " name

name=$(echo "$name" | tr '[:upper:]' '[:lower:]')

if [ -z "$name" ]; then
    echo "name cannot be empty"
    exit 1
fi

if [[ ! $name =~ ^[a-z]+$ ]]; then
    echo "name is invalid"
    exit 1
fi

dir="submission_reminder_$name"
submissions_file="$dir/assets/submissions.txt"
config_file="$dir/config/config.env"



#check of dir exists
if [ ! -d "$dir" ]; then
    echo "Directory does not exist"
    exit 1
fi

read -p "Enter your name of the assignment: " assignment
read -p "Enter the number of days remaining for submission: " days

if [[ -z $assignment ]]; then
    echo "assignment cannot be empty"
    exit 1
fi
if ! [[ "$days" =~ ^[0-9]+$ ]]; then
    echo "days cannot be empty"
    exit 1
fi

if [[ ! $assignment =~ ^[a-zA-Z0-9\ ]+$ ]]; then
    echo "assignment is invalid"
    exit 1
fi

# check if assignment already exits
matched_assignment=$(grep -i ", *$assignment," "$submissions_file" | awk -F',' '{print $2}' | head -n1 | xargs)
if [[ -z $matched_assignment ]]; then
    echo "Assignment '$assignment' isnt available in submission file"
    exit 1
fi

#updating config file 
cat <<EOF > $config_file
ASSIGNMENT="$matched_assignment"
DAYS_REMAINING=$days
EOF

read -p "Do you want to run the app? (y/n): " runAppChoice

if [[ $runAppChoice =~ ^[Yy]$ ]]; then
   echo "Running the app..."
   cd "$dir"
   ./startup.sh
else
   echo "You can run the app later by navigating to the directory '$dir' and executing './startup.sh'"
fi