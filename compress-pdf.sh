#!/bin/sh

Help()
{
   # Display Help
   echo "Usage: compress-pdf [-q|h] [FILE]"
   echo "Compresses a pdf file."
   echo
   echo "arguments:"
   echo "FILE   The pdf file to be compressed."
   echo
   echo "options:"
   echo "q     Define the quality. int in {1, ...,  5}."
   echo "h     Print this Help."
   echo
}

Quality()
{
	quality=$OPTARG
}

quality=1

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
	  q)
		 Quality
		 exit;;
   esac
done

if [ "$#" -ns 1 ]; then
    echo "Illegal number of arguments"
	echo
	Help
	exit
fi


case $quality in
	1)
		qs=/screen;;
	2)
		qs=/default;;
	3)
		qs=/ebook;;
	4)
		qs=/printer;;
	5)
		qs=/prepress;;
esac

echo "Quality set to "$quality"/5"
echo "Compressing "$1"..."
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=$qs -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages=true -sOutputFile=compressed-$1 $1
# Quality is controlled with (from low to high)
# /screen, /default, /ebook, /printer, /prepress
wc -c $1
wc -c compressed-$1



