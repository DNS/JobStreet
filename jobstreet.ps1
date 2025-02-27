# jobstreet.ps1 — Show available jobs with salary > 80jt, Search jobs

if ($args) {
	$bulk_url = $args
} else {
	$bulk_url = $input | % { $_ }
}

if (-not $bulk_url) {
	Write-Output 'Usage:'
	Write-Output '	jobstreet [URL1] [URL2]'
	Write-Output "	'[URL1]', '[URL2]', '[URL3]' | jobstreet"
	exit
}

function job_max ($url) {
	$a = iwr $url | % Content
	$m = $a -match '(?ims)window.SEEK_REDUX_DATA =(.+?);\n    '
	if (-not $m) { 'No jobs found!' ; exit }
	$j = $Matches[1] | ConvertFrom-Json

	''

	foreach ($i in $j.results.results.jobs) {
		if ($i.salaryLabel -and $i.salaryLabel -ne 0) {
			$i.advertiser.description
			'    ' + $i.roleId
			'    ' + $i.listingDateDisplay
			'    ' + $i.salaryLabel
			''
		}
	}

	''

}


function job_search ($url) {
	$a = iwr $url | % Content
	$m = $a -match '(?ims)window.SEEK_REDUX_DATA =(.+?);\n    '
	if (-not $m) { 'No jobs found!' ; exit }
	$j = $Matches[1] | ConvertFrom-Json
	$m
	''

	foreach ($i in $j.results.results.jobs) {
#		if ($i.salaryLabel -and $i.salaryLabel -ne 0) {
			$i.advertiser.description
			'    ' + $i.roleId
			'    ' + $i.listingDateDisplay
			'    ' + $i.salaryLabel
			''
#		}
	}

	''

}



#job_max 'https://id.jobstreet.com/jobs-in-information-communication-technology?salaryrange=25000000-&salarytype=monthly'
#job_max 'https://id.jobstreet.com/jobs-in-information-communication-technology?salaryrange=40000000-&salarytype=monthly'
#job_max 'https://id.jobstreet.com/jobs-in-information-communication-technology?salaryrange=80000000-&salarytype=monthly'


$args | %{ job_search "https://id.jobstreet.com/$_-jobs" }



