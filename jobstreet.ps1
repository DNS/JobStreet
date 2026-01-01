#$a = py ./crawl.py

$base_url = 'https://id.jobstreet.com'

$a = gc test.txt -Raw

$match1 = [regex]::Matches($a, "(?ims)###.*?\[(.+?)\]\((.+?)\)(.+?)\!\[\]")

foreach ($m in $match1) {
	if ($m.Groups[2].Value -match '^/job/') {
		$m.Groups[1].Value
		"`t" + $base_url + $m.Groups[2].Value
		
		$match2 = [regex]::Match($m.Groups[3].Value, "\n\n(.+?per (month|year))")
		if ($match2) {
			"`t" + $match2.Groups[1].Value
		}
		
		'------------------------'
	}
}




#(Rp.+?per month)`n

