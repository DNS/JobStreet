#$target_url = 'https://id.jobstreet.com/jobs-in-information-communication-technology/remote'
$target_url = "https://id.jobstreet.com/$args-jobs"



############################

# BUG, Tee-Object does'nt
python3 ./crawl.py $target_url 2>&1 | Tee-Object -Variable a | Out-Null
$a = $a -join "`n"

#python3 ./crawl.py $target_url | Out-File test.txt
#$a = gc test.txt -Raw


############################

$base_url = 'https://id.jobstreet.com'
$match1 = [regex]::Matches($a, "(?ims)###.*?\[(.+?)\]\((.+?)\)\n\nat \[(.+?)\](.+?)\!\[\]")

foreach ($m in $match1) {
	if ($m.Groups[2].Value -match '^/job/') {
		$m.Groups[3].Value							# company
		"`t" + $m.Groups[1].Value					# role
		"`t" + $base_url + $m.Groups[2].Value		# link
		
		
		$match2 = [regex]::Match($m.Groups[4].Value, "\n\n(.+?per (hour|jam|week|minggu|month|bulan|year|tahun))")
		if ($match2) {
			"`t" + $match2.Groups[1].Value			# salary
		}
		
		'------------------------'
	}
}


