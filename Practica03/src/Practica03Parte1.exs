# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #03
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Practica03Parte1 do

# 1. Factorial con recursión de cola.
# fact_cola: Función que dado un número n regresa el factorial de dicho número.
  def fact_cola(n) do
    fact_x(n,1)
  end
# fact_x: Función que dado dos numeros a y n realiza la recursión de cola con ayuda de a.
  def fact_x(n,a)do
    if (n == 0) do
      a
    else
      fact_x(n-1,n*a)
    end
  end

# 2. Función con recursión de cola para sacar el promedio de una lista de
# enteros.
# promedio_cola: Función que dada una lista l de numeros regresa el promedio de l.
  def promedio_cola(l) do
    promedio_x(l, 0) / length l
  end
# promedio_x: Función que realiza el caso base de la recursión de cola.
  def promedio_x([],a) do
    a
  end
# promedio_x: Función que calcula el promedio de la lista con recursión de cola.
  def promedio_x([x | xs],a) do
    promedio_x(xs, a + x)
  end

# 3. Función con recursión de cola para seleccionar el elemento más pequeño
# de una lista de enteros.
# minimo_cola: Función que realiza el caso base para una lista vacia.
  def minimo_cola([]) do
    []
  end
# minimo_cola: Función que regresa el elemento mas pequeño de la lista.
  def minimo_cola([x | xs]) do
    minimo_cola_x([x | xs],max(x,xs))
  end

# minimo_cola_x: Función que realiza el caso base de la recursión de cola.
  def minimo_cola_x([],n) do
    n
  end
# minimo_cola_x: Función que regresa el elemento mas pequeño con recursión de cola.
  def minimo_cola_x([x | xs],n) do
    if (n < x) do
      minimo_cola_x(xs,n)
      else
      minimo_cola_x(xs,x)
    end
  end

# 4. Función con recursión de cola para calcular la suma de Gauss.
# gauss_cola: Función que dado un numero realiza la suma de Gauss.
  def gauss_cola(n) do
    gauss_x(n,1)
  end
# gauss_x: Función que realiza la recursión de cola para obtener la suma de Gauss.
  def gauss_x(n,a)do
    if (n == 1) do
      a
    else
      gauss_x(n-1,n+a)
    end
  end

# 5. Función con recursión de cola para imprimir un mensaje n 
# veces, es decir, recibes el mensaje y un contador, tienes que imprimir dicho 
# mensaje n veces y al final regresar el átomo :ok.
# imprimirMensajeN: Caso base cuando el contador es igual a 1.
  def imprimirMensajeN(mensaje, n) when n==1 do
    IO.puts(mensaje)
  end
# imprimirMensajeN: Caso recursivo cuando el contador es mayor a 1.
  def imprimirMensajeN(mensaje, n) do
    IO.puts(mensaje)
    imprimirMensajeN(mensaje, n-1)
  end

end