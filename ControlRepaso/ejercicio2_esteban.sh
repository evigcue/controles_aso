#!/bin/bash

log=info.log

fichero=ficheros_de_esteban.txt
# No recuerdo la sintaxis de random así que pediré al usuario el archivo
function reversa() {
    local p=$1
    local len=${#p}
    local reve

    echo "Comprobando si el nombre $p es simétrico" >> $log
    # Recorremos la palabra al revés y lo añadimos a la variable
    for {i=$len, i=0, i--}; do
        reve+=${p:i:1}
    done

    if [ "$p" == "$reve" ]; then
        echo "El nombre del fichero es simétrico"
        echo "El nombre del fichero es simétrico" >> $log
        echo
    else
        echo "El nombre del fichero no es simétrico"
        echo "El nombre del fichero no es simétrico" >> $log
        echo
    fi
}

function menu {

    local lines=$1
    while true; do
        echo "1. Comprobar fichero"
        echo "2. Salir"
        read -p "¿Qué quiere hacer?: " opt

        if [ $opt -eq 1 ]; then
            echo
            echo ""
            read -p "¿Qué fichero quiere comprobar de los $lines?" num
            num+=1

            # Lo mejor para lo siguiente sería un awk, pero no recuerdo del
            # todo la sintaxis, por eso usaré cut
            local line=$(head -n$num $fichero | tail -n1)
            local nombre=$(cut -d: -f1 $line)
            reversa $nombre
            local ruta=$(cut -d: -f2 $line)
            if [ -s $ruta ]; then
                local propietario=$(cut -d: -f3 $line)
                local grupo=$(cut -d: -f4 $line)
                sudo chown $propietario:$grupo $ruta/$nombre
                echo "La propiedad de $nombre es de $propietario y del grupo $grupo" >> $log
            else
                local text=$(cut -d: -f5 $line)
                echo "$text" >> $ruta/$nombre
                echo "Se ha creado $nombre en $ruta con el texto especificado" >> $log
            fi

        elif [ $opt -eq 2 ]; then
            echo
            echo "Gracias por haber utilizado este script"
            exit
        else
            echo
            echo "Opción no válida"
        fi
    done
}

lineas=$(wc -l $fichero)

menu $lineas