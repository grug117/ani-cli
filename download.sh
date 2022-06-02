#!/bin/bash
# originaly from https://github.com/shitpostbotmin/script-bin/blob/main/full-season-ani-cli.sh with tweaks

if [[ $# != 5 ]]; then
    >&2 echo "Usage: full-season-ani-cli <query> <show name> <show season #> <start ep #> <end ep #>"
    >&2 echo "Example: full-season-ani-cli \"zombie land saga revenge\" \"Zombie Land Saga\" 2 1 12"

    ani-cli
else
    query=$1
    show_name=$2
    season_name=$3
    start_episode=$4
    end_episode=$5

    # builds safe folder path for downloading
    folder_name=$(echo $show_name | tr " " "-")
    download_folder=$DOWNLOAD_DIR/$folder_name

    # builds space delimited list of all epsiodes in the range of start to end
    episodes="$(seq -s ' ' $start_episode $end_episode)"
    # downloads the query results to new folder
    ani-cli -a "$episodes" -p "${DOWNLOAD_DIR}/${folder_name}" "${query}"


    # rename all the new files
    cd $download_folder
    ls | while read file ; do
        season="S0$(echo "$show_season")E$(echo $file | sed -r -n 's/^.*[0-9]([0-9]{2}).*$/\1/gp')";
        ext=$(echo $file | sed -E 's/(.+)(\.)(.*$)/\3/g');
        mv "$file" "$show_name - $season.$ext";
    done;
fi
