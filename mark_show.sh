###################################
# Author: Vinay NK
# Organization: IIT Madras
# Purpose: keep stack of commonly used path and have easy access to them 
# Usage: mark . => To put the current path onto the stack
#        mark s => Show the stack
#        mark <string> => go to the first hit after searching through the stack
#Important: Please put the following code onto your bashrc
#       alias mark="source ${HOME}/mark.sh"
###################################

fileName="${HOME}/.markedLocations.txt"
flag=0

if [ "${1}" = "." ]; then
   pwd >>${fileName}
   flag=1
fi
if [ "${1}" = "s" ]
then
   touch "${fileName}"
   line_no=1
   color1='\e[1;35m'
   color2='\e[1;32m'
   while read line
   do
      color=$color2
      if [[ $(($line_no%2)) -eq 1 ]]; then
         color=$color1
      fi
      echo -e "\t$color${line_no}\t$line";
      line_no=$(($line_no+1))
   done < ${fileName}
   echo -en '\e[0m';
   flag=1
fi
if [[ "${1}" =~ ^[0-9]+$ ]]; then
   #pathCmd="awk "FNR==${1}" ${fileName}"
   pathCmd="sed -n -e "${1}p" ${fileName}"
   path=`${pathCmd}`
   echo ${path}
   if [[ "${path}" = "" ]]; then
      echo "NO MARK"
   else
      cd ${path}
   fi
   flag=1
fi
if [ "${flag}" = "0" ]
then
   #cat -n ${fileName} 2>/dev/null|grep -i "$1"
   #path=cat -n ${fileName} 2>/dev/null|grep -i "$1"
#   path="$(grep -in  ${1} $fileName ) "

   lineCount="$(grep -in  ${1} $fileName | wc -l )"

   if [[ $lineCount -gt 1 ]]; then
       grep_out="$(grep -in  ${1} $fileName ) "
       color1='\e[1;35m'
       color2='\e[1;32m'
       color=$color1
       for ele in $grep_out
       do
        if [ "$color" = "$color1" ]; then
            color="$color2"
        else
            color="$color1"
        fi
         ele=`echo $ele |sed -e "s|:|\t|g"`
        #echo -e "\t$color${line_no}\t$line";
           echo -e "\t$color$ele";
       done

   elif [[ $lineCount == 1 ]]; then        
       path="$(grep ${1} $fileName| head -n1)"
       echo  $path;
       cd "$path"
   fi

#   echo  $path;

fi
