#!/bin/bash

#=========================================================================
#                  Author: lola-rica                                     =
#                  lolatmp@gmail.com                                     =
#                   github/Saycoron                                      =
#=========================================================================

inicio(){

	currentTask="inicio"

	opcionesTerminal
	bannerInit
	checkRoot
	adaptadoresTodo
	cambioMac

}

###################################################
#  INICIO Opciones de terminal
###################################################

opcionesTerminal(){

	currentTask="opcionesTerminal"

	maxVentana
	tituloVentana
	colorLetra
	varBasicas

}

maxVentana(){

	currentTask="maxVentana"

	printf '\033[8;32;115t'

}

tituloVentana(){

	currentTask="tituloVentana"

	title='echo -ne "\033]0; Lola Util v1.0\007"'
	$title

}

colorLetra(){

	currentTask="colorLetra"

	blue=$(echo -e "\e[34m")
	cyan=$(echo -e "\e[36m")
	green=$(echo -e "\e[32m")
	red=$(echo -e "\e[31m")
	white=$(echo -e "\e[0m")
	yellow=$(echo -e "\e[33m")
		
}

varBasicas(){

	currentTask="varBasicas"

	terminal="gnome-terminal -x"

}

###################################################
#  FIN Opciones de terminal
###################################################

###################################################
#  INICIO Check Root
###################################################

checkRoot(){
	
	currentTask="checkRoot"
	
	if [ "$(id -u)" != "0" ];
     	 then
  	    	sleep 1
  		  	echo "                          [$yellow ! $white] [Check Privilegios Root]";
  		 	sleep 1
  	      	echo "                          [$yellow ! $white] [Usuario]: $USER";
  		  	sleep 1
  		  	echo "                          [$red x $white] [$red ERROR $white]: Tienes que ejecutar como$red ROOT $white";
  		  	echo "                          [$red x $white] Usa el comando sudo :$red sudo bash lolamac.bash $white";
  		  	echo ""
  		  	sleep 1
  		  	exit
      	else
  		  	sleep 1
  		  	echo "                          [$yellow ! $white] [Check Privilegios Root]";
  		  	sleep 1
  	  	  	echo "                          [$yellow ! $white] [Usuario]: $USER ";
  		  	sleep 1   
  		  	echo "                          [$green ✔ $white] [Privilegios de Root]";
  		  	echo ""
  		  	sleep 1  
   	fi

}

###################################################
#  FIN Check Root
###################################################

###################################################
#  INICIO ADAPTADORES 
###################################################

adaptadoresTodo(){

	currentTask="adaptadoresTodo"

	bannerElegirInterface
	adaptadoresEth	
	adaptadoresWlan
	mostrarAdapadores
}

adaptadoresEth(){

	currentTask="adaptadoresEth"

	iteradorEth="1"
	maxEth="5"
	ethEncontradas="0"

	while [ $iteradorEth -le $maxEth ]
		do
		
		contenedor=$(ifconfig | grep "eth$iteradorEth" | cut -c 5)
		
		case "$contenedor" in

			"")
			iteradorEth="5"
			break;
			;;

			*)
			iteradorEth=$(($iteradorEth+1))
			ethEncontradas=$(($ethEncontradas+1))
			;;

		esac
		
	done
}

adaptadoresWlan(){

	currentTask="adaptadoresWlan"

	iteradorWlan="1"
	maxWlan="5"
	wlanEncontradas="0"

	while [ $iteradorWlan -le $maxWlan ]
		do
		
		contenedor=$(ifconfig | grep "wlan$iteradorWlan" | cut -c 5)
		
		case "$contenedor" in

			"")
			iteradorWlan="5"
			break;
			;;

			*)
			iteradorWlan=$(($iteradorWlan+1))
			wlanEncontradas=$(($wlanEncontradas+1))
			;;

		esac
		
	done

}

mostrarAdapadores(){

	currentTask="mostrarAdapadores"

	declare -a arryAdap

	iteradorEthMostrar="0"
	mostrarEthAux="0"
	numeroIte="1"

	iteradorWlanMostrar="0"
	mostrarWlanAux="0"

	iteradorWlan="0"
	iteradorEth="0"

	if [ $maxWlan -eq "0" ]; 
		then
			$red
			echo "        $red           NO SE ENCONTRO ADAPTADOR Eth $white       " 
			read pause
			exit
			$white
	fi

	while [ $mostrarEthAux -le $ethEncontradas ]
		do
			echo "              $white              $numeroIte ) -$blue Eth$iteradorEthMostrar : $green OK   $white " 
			contenedorEthAux="eth$iteradorEth"
			arryAdap[$numeroIte]=$contenedorEthAux
			mostrarEthAux=$(($mostrarEthAux+1))	
			numeroIte=$(($numeroIte+1))
			iteradorEth=$(($iteradorEth+1))
			iteradorEthMostrar=$(($iteradorEthMostrar+1))
	done	

	if [ $maxWlan -eq "0" ]; 
		then
			$red
			echo "        $red           NO SE ENCONTRO ADAPTADOR WIFI  $white       " 
			read pause
			exit
			$white
	fi

	while [ $mostrarWlanAux -le $wlanEncontradas ]
		do
			echo "              $white              $numeroIte ) -$blue Wlan$iteradorWlanMostrar : $green OK   $white " 
			contenedorWlanAux="wlan$iteradorWlan"
			arryAdap[$numeroIte]=$contenedorWlanAux
			mostrarWlanAux=$(($mostrarWlanAux+1))	
			numeroIte=$(($numeroIte+1))
			iteradorWlan=$(($iteradorWlan+1))
			iteradorWlanMostrar=$(($iteradorWlanMostrar+1))
	done	

	read interfaceAux

	case "$interfaceAux" in
		"1")
			interface=${arryAdap[1]}	
		;;
		"2")
			interface=${arryAdap[2]}	
		;;
		"3")
			interface=${arryAdap[3]}	
		;;
		"4")
			interface=${arryAdap[4]}	
		;;
		"5")
			interface=${arryAdap[5]}	
		;;
		"*")
			mostrarWlan
		;;	
	esac

echo "-----------------------------------$yellow $interface$white -----------------------------------------"

}

###################################################
#  FIN ADAPTADORES 
###################################################

###################################################
#  INICIO PROG
###################################################

obtenerInterface(){

	currentTask="obtenerInterface"

	echo ""
	echo "          $white       LA INTERFAZ SELECCIONADA ES :$blue $interface  $white "
	
}

cambioMac(){
	  
	currentTask="cambioMac"

	echo ""
	echo "            ----=[ $blue               Disfrazar MAC         $white       ]=----    " 
	echo ""
	echo "             $yellow INTRODUCE UNA NUEVA MAC EJEMPLO : aa:bb:cc:dd:ee:ff  $white "
	echo "                $yellow                    O"
	echo "                  DEJAR EN BLANCO PARA USAR: 00:11:22:33:44:55$white"
	
	read macFakePreg
	blank=""

	if [ "$macFakePreg" != "$blank" ]; 
		then
			macFake=$macFakePreg
		else
			macFake="00:11:22:33:44:55"
	fi

	macTemp=$(ifconfig $interface | grep ether)
	mac=$(echo "$macTemp" | cut -c 15-31)

	sleep 2
	echo ""
	echo "                   $white Mac de $blue$interface$white Actual es :$blue $mac  $white   "
	
	if [ "$mac" != "$macFake" ]; 
		then
  			ifconfig $interface down
			sleep 2
			contenedor=$(macchanger --mac $macFake $interface)
			sleep 2
			ifconfig $interface up
			echo "                   $white Mac de $blue$interface$white Se Disfrazara a :$green $macFake$white     "
			
		else
  			
  			sleep 2
  			echo "                  $red ERROR INTRODUCE OTRA MAC ESA YA EXISTE   $white  "
	
  			cambioMac
	fi

	sleep 1
	macTempFinal=$(ifconfig $interface | grep ether)
	macFinal=$(echo "$macTempFinal" | cut -c 15-31)

	if [ "$macFinal" != "$macFake" ]; 
		then
			echo "              $red SE PRODUJO UN ERROR EN CAMBIAR LA MAC INTENTE OTRA VEZ"
			echo "              $red SE PRODUJO UN ERROR EN CAMBIAR LA MAC INTENTE OTRA VEZ"
			echo "              $red SE PRODUJO UN ERROR EN CAMBIAR LA MAC INTENTE OTRA VEZ"
			echo "                   $white Mac de $blue$interface$white Actual es :$blue $macFinal    $white "
		else
			echo "                   $white Mac de $blue$interface$white Actual es :$blue $macFinal    $white "
	fi

	echo ""
	echo "     Listoooooo :D graciasssss totaleeeeeeesssssssssss.......... press ENTER...."
	read tiempo
	clear
	exit
	
}

###################################################
#  FIN PROG
###################################################

###################################################
#  INICIO BANNERS
###################################################

bannerInit(){

	currentTask="bannerInit"
	
	clear
	echo "$blue"             
	echo " __         ______     __         ______       __  __     ______   __     __        "
	echo "/\ \       /\  __ \   /\ \       /\  __ \     /\ \/\ \   /\__  _\ /\ \   /\ \       "
	echo "\ \ \____  \ \ \/\ \  \ \ \____  \ \  __ \    \ \ \_\ \  \/_/\ \/ \ \ \  \ \ \____  "
	echo " \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\    \ \_____\    \ \_\  \ \_\  \ \_____\ "
	echo "  \/_____/   \/_____/   \/_____/   \/_/\/_/     \/_____/     \/_/   \/_/   \/_____/ "                                                                               
	echo "$white"
	echo "=================================================================================="

}

bannerElegirInterface(){
	  
	currentTask="bannerElegirIntbannerErface"

	echo ""
	echo "            ----=[$yellow          Que interface desea Usar?  $white        ]=---- " 
	echo ""		
}

###################################################
#  FIN BANNERS
###################################################

inicio