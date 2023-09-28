
comment_url="https://api.github.com/repos/apazg7/myapp-src/issues/7/comments"

token="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"

trivy_report=$(trivy image apazg7/myapp:1.0.1 --format json | jq -r '.Results[1].Vulnerabilities[] | "\(.VulnerabilityID), \(.PkgName) \(.InstalledVersion)\n<br>"' | xargs echo )

temp_file=$(mktemp)

echo "{\"body\": \"${trivy_report}\"}" > "${temp_file}"

cat "${temp_file}"

curl -s -X POST -H "Authorization: token ${token}" -d "@${temp_file}" "${comment_url}"

