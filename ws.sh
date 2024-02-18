#!/bin/env bash
space="$HOME/workspace"
declare -A folders
folders["data"]='/run/media/zeatoen/Files/data'
folders["me"]='/run/media/zeatoen/Files/git/sriramsbplmem/me'


ensure_entry(){
	if [[ $workdir &&  `echo $(  ls "$space/.config" )| grep $workdir.json`  ]];then echo "entry present";
	else echo "entry absent";
			exit;
	fi
}

parse_link(){


	while read -r line ;do
	echo $line 	
	folder=`echo $line | awk -F':' '{print $1}' | sed 's/"//' `
	file=`echo $line | awk -F':' '{print $2}' | sed 's/"$//'` 
	link="${folders[$folder]}/$file"
	 
	ln -s "$link" "$space/$workdir/$file" 
	done
}

workdir=$2
case $1 in

  load)
   
	  
	ensure_entry
	if ! [[ -d $space/$workdir ]];then
			mkdir $space/$workdir
			jq   ".contents[]" $space/.config/$workdir.json |parse_link
		else
			echo "wokspace already present"
	fi
	cd $space/$workdir	
	bash
	;;
	unload)
		if [[ -d $space/$workdir ]]; then
			rm -r $space/$workdir
			echo "success."
			exit
		fi

	;;
  *)
    echo "command not found $1"
	exit
	;;
esac







