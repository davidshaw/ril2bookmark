#!/bin/bash
# @author: dshaw@dshaw.net
# @date:   June 9, 2012
# @desc:   Converts Pocket/Read It Later HTML Export to Chrome/Netscape bookmark

# usage notes
if [[ $# -ne 1 ]]; then
	echo "ril2chrome.sh usage:";
	echo -e "\t./ril2chome.sh <ril export file>";
	exit;
fi

# seconds since epoch (for chrome format bookmarks)
date=$(date +%s);

# beginning format of bookmark format
echo -n '<!DOCTYPE NETSCAPE-Bookmark-file-1>
<!-- This is an automatically generated file.
     It will be read and overwritten.
     DO NOT EDIT! -->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks</TITLE>
<H1>Bookmarks</H1>
<DL><p>
	<DT><H3 ADD_DATE="0" LAST_MODIFIED="';
echo -n $date;
echo '" PERSONAL_TOOLBAR_FOLDER="true">ReadItLater</H3>
   <DL><p>';

# change format - regex ftw :)
cat $1 | grep li | sed 's/.*href="\(.*\)" time.*">\(.*\)<\/a>.*/<DT><A HREF="\1">\2<\/A>/g'

echo '   </DL><p>';
echo '</DL><p>'

# done!
