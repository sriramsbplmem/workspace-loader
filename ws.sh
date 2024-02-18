#!/bin/env bash
workdir=$1
space="$HOME/workspace"
declare -A folders
folders["data"]='/run/media/zeatoen/Files/data'
folders["me"]='/run/media/zeatoen/Files/git/sriramsbplmem/me'

if [[ $workdir &&  `echo $(  ls "$space/.config" )| grep $workdir.json`  ]];then echo "entry present";
else echo "entry absent";
		exit;
fi

cat $space/.config/$1.json

# mkdir $space/$1
parse(){


	while read -r line ;do
	echo $line 	
	folder=`echo $line | awk -F':' '{print $1}' | sed 's/"//' `
	file=`echo $line | awk -F':' '{print $2}' | sed 's/"$//'` 
	link="${folders[$folder]}/$file"
	 
	ln -s "$link" "$space/$workdir/$file" 
	done
}

if ! [[ -d $space/$workdir ]];then
		mkdir $space/$workdir
		jq   ".contents[]" $space/.config/$1.json |parse
fi



cd $space/$workdir

exec bash


