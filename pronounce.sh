#!/bin/sh

# pronounce.sh
# Fetches the pronounciation of a word from Wiktionary
# Lisc: ISC

# Config:
player="play"

WORD=$1
OPTIONTWO=$2

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

	if [ -n "$OPTIONTWO" ]
	then
		case "$OPTIONTWO" in
			-p)
				ftp -Vo $fl $FL_URL > /dev/null
				$player $fl
				;;
			-o)
				ftp -Vo "$3" $FL_URL > /dev/null
				;;
			-po)
				ftp -Vo "$3" $FL_URL > /dev/null
				$player "$3"	
				;;
		esac
	elif [ -z "$OPTIONTWO" ]
	then
		ftp -V  $FL_URL > dev/null
	fi
done

# Cleanup
rm $wd_pg $fl_pg $fl_pg_url $fl_url $fl
