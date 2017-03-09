#!/bin/bash

SALT='see you space cowboy'
WEBROOT='/var/www/website.com/subfolder/'
MOVIE='/home/username/movies/2001 - A Space Odyssey (1968).video'

function generate_image() {
    movie_lenght_in_seconds=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$MOVIE")
    movie_random_timestamp_in_seconds=$(shuf -i 60-${movie_lenght_in_seconds%.*} -n 1)
    filename=$(echo $SALT $movie_random_timestamp_in_seconds | sha1sum | awk '{print $1}').jpg
    ffmpeg -ss $movie_random_timestamp_in_seconds -i "$MOVIE" -f mjpeg -vframes 1 -y -loglevel panic /tmp/$filename
    echo $filename
}

function crop_black_bars {
    convert /tmp/$1 -fuzz 5% -trim ${WEBROOT}$1 && rm /tmp/$1
}

IMAGE_FILENAME=/dev/null
until [ $(crop_black_bars $IMAGE_FILENAME 2>&1 | grep -qE '^convert: '; echo $?) -eq 1 ]; do
    IMAGE_FILENAME=$(generate_image)
done

echo $IMAGE_FILENAME
