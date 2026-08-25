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
file="$1"
thumbnail="$GITHUB_WORKSPACE/logo.jpg"

if [ ! -f "$file" ]; then
	echo "error: File not found" >&2
	exit 1
fi

curl -s -F document=@$file "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
	-F chat_id="$CHAT_ID" \
	-F "disable_web_page_preview=true" \
	-F "parse_mode=markdownv2" \
	-F thumb=@"$thumbnail" \
	-F caption="$msg"
