compile:
	hugo
	#scp -r public/* dreamhost:~/tonkadur/
	rsync -rzP --delete public/ dreamhost:~/tonkadur/
