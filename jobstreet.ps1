
$a = iwr 'https://id.jobstreet.com/jobs-in-information-communication-technology?salaryrange=80000000-&salarytype=monthly' | % Content

$m = $a -match '(?ims)window.SEEK_REDUX_DATA =(.+?);\n    '

$j = $Matches[1] | ConvertFrom-Json
$j.results.results.jobs.advertiser.description
$j.results.results.jobs.listingDateDisplay
$j.results.results.jobs.salaryLabel






