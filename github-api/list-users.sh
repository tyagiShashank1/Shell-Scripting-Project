#!/bin/bash



# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
   collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | "\(.login) \(.id)"')"


    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}


function Helper {

  expected_cmd_args=2

if [ $# -ne $expected_cmd_args ] ; then
	echo "Please input the right number of command line arguments"

fi

}



Helper "$@"   #Invoking Helper function


####Without "$@":

# If you omit "$@", the Helper function won't receive the script's arguments.
# Inside Helper, $# (the argument count) will always be 0, causing your logic to fail.



# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access







#Additional Comments
#[[ ... ]]: A conditional test used in bash scripting to evaluate expressions.
# -z: A test operator that checks if the given string is of zero length (empty).
# "$collaborators": Refers to the value stored in the collaborators variable.
# If collaborators is empty or unset, the test returns true.
##
##
##
#
#
#
#
#
