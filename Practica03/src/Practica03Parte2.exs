# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #03
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Practica03Parte2 do
# Metodo split
  def ss([], _a) do
    {[], []}  
  end

  def ss(l, 0) do
    {[], l}
  end

  def ss(l, a) when (a < 0) do
    ss(l, length(l) + a)
  end

  def ss([x | xs], a) do
    {first, second} = ss(xs, a - 1)
    {[x | first], second}
  end

# Metodo all que recibe una lista "l" y una funcion "c".
# Y devuelve falso si almenos un elemento de la lista no cumple la condicion y true si todos la cumplen.
# Metodo que regresa "true" si la lista es vacia
  def all([]) do
    true
  end

# Metodo que regresa falso si algun elemento de la lista es "false" o "nil"
  def all([x | xs]) do
    if (x) == false or (x) == nil do
      false
    else
      true
      all(xs)
    end
  end

# Metodo all que recibe una lista "l" y una funcion "c".
# Y devuelve falso si almenos un elemento de la lista no cumple la condicion y true si todos la cumplen.
  def all(l,c) do
    tamanoOriginal = length(l)
    lista = filter_x(l,c)
    if length(lista) < tamanoOriginal do
      false
    else
      true
    end
  end

# Metodo filter
  def filter_x([],_f) do
    []
  end
  def filter_x([x | xs],f) do
    if(f.(x) == true) do
      [x | filter_x(xs,f)]
    else
      filter_x(xs,f)
    end
  end
end