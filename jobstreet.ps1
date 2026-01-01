if ($args) {
	$bulk_url = $args
} else {
	$bulk_url = $input | % { $_ }
}

if (-not $bulk_url) {
	Write-Output 'jobstreet.ps1 — Search jobs with specific keyword'
	Write-Output 'Usage:'
	Write-Output '	jobstreet [URL1] [URL2]'
	Write-Output "	'[URL1]', '[URL2]', '[URL3]' | jobstreet"
	exit
}


############################


function job_search ($url) {
	python3 ./crawl.py $url 2>&1 | Tee-Object -Variable a | Out-Null
	$a = $a -join "`n"


	$base_url = 'https://id.jobstreet.com'

	$match1 = [regex]::Matches($a, "(?ims)###.*?\[(.+?)\]\((.+?)\)\n\nat \[(.+?)\](.+?)\!\[\]")

	foreach ($m in $match1) {
		if ($m.Groups[2].Value -match '^/job/') {
			$m.Groups[3].Value							# company
			"`t" + $m.Groups[1].Value					# role
			
			$match2 = [regex]::Match($m.Groups[4].Value, "\n\n(.+?per (hour|jam|week|minggu|month|bulan|year|tahun))")
			if ($match2) {
				"`t" + $match2.Groups[1].Value			# salary
			}

			"`t" + $base_url + $m.Groups[2].Value		# link
			
			''
		}
	}
}

#$target_url = 'https://id.jobstreet.com/jobs-in-information-communication-technology/remote'
$bulk_url | %{ job_search "https://id.jobstreet.com/$_-jobs" }

