# submission-reminder_app


# Submission Reminder System

An application built with Bash that assists students in keeping track of and reminding them of their unfinished assignments.

## Overview

This system of mine  develops and manages a submission reminder application for monitoring student assignments, this system is made up of two primary shell scripts that are found below.

## Files

### 1. `create_environment.sh`
The setup script that initializes the entire application structure.

### 2. `copilot_shell_script.sh`
The configuration script that updates assignment details and runs the application.

## How It Works

### Initial Setup (`create_environment.sh`)

This script creates the complete application environment for the user:

**Step 1: Directory Structure Creation**
- Prompts for a student name
- Creates a main directory: `submission_reminder_{name}`
- Creates subdirectories:
  - `app/` - Contains the main reminder script
  - `modules/` - Contains helper functions
  - `assets/` - Contains the submissions data
  - `config/` - Contains configuration files

**Step 2: File Generation**
- **`config/config.env`**: Stores the current assignment name and days remaining
- **`assets/submissions.txt`**: CSV file containing student names, assignments, and submission status
- **`modules/functions.sh`**: Contains the `check_submissions()` function that parses the submissions file
- **`app/reminder.sh`**: Main script that displays reminders for students who haven't submitted
- **`startup.sh`**: Entry point that validates and runs the reminder app

**Step 3: Permissions**
- Makes all scripts executable with `chmod +x`

### Configuration and Execution (`copilot_shell_script.sh`)

This script allows you to update the application configuration:

**Step 1: User Validation**
- Prompts for your name
- Converts name to lowercase
- Validates that the name contains only letters
- Checks if the `submission_reminder_{name}` directory exists

**Step 2: Assignment Configuration**
- Prompts for assignment name
- Prompts for days remaining until submission
- Validates the assignment exists in `submissions.txt`
- Updates the `config/config.env` file with new values

**Step 3: Application Launch**
- Asks if you want to run the app immediately
- If yes, navigates to the directory and executes `startup.sh`
- If no, provides instructions for manual execution

## Application Flow


create_environment.sh
    |
Creates directory structure
    |
Generates all necessary files
    |
copilot_shell_script.sh (optional)
    |
Updates configuration
    |
startup.sh
    |
app/reminder.sh
    |
Loads config/config.env
    |
Calls check_submissions() from modules/functions.sh
    |
Reads assets/submissions.txt
    |
Displays reminders for non-submitted assignments


## Usage Example

### First Time Setup
```bash
# Run the environment creation script
./create_environment.sh
# Enter your name when prompted
```

### Update Configuration
```bash
# Run the configuration script
./copilot_shell_script.sh
# Enter your name: john
# Enter assignment name: Shell Navigation
# Enter days remaining: 5
# Run app? y
```

### Manual Execution
```bash
cd submission_reminder_{yourname}
./startup.sh
```

## Sample Output

```
Assignment: Shell Navigation
Days remaining to submit: 2 days
--------------------------------------------
Checking submissions in ./assets/submissions.txt
Reminder: Chinemerem has not submitted the Shell Navigation assignment!
Reminder: Divine has not submitted the Shell Navigation assignment!
```

## Key Features

- **Input Validation**: Both scripts validate user input for security and correctness
- **Case-Insensitive Search**: Assignment names are matched case-insensitively
- **Modular Design**: Separates concerns into different files and directories
- **Reusable**: Can be configured multiple times for different assignments
- **Error Handling**: Checks for directory existence, empty inputs, and invalid data

## File Structure

```
submission_reminder_{name}/
├── app/
│   └── reminder.sh          # Main reminder application
├── modules/
│   └── functions.sh         # Helper functions
├── assets/
│   └── submissions.txt      # Student submission data (CSV)
├── config/
│   └── config.env          # Configuration variables
└── startup.sh              # Application entry point
```

## Requirements

- Bash shell (Linux/Unix/macOS)
- Standard Unix utilities: grep, awk, xargs, tr
- Execute permissions on script files

## Notes

- Student names in the setup script must contain only letters
- Assignment names can contain letters, numbers, and spaces
- Days remaining must be a positive integer
- The submissions file uses CSV format with comma separators