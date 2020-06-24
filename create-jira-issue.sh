# Environment variables:
#
# $JIRA_SUBDOMAIN
# $JIRA_EMAIL
# $JIRA_TOKEN
# $JIRA_PROJECT_KEY
# $JIRA_BOARD_ID
#
# Input parameters:
#
# $1 issue assignee: String [ firstname.lastname ]
# $2 issue label: String
# $3 issue type: String [ "Story" | "Task" | "Bug" ]
# $4 issue summary: String

function jget { 
    echo `curl -s -u $JIRA_EMAIL:$JIRA_TOKEN "https://$JIRA_SUBDOMAIN.atlassian.net/rest/$1"`
}

function jpost { 
    echo `curl -s -u $JIRA_EMAIL:$JIRA_TOKEN -X POST -H "Content-Type: application/json" --data "$2" "https://$JIRA_SUBDOMAIN.atlassian.net/rest/$1"`
}

# create task
ISSUE_JSON="{\"fields\":{\"project\":{\"key\":\"$JIRA_PROJECT_KEY\"},\"summary\":\"$4\",\"issuetype\":{\"name\":\"$3\"},\"labels\":[\"$2\"],\"assignee\":{\"name\":\"$1\"}}}"
echo "Posting issue ..."
echo "JSON: $ISSUE_JSON"
jpost "api/2/issue" "$ISSUE_JSON" > /tmp/post-response.json
ISSUE_ID=`jq -r '.key' /tmp/post-response.json`
if [ -z "$ISSUE_ID" ]; then
    echo "Failed to create issue! Check /tmp/post-response.json."
    exit 1
fi

# add task to sprint
echo "Retrieving active sprint ..."
SPRINT_ID=`jget "agile/1.0/board/$JIRA_BOARD_ID/sprint?state=active" | jq '.values[0].id'`
echo "Adding issue to active sprint ..."
jpost "agile/1.0/sprint/$SPRINT_ID/issue" "{\"issues\":[\"$ISSUE_ID\"]}" > /tmp/post-response.json
RESP=`cat /tmp/post-response.json`
if [ -n "$RESP" ]; then
    echo "Failed to add issue to sprint! Check /tmp/post-response.json."
    exit 1
fi

# finish
echo "Done: https://moovel.atlassian.net/browse/$ISSUE_ID"
