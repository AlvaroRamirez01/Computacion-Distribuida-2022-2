# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #1
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Practica01 do
  
  # Función que calcula el cuadruple de un número (Dos veces el doble).
  def cuadruple(n) do
    2 * (2 * n)
  end

  # Función que calcula el sucesor de un número.
  def sucesor(n) do
    n + 1
  end

  # Función que regresa el máximo de dos números.
  def maximo(a,b) do
    if a > b do
      a
    else
      b
    end
  end

  # Función que calcula la suma de dos números.
  def suma(x,y) do
    x + y
  end

  # Función que calcula la resta de dos números.
  def resta(x,y) do
    x - y
  end

  # Función que calcula la multiplicación de la resta con la suma de dos números.
  def multi(a,b) do
    resta(a,b) * suma(a,b)
  end

  # Función que calcula la negación de un valor booleano.
  def negacion(x) do
    if x == true do
      false
    else
      true
    end
  end

  # Función que calcula la conjunción de dos valores booleanos.
  def conj(x,y) do
    if x == true and y == true do
      true
    else
      false
    end
  end

  # Función que calcula la disyunción de dos valores booleanos.
  def dis(a,b) do
    if a == false and b == false do
      false
    else
      true
    end
  end

  # Función que calcula el valor absoluto de un número.
  def absoluto(n) do
    if n > 0 do
      n
    else
      -1 * n
    end
  end

  # Función que calcula el área de un círculo dado su radio.
  def areaCirculo(r) do
    3.14 * (r * r)
  end

  # Suma de Gauss - Fórmula para calcular la suma de Gauss.
  def gauusFormula(n) do
    n * ((n+1)/2)
  end

  # Suma de Gauss - Función recursiva que calcula la suma de Gauss.
  def gauusRecur(0) do
    0
  end
  def gauusRecur(1) do
    1
  end
  def gauusRecur(n) do
    n + gauusRecur(n-1)
  end

  # Función que calcula el área de un triángulo dados tres puntos.
  def area(a,b,c,d,e,f) do
    u= a*d
    v= b*e
    w= c*f
    x= (d*e)*-1
    y= (a*f)*-1
    z= (b*c)*-1
    g= (u+v+w+x+y+z)/2
    "Area del triangulo = " <> to_string(g)
  end

end
