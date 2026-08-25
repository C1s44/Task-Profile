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

if [ -f "$thumbnail" ]; then
	response=$(curl -s -F document=@"$file" -F thumbnail=@"$thumbnail" \
		"https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
		-F chat_id="$CHAT_ID" \
		-F "disable_web_page_preview=true" \
		-F "parse_mode=markdownv2" \
		-F caption="$msg")
else
	echo "warning: logo.jpg tidak ditemukan, kirim tanpa thumbnail" >&2
	response=$(curl -s -F document=@"$file" \
		"https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
		-F chat_id="$CHAT_ID" \
		-F "disable_web_page_preview=true" \
		-F "parse_mode=markdownv2" \
		-F caption="$msg")
fi

echo "$response"
if ! echo "$response" | grep -q '"ok":true'; then
	echo "::error::Gagal kirim ke Telegram: $response"
	exit 1
fi
