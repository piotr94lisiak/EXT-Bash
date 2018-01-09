#!/usr/bin/bash

if [[ $# == 0 ]]
then
	echo "     Za mało argumentów wywołania. Wywołaj program z parametrem '--help' po więcej informacji."

elif [[ $# == 1 && $1 == "--help" ]]
then

	echo "
	 _____________________________________________________________
	|                                                             |
	|   Program 'ext.sh' zamienia rozszerzenia plików. Można go   |
	|   wywołać w dwóch trybach.                                  |
	|                                                             |
	|   Tryb I:                                                   |
	|                                                             |
	|   Zamiana  wszystkich  plików  o  rozszerzeniu podanym  w   |
	|   parametrze  1  na  pliki  z  rozszerzeniem   podanym  w   |
	|   parametrze 2.                                             |
	|                                                             |
	|   Składnia:                                                 |
	|                                                             |
	|   ./ext.sh [1][STARE ROZSZERZENIE] [2][NOWE ROZSZERZENIE]   |
	|                                                             |
	|   Przykład:                                                 |
	|                                                             |
	|   ./ext.sh jpeg jpg                                         |
	|                                                             |
	|   Tryb II:                                                  |
	|                                                             |
	|   Zamiana pliku z parametru 1  o  rozszerzeniu  podanym w   | 
	|   parametrze  2  na  plik  z   rozszerzeniem  podanym   w   |
	|   parametrze 3.                                             |
	|                                                             |
	|   Składnia:                                                 |
	|                                                             |
	|   ./ext.sh  [1][NAZWA PLIKU]  [2][STARE ROZSZERZENIE]       |
	|   [3][NOWE ROZSZERZENIE]                                    |
	|                                                             |
	|   Przykład:                                                 |
	|                                                             |
	|   ./ext.sh tapeta.jpeg jpeg jpg                             |
	|                                                             |
	|                           UWAGA:                            |
	|                                                             |
	|    Program zamienia nazwy plików  gdy  występują  w nich    |
	|    spacje. Znak spacji zamieniany jest na  podkreślenie.    |
	|_____________________________________________________________|
	"
exit

elif [[ $# == 1 && $1 != "--help" ]]
then
	echo "     Nieprawidłowe argumenty wywołania. Wywołaj program z parametrem '--help' po więcej informacji"
	
#Zamiana wszystkich plików z rozszerzeniem z parametru $1 na rozszerzenia z parametru $2.
	
elif [[ $# == 2 ]]
then

	#Przygotowanie zmiennych

	ext_old="."$1
	ext_new="."$2
	ext_old_length=${#ext_old}
	path=`pwd`
	file_path_length=${#path}
	file_path=$path"/*"${ext_old}

	#Zamiana spacji na podkreślenia

	find . -name "* *" | while read; do
	  mv "$REPLY" "${REPLY// /_}"
	done

	#Zamiana rozszerzeń odpowiednich plików

	for files in $file_path
	do
		if [ -e $files ]
		then
			old_file=${files:$file_path_length+1}
			new_file=${files:$file_path_length+1:${#old_file}-$ext_old_length}
			new_file=$new_file$ext_new
			echo -e "     Zmiana rozszerzenia pliku $old_file na $new_file"
			mv $old_file $new_file
		else
			echo "     Nie znaleziono plików o rozszerzeniu: $ext_old
     W razie problemów wywołaj program z parametrem '--help' po więcej informacji."
		fi
	done

#Zamiana pliku podanego w parametrze $1 z rozszerzeniem $2 na rozszerzenie $3.
	
elif [[ $# == 3 ]]
then

	#Przygotowanie zmiennych

	tmp_file=$1
	ext_old="."$2
	ext_new="."$3
	ext_old_length=${#ext_old}
	path=`pwd`
	file_path_length=${#path}
	file_path=$path"/"$1
	
	#Zamiana spacji na podkreślenia

	find . -name "* *" | while read; do
	  mv "$REPLY" "${REPLY// /_}"
	done

	#Zamiana rozszerzenia pliku $1
	
	if [ -e $tmp_file ]
	then
		for tmp_file in $file_path
		do
			if [ -e $tmp_file ]
			then
				old_file=${tmp_file:$file_path_length+1}
				new_file=${tmp_file:$file_path_length+1:${#old_file}-$ext_old_length}
				new_file=$new_file$ext_new
				echo -e "     Zmiana rozszerzenia pliku $old_file na $new_file"
				mv $old_file $new_file
			else
				echo "     Plik $1 nie ma rozszerzenia: $ext_old
     W razie problemów wywołaj program z parametrem '--help' po więcej informacji."
			fi
		done
	else
		echo "     Nie znaleziono pliku $1
     W razie problemów wywołaj program z parametrem '--help' po więcej informacji."
	fi
elif [[ $# > 3 ]]
then
	echo "     Za dużo argumentów wywołania. Wywołaj program z parametrem '--help' po więcej informacji."
fi
