#/bin/bash
echo "paste the link"
read link

#if url has "/watch" or "/" in the end then remove them.
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
php hotstarlivestreamer.php "$link"
if [[ "$last" = "c" ]]
then echo "enter the Id of the video (example write 1000021386)"
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
