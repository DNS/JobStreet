# jobstreet.ps1 — Show available jobs with salary > 80jt

#$a = iwr 'https://id.jobstreet.com/jobs-in-information-communication-technology?salaryrange=80000000-&salarytype=monthly' | % Content
$a = iwr 'https://id.jobstreet.com/jobs?salaryrange=80000000-&salarytype=monthly' | % Content

$m = $a -match '(?ims)window.SEEK_REDUX_DATA =(.+?);\n    '

$j = $Matches[1] | ConvertFrom-Json
$r = $j.results.results.jobs

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






