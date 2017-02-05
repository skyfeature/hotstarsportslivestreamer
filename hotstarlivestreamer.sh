#/bin/bash

#Get terminal proxy
if (env | grep -q http_proxy)
then
	http_proxy=$(env | grep http_proxy | cut -f2 -d"=")
	echo "You are using proxy: "
	echo $http_proxy
	echo "Hint: To change HTTP PROXY use \"export http_proxy=http://username:password@proxyhost:port/\""
else
	if [ $(gsettings get org.gnome.system.proxy mode) != 'none' ]
	then
		echo "Hint: Try setting terminal proxy if this does not work."
	else
		echo "You are not using any proxy"
	fi
fi

echo "paste the link"
read link

#if url has "/watch" or "/" in the end
if [[ "$link" == */watch ]]
then
	link=${link%??????}
elif [[ "$link" == */ ]]
then
	link=${link%?}
fi


last=${link: -1}
folder=$PWD/videos/
livestreamer=""


#hijack $link and pass proxy with it.
link=$link"#"$http_proxy


php hotstarlivestreamer.php "$link"
if [[ "$last" = "c" ]]
then 
	echo "enter the Id of the video (example write 1000021386)"
	read id
	php hotstarlivestreamer.php "$link" "$id"
	echo "write quality (example write 720p)"
	read quality
	php hotstarlivestreamer.php "$link" "$id" "$quality" "$folder" "$livestreamer"
else
	echo "write quality (example write 720p)"
	read quality
	echo "play or download? (write p or d)"
	read choice
	php hotstarlivestreamer.php "$link" "$quality" "$folder" "$livestreamer" "$choice"
fi