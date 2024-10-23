#!/bin/bash

declare -A valores

function menu {
    local n1=$1
    local n2=$2
    local n3=$3

    while true; do
        echo "1. Suma"
        echo "2. Media"
        echo "3. Producto"
        echo "4. Mayor"
        echo "5. Menor"
        echo "6. Salir"
        read -p "¿Qué quieres hacer?: " opt

        if [ $opt -eq 1 ]; then
            echo "La suma de $1, $2 y $3 es: ${valores[suma]}"
        elif [ $opt -eq 2 ]; then
            echo "La media de $1, $2 y $3 es: ${valores[media]}"
        elif [ $opt -eq 3 ]; then
            echo "El producto de $1, $2 y $3 es: ${valores[producto]}"
        elif [ $opt -eq 4 ]; then
            echo "El mayor de $1, $2 y $3 es: ${valores[mayor]}"
        elif [ $opt -eq 5 ]; then
            echo "El menor de $1, $2 y $3 es: ${valores[menor]}"
        elif [ $opt -eq 6 ]; then
            echo "Gracias por haber usado este script"
            exit
        else
            echo "Opción no válida"
        fi
    done
}

valores[num1]=$1
valores[num2]=$2
valores[num3]=$3

valores[suma]=$(( $1 + $2 + $3 ))
valores[media]=$(( ${valores[suma]} / 3 ))
valores[producto]=$(( $1 * $2 * $3 ))

if [ $1 -gt $2 ] && [ $1 -gt $3 ]; then
    valores[mayor]=$1
    if [ $2 -gt $3 ]; then
        valores[menor]=$3
    else
        valores[menor]=$2
    fi
elif [ $2 -gt $1 ] && [ $2 -gt $3 ]; then
    valores[mayor]=$2
    if [ $1 -gt $3 ]; then
        valores[menor]=$3
    else
        valores[menor]=$1
    fi
else
    valores[mayor]=$3
    if [ $2 -gt $1 ]; then
        valores[menor]=$1
    else
        valores[menor]=$2
    fi
fi

menu $1 $2 $3