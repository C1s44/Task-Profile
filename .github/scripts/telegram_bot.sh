#!/bin/env bash

msg="*$TITLE*
Branch: $BRANCH
\\#ci\\_$VERSION
\`\`\`
$COMMIT_MESSAGE 
\`\`\`
[Commit]($COMMIT_URL)
[Workflow run]($RUN_URL)
"
thumbnail="$GITHUB_WORKSPACE/patch/website/webo.jpg

file="$1"


	response=$(curl -s -F document=@"$file" -F thumbnail=@"$thumbnail" \
	"https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
	-F chat_id="$CHAT_ID" \
	-F "disable_web_page_preview=true" \
	-F "parse_mode=markdownv2" \
	-F caption="$msg")

echo "$response"
