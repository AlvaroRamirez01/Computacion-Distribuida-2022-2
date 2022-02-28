# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #2
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Practica02Parte2a do
    
    # importamos las funciones que realizamos en la parte a de la practica.
    import Practica02Parte1
    
    # rangoLista: Crea un atributo que sea una lista del 1 al 10
    def rangoLista() do
        duplicar("1",10)
    end

    # listaCompuesta: Función que dada una cadena, un elemento, un número n y 
    # un índice i < n, crea una lista con la cadena repetida "n" veces, y a esta 
    # lista, le agrega el elemento en el índice dado.
    def listaCompuesta(s,e,n,i) do
        lista = duplicar(s,n)
        insertar(lista,i,e)
    end
end

# Crea un módulo, las siguientes funciones deberán ir dentro de este
# nuevo módulo.
defmodule Practica02Parte2b do

    # importamos las funciones que realizamos en la parte a de la practica.
    import Practica02Parte1

    # eliminaMap: Función que dado un map y un índice, elimina de la lista 
    # generada por el map, el elemento en el índice dado.
    def eliminaMap(m,i) do
        eliminarElem(Map.values(m),i)
    end
    
    # tuplaUltimo: Función que dada una tupla y un valor, agrega el valor a 
    # la tupla, pasa la tupla a lista y finalmente regresa el último elemento de
    # esta lista.
    def tuplaUltimo(t,v) do
        ultimo(tuplAlista(insertarAtupla(t,tuple_size(t),v)))
    end
end