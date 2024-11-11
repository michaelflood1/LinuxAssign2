# Linux Assignment 2

### Goal
1. Establish a series of batch scripts to help with the initial setup of fresh computers for use as servers.
2. Create a script that will streamline the process of user creation.

## Part 1

### Tasks
- Create a shell script that will clone a Git repository and create symbolic links for configuration and executable files in the specified system directories.
- Create a shell script that will read a preset list of packages from a file and then download them.
- Create a script that is called with arguments to execute the first two scripts, allowing a new computer to be quickly set up for use.

### Main Focus

**System Setup**

1. In each executed script, the first thing we do is run a check to ensure that `sudo` is used in the command line call.
2. Each script has fallback options for users who forget the syntax required (e.g., `-h`), or in case of a mistake, the entire syntax for running the script is returned.
3. Instead of handling errors in each individual script, error checks are contained in the scripts that are actually called.

## Usage

There are 3 calls set up for **main.sh**:

```bash
sudo ./main.sh -i
# This will call the installation script to parse and download the required assets.


```

```bash
sudo ./main.sh -d
#This will call my Directorycreation script to clone a specified git repo and then create symlinks to many of its files.
```

```bash
sudo ./main.sh -h
#This is your standard help option that will give feedback required to use this script properly.

```

## Part 2

### Tasks
For this task there were three main goals.
1. have a user option allowing you to create a new user and trigger the passwd creation utility.
2. have a Group add option to push this user into new groups.
3. have a Shell option which will give the user the choice of their preferred shell i.e .sh bash etc.etc

#### Main Focus
**Argument Handling**
The main problem in making this script was to generate enough error handles for the amount of possible issues a user could have inputting their new user into the script.

As long as the Arguments were passed in correctly we are able to:
- Generate a new user their password as well as their directory
-  Place the user into required groups
- Give the user a default shell/Enviorenment variable they were comfortable with.

### Usage

```Bash

# 4 callable args
# -u [username]
# -g [group1, group2...]
# - s [shell]
# -h [null]

sudo ./newUser.sh -u Michael -g isbadatcases -s bash


