#!/system/bin/sh
while [ -z "$(getprop sys.boot_completed)" ]; do
	sleep 5
done
su -lp 2000 -c "cmd notification post -S bigtext -t Task`Profile tag 'Yay! Its time for snacks!😋'"
