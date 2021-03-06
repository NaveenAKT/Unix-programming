 #!/bin/bash
 #

#
# This game reads a list of words from a dict.dat file in the same directory as
# the script.
#


#initialize the variables and arrays we need
 declare -a word
 declare -a word_img
 declare -a alpha_img
 i=0
 incorrect=0
 wordindex=0
 correct=0
 alpha=("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")
 char=0
 
#this function reads the list of words from the dict.dat file and
#put them into the word array
 function readfile
 {
 
 exec 3<&0
 exec 0< dict.dat
 while read LINE
 do
 
 word[i]=$LINE
 i=`expr $i + 1`
 done
 exec 0<&3
 }

#this function randomly selects a word from the word array.
 function readword {
 	word_index=$RANDOM
 
 	while [ $word_index -ge $i ]
 	do
 		word_index=$RANDOM
 	done
 	a=0
 	while [ $a -lt ${#word[${word_index}]} ]
 	do
 		word_img[$a]=0
 		a=`expr $a + 1`
 	done
 }
 
#this function solicits a guess from the user and then checks
#the guess to see if it is valid/correct/incorrect.
 function guess
 {
 	j=0
 	correct=0
 	echo -n "Guess a letter: "
 	read guess
 	char=$guess
 	if [ ${#guess} -eq "1" ]
 	then
 	
 		guess=`echo $guess | tr "[:upper:]" "[:lower:]"`
 		while [ $j -lt ${#word[${word_index}]} ]
 		do
 			if [ "$guess" == "${word[${word_index}]:$j:1}" ]
 			then
 				word_img[${j}]=1
 				correct=1
 			fi
 			j=`expr $j + 1`
 		done
 	fi
 	r=0
 	numletter=0
 	while [ ! $r == ${#word[${word_index}]} ]
 	do
 		numletter=`expr $numletter + ${word_img[$r]}`
 		r=`expr $r + 1`
 	done
 }
 

#the following functions draw the gallows and hanged man to the terminal
 function gallows 
 {
 clear
 echo "          __________"
 echo "         |         |"
 echo "         |         |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "      _____________|_____"
 echo "                           "
 }
 function gallows_head 
 {
 clear
 echo "          __________"
 echo "         |         |"
 echo "         |         |"
 echo "       _/_\_       |"
 echo "        |_|        |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "      _____________|_____"
 echo "                           "
 }
 function gallows_body {
 clear
 echo "          __________"
 echo "         |         |"
 echo "         |         |"
 echo "       _/_\_       |"
 echo "        |_|        |"
 echo "         |         |"
 echo "         |         |"
 echo "         |         |"
 echo "         |         |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "      _____________|_____"
 echo "                           "
 }
 function gallows_arm1 {
 clear
 echo "          __________"
 echo "         |         |"
 echo "         |         |"
 echo "       _/_\_       |"
 echo "        |_|        |"
 echo "         |         |"
 echo "      ---|         |"
 echo "         |         |"
 echo "         |         |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "      _____________|_____"
 echo "                           "
 }
 function gallows_arm2 {
 clear
 echo "          __________"
 echo "         |         |"
 echo "         |         |"
 echo "       _/_\_       |"
 echo "        |_|        |"
 echo "         |         |"
 echo "      ---|---      |"
 echo "         |         |"
 echo "         |         |"
 echo "                   |"
 echo "                   |"
 echo "                   |"
 echo "      _____________|_____"
 echo "                           "
 }
 function gallows_leg1 {
 clear
 echo "          __________"
 echo "         |         |"
 echo "         |         |"
 echo "       _/_\_       |"
 echo "        |_|        |"
 echo "         |         |"
 echo "      ---|---      |"
 echo "         |         |"
 echo "         |         |"
 echo "        /          |"
 echo "       /           |"
 echo "                   |"
 echo "      _____________|_____"
 echo "                           "
 }
 function gallows_leg2 {
 clear
 echo "          __________"
 echo "         |         |"
 echo "         |         |"
 echo "       _/_\_       |"
 echo "        |_|        |"
 echo "         |         |"
 echo "      ---|---      |"
 echo "         |         |"
 echo "         |         |"
 echo "        / \        |"
 echo "       /   \       |"
 echo "                   |"
 echo "      _____________|_____"
 echo "                           "
 }

#this function prints the win screen
 function win {
 echo "*     *  *******  *    *  * "
 echo "*     *     *     **   *  * "
 echo "*     *     *     * *  *  * "
 echo "*     *     *     *  * *  * "
 echo " * * *      *     *   **    "
 echo "  * *    *******  *    *  * "
 echo -en "\n\n\n"
 }
 
#this function prints the lose screen
 function lose {
 echo "$(tput setaf 1)lose...$(tput sgr 0)"
 echo ""
 echo "$(tput setaf 1)$(tput setab 7) The word was $(tput sgr 0) ${word[$word_index]}"
 }

#this function prints the guessed letters to the screen and
#underscores for letters that haven't been guessed
 function print_alpha {
 	echo -e "\nLetters Guessed:"
 	
 	e=0
 	while [ ! "$e" == "26" ]
 	do
 		if [ "$char" == "${alpha[$e]}" ]
 		then
 			alpha_img[$e]="1"
 		fi
 		
 		if [ ${alpha_img[$e]} == "1" ] 
 		then
 			echo -n ${alpha[$e]}
 		else
 			echo -n "-"
 		fi
 		
 		if [ $e == "12" ]
 		then
 			echo -e "\n"
 		fi
 		e=`expr $e + 1`
 	done
 	echo -ne "\n\n"
 	char=""
 }
 

#a function to print the correctly guessed letters of the word to the
#screen or else an underscore for letters no yet guessed
 function print_word {
 	echo -ne "\nWord: "
 	t=0
 	while [ ! $t == `expr ${#word[${word_index}]} ` ]
 	do
 			if [ ${word_img[${t}]} == "1" ]
 			then
 				echo -n "${word[${word_index}]:$t:1}"
 			else
 				echo -n "-"
 			fi
 			t=`expr $t + 1`
 	done
 	echo -e "\n\n"
 }
 
 


#####################################
# beginning of the main program here!
#####################################
 
 readfile;
 gameover=0
 incorrect=0
 correct=0
 while [ "$gameover" == "0" ]
 do
 
 	a=0
 	while [ ! "$a" == "26" ]
 	do
 		alpha_img[$a]=0
 		a=`expr $a + 1`
 	done
 
 	word_img=0
 	alpha_img=0	
 	incorrect=0
 	correct=0
 	readword;
 	a=0
 	gallows;
 	print_alpha;
 	print_word;
 

        #check for winning/losing conditions and update status of hanged man
 	while [[ ! "${numletter}" == `expr ${#word[${word_index}]} ` && ! "$incorrect" == "6" ]]
 	do
 		guess;
 	
 		if [ $correct == "0" ]
 		then 
 			incorrect=`expr $incorrect + 1`
 		fi	
 	
 		if [ $incorrect == "0" ]
 		then
 			gallows;
 		elif [ $incorrect == "1" ]
 		then
 			gallows_head;
 		elif [ $incorrect == "2" ]
 		then
 			gallows_body;
 		elif [ $incorrect == "3" ]
 		then
 			gallows_arm1;
 		elif [ $incorrect == "4" ]
 		then
 			gallows_arm2;
 		elif [ $incorrect == "5" ]
 		then
 			gallows_leg1;
 		elif [ $incorrect == "6" ]
 		then
 			gallows_leg2;
 		fi
 		print_alpha;
 		print_word;
 		
 	done
 
 	if [ "${numletter}" == `expr ${#word[${word_index}]}` ]
 	then
 	clear
 	win;
 	gameover=1
 	fi
 	if [ $incorrect == "6" ]
 	then
 	lose;
 	gameover=1
 	fi
 
 	if [ "$gameover" == "1" ] 
 	then
 		echo -e "\n\n Play again? (y/n)"
 		read answer
 		if [ "$answer" == "y" ]
 		then
 			gameover=0
 		fi
 		clear
 	fi
 done
 exit 0