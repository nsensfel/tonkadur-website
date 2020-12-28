compile:
	hugo
	scp -r public/* dreamhost:~/tonkadur/
