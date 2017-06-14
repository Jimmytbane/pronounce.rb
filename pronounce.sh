#!/bin/sh

# pronounce.sh
# Fetches the pronounciation of a word from Wiktionary
# Lisc: ISC

# Config:
player="play"

WORD=$1
INDEX=0
if echo "$2" | grep "\-." > /dev/null
then
	OPTION="$2"
	OUTPUT="$3"
elif echo "$2" | grep ".$" > /dev/null
then
	LIMIT="$2"
	if [ -n "$3" ]
	then
		OPTION="$3"
		OUTPUT="$4"
	fi
fi

wd_pg=/tmp/wt_wd_pg
fl_pg=/tmp/wt_fl_pg
fl_pg_url=/tmp/wt_fl_pg_url
fl_url=/tmp/wt_fl_url
fl=/tmp/wt_file


ftp -Vo $wd_pg "https://en.wiktionary.org/wiki/$WORD" > /dev/null
grep "\"audiometa\"" $wd_pg > $fl_pg_url
sed -i 's^.*href="^^g' $fl_pg_url
sed -i 's^" title.*^^g' $fl_pg_url
sed -i 's^/wiki/^https://en.wiktionary.org/wiki/^g' $fl_pg_url

for FL_PG_URL in $(cat $fl_pg_url)
do
	ftp -Vo $fl_pg "$FL_PG_URL" > /dev/null
	grep "class=\"fullMedia\"><a href=" $fl_pg > $fl_url
	sed -i 's^.*a href="^^g' $fl_url
	sed -i 's^" class="internal".*^^g' $fl_url

	FL_URL=$(echo "https:$(cat $fl_url)")

	if [ -n "$OPTION" ]
	then
		case "$OPTION" in
			-p)
				ftp -Vo $fl $FL_URL > /dev/null
				$player $fl
				;;
			-o)
				ftp -Vo "$OUTPUT" $FL_URL > /dev/null
				;;
			-po)
				ftp -Vo "$OUTPUT" $FL_URL > /dev/null
				$player "$OUTPUT"	
				;;
		esac
	elif [ -z "$OPTION" ]
	then
		ftp -V  $FL_URL > /dev/null
	fi
	if [ -n "$LIMIT" ]
	then
		INDEX=$((INDEX+1))
		if [ $LIMIT -eq $INDEX ]
		then
			rm $wd_pg $fl_pg $fl_pg_url $fl_url $fl
			exit
		fi
	fi
done

# Cleanup
rm $wd_pg $fl_pg $fl_pg_url $fl_url $fl 2> /dev/null
