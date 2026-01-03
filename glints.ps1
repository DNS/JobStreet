if ($args) {
	$bulk = $args
} else {
	$bulk = $input | % { $_ }
}

if (-not $bulk) {
	Write-Output 'jobstreet.ps1 — Search jobs with specific keyword'
	Write-Output 'Usage:'
	Write-Output '	jobstreet [KEYWORD1] [KEYWORD2]'
	Write-Output "	'[KEYWORD1]', '[KEYWORD2]' | jobstreet"
	exit
}

############################

$base_url = 'https://glints.com'

function job_search ($url) {
	python3 ./crawl.py $url | Tee-Object -Variable a | Out-Null

	$a = $a -join "`n"

	$match1 = [regex]::Matches($a, "(?ims)## \[(.+?)\]\((.+?)\)(.+?)\!\[(.+?)\]" )

	foreach ($m in $match1) {
		$m.Groups[4].Value									# company
		"`t" + $m.Groups[1].Value							# role
		
		$m.Groups[3].Value -match "`n(Rp.+?)`n" | Out-Null
		"`t" + $Matches[1]									# salary
		
		"`t" + $base_url + $m.Groups[2].Value				# link
		
		''
	}
}



$bulk | %{ $_ -replace ' ', '+' } | %{ job_search "https://glints.com/id/opportunities/jobs/explore?keyword=$bulk&country=ID" }


