#!/bin/bash

#presettings
shopt -s nocasematch
clear

#variables
varconfd="/home/$USER/.config/findplayer"
default=viu ; opener=default

#prelaunch and configuration checks
echo "Checking for configuration folders" ; [[ -d "/home/$USER/.config/findplayer" ]] && echo "Config folder found!" || mkdir -p /home/$USER/.config/findplayer || echo "Config folder was created"
echo "Checking for prefered source configuration file" ; ! [[ -f "$varconfd/source" ]] && varsource=missing && echo "A configuration file is missing" || sourcetest=$(cat "$varconfd/source")
#checking if stored value in configuration files are working and correct
[[ -d "$sourcetest" ]] && echo "Found and checked prefered source folder, resuming initial check" && varsource=1 || echo "The directory being pointed to by the prefered source configuration file isn't correct, or is corrupted. Resuming initial check, initiating repairs."
#making and writting needed files
[[ "$varsource" == "missing" || -z "$varsource" ]] && echo "The source image folder is missing, please enter desired folder from root without the last '/' , example : </home/$USER> instead of </home/$USER/>." && read var_m_src && printf "$var_m_src" > "$varconfd/source"
varsrcd=$(cat "$varconfd/source") ; varsrcf=$(ls "$varsrcd/")
#prelaunch finished
echo "Prelaunch finished" ; checked=true
#end prelaunch

#functions
function i_input {
varselect=$(rlwrap -e '' -i -f <(echo "${varsrcf[@]}") -o cat)
}
function o_input {
echo "1) feh" ; echo "2) xdg-open" ; echo "3) viu"
read varoinput
[[ "$varoinput" == "1" || "$varoinput" == "feh" ]] && opener=feh
[[ "$varoinput" == "2" || "$varoinput" == "xdg-open" ]] && opener=xdg-open
[[ "$varoinput" == "3" || "$varoinput" == "viu" ]] && opener=viu
}
function rimageselect {
[[ -z "$varrun" ]] && echo "An image has been randomly selected for you" || echo "A new image has been selected for you" ; varrun=1
varrand0=$(shuf -e ${varsrcf} -n1)
viu "$varsrcd/$varrand0" -w 20
}
#end functions

#code
echo "Welcome to Find-Displayer version 0.0.4"
echo "The selected folder for display is set to $varsrcd/"
echo "Press [ENTER] to continue, or type in the new folder path starting from root, without the last end /"
echo "example : </home/$USER> instead of </home/$USER/>"
read newfolder
[[ -d "$newfolder" ]] && echo "Folder location found and confirmed, do you wish to write folder location for future uses? [y/n], or [ENTER] to skip." && read varaskf
[[ "$varaskf" == "y" || "$varaskf" == "yes" ]] && printf "$newfolder" > "$varconfd/source" && varsrcd=$(cat "$varconfd/source") && varsrcf=$(ls "$varsrcd/")
[[ "$varaskf" == "n" || "$varaskf" == "no" ]] && varsrcd=newfolder && varsrcf=$(ls "$varsrcd/")
[[ -z "$newfolder" ]] && echo "No input, folder not changed" && varsrcd=$(cat "$varconfd/source") && varsrcf=$(ls "$varsrcd/")
echo "Config done"
#sleep 1 && clear
rimageselect
echo "Press [ENTER] to skip, or select an opener for $varrand0"
o_input
#clear below after ]]
! [[ -z "$varoinput" ]] && "$opener" "$varsrcd/$varrand0" && echo "Press enter to continue" && read billgates && clear
echo "ls of $varsrcd/" ; ls -a "$varsrcd/" ; echo "Manually enter a filename (you can press [TAB] for autocompletion), or type 'exit' , 'reload' , 'random' ." ; i_input
[[ "$varselect" == "exit" ]] && exit ; [[ "$varselect" == "reload" ]] && exec bash $0 $@
[[ "$varselect" == "random" ]] && varselect=$(shuf -e ${varsrcf} -n1)
echo "Press [ENTER] to select the default opener ($default) or select another"
o_input
! [[ -z "$varoinput" ]] && "$opener" "$varsrcd/$varselect" || "$default" "$varsrcd/$varselect"
#end code
