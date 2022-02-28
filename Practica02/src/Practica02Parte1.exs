# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #2
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Practica02Parte1 do

  # duplicar: Función que dado un número n y una cadena, regresa una lista con 
  # n veces la cadena.
  def duplicar(k,n) do
    import List, only: [duplicate: 2]
    duplicate(k,n)
  end

  # insertar: Función que dada una lista, un índice i y un valor, regresa la 
  # lista con el valor insertado en el índice i de la lista.
  def insertar(l,n,i) do
    import List, only: [insert_at: 3]
    insert_at(l,n,i)
  end

  # eliminarElem: Función que dada una lista y un índice i regresa la lista 
  # sin el elemento en la posición i.
  def eliminarElem(l,i) do
    import List, only: [delete_at: 2]
    delete_at(l,i)
  end

  # ultimo: Función que regresa el último elemento de una lista.
  def ultimo(l) do
    import List, only: [last: 1]
    last(l)
  end

  # encapsula: Función que dada una lista de listas encapsula en tuplas los 
  # elementos correspondientes de cada lista, es decir, encapsula todos los 
  # elementos con índice 0, todos los elementos con índice 1, etc.
  def encapsula(l) do
    import List, only: [zip: 1]
    zip(l)
  end

  # eliminaEntrada: Función que dado un map y una llave, regresa el map sin 
  # la entrada con la llave.
  def eliminaEntrada(m,k) do
    import Map, only: [delete: 2]
    delete(m,k)
  end

  # mapAlista: Función que dado un map regresa su conversión a una lista.
  def mapAlista(m) do
    import Map, only: [to_list: 1]
    to_list(m)
  end

  # distancia: Función que calcula la distancia entre dos puntos.
  def distancia(a,b) do
    import List, only: [first: 1]
    resta1 = first(a) - first(b)
    resta2 = ultimo(a) - ultimo(b)
    cuadrado1 = resta1 * resta1
    cuadrado2 = resta2 * resta2
    raiz = :math.sqrt(cuadrado1 + cuadrado2)
    raiz
  end

  # insertaAtupla: Función que inserta un elemento en una tupla.
  def insertarAtupla(t,i,e) do
    import Tuple, only: [insert_at: 3]
    insert_at(t,i,e)
  end

  # tuplALista: Función que pasa de una tupla a una lista
  def tuplAlista(t) do
    import Tuple, only: [to_list: 1]
    to_list(t)
  end
end