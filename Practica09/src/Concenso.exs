# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #09
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule Pconcenso do

  # Funcion que inicia un map predefinido con ls vecinos vacios y el numero de rondas en 0
  def init do
    init_state = %{:vecinos => [], :round => 0}
    message_receive(init_state)
  end

  # Funcion que recibe y lee los mensajes
  def message_receive(state) do
    receive do
      msge -> {:ok, new_state} = process_message(msge, state)
      message_receive(new_state)
    end
  end

  # process_message con :data recibe un data y un estado state
  # donde data contendra los vecinos de ese vertice y su id
  # y posteriormente se actualizaran en el estado
  # devuelve {:ok, state} donde el state ya esta modificado
  def process_message({:data, data}, state) do
    %{:id => id, :vecinos => vecinos, :arreglo => arreglos} = data
    state = Map.put(state, :id, id)
    state = Map.put(state, :vecinos, vecinos)
    state = Map.put(state, :arreglo, arreglos)
    {:ok, state}
  end

  # process_message con :init hace que todos los procesos manden su
  # elemento propuesto a todos sus vecinos
  # regresa {:ok, state} donde state ya esta modificado
  def process_message({:init, msg}, state) do
    %{:id => id, :vecinos => vecinos} = state
    state = Map.put(state, :from, self())
    state = Map.put(state, :round, 1)
    new_data = %{:new_id => id, :mensaje => msg}
    Enum.each(vecinos, fn x -> send(x, {:recibe, new_data}) end)
    {:ok, state}
  end

  # process_message :recibe recibe un data y un state
  # que recibe los elementos propuestos de los demas procesos
  # y los coloca en el lugar i que corresponde
  # regresa {:ok, state} donde state ya esta modificado
  def process_message({:recibe, data}, state) do
    %{:new_id => n_id, :mensaje => msg} = data
    %{:arreglo => arreglos, :id => id} = state

    IO.puts("Soy el proceso #{id} y recibi #{msg} de #{n_id}")
    lista = List.replace_at(arreglos, n_id - 1, msg)
    state = Map.put(state, :arreglo, lista)
    IO.puts("#{inspect(lista, charlists: false)}")
    {:ok, state}
  end


  # process_message :cuenta calcula el maj que es el elemento que mas se repite en el arreglo del proceso
  # y calcula mult que es cuantas veces se repite ese elemento por convencion se definio a mano y no se calculó XD
  # finalmente como se termina una ronda se aumenta el valor de la ronda en 1
  # si la ronda es igual al id del proceso entonces el es el ganador y manda su maj a todos con la etiqueta kink_maj
  # devuleve {:ok, state} donde state ya esta modificado
  def process_message({:cuenta}, state) do
    %{:arreglo => lista, :round => ronda, :id => id, :vecinos => vecinos} = state
    mult = length(lista) - 1
    maj = majF(lista)
    state = Map.put(state, :maj, maj)
    state = Map.put(state, :mult, mult)
    ronda = ronda + 1
    state = Map.put(state, :round, ronda)
    IO.puts "Soy #{id} y este es mi maj #{maj} y mi mult #{mult}"
    new_data = %{:king_maj => maj, :new_id => id}
    if ronda == id do
      IO.puts "Yo #{id} soy el rey de la ronda"
      Enum.each(vecinos, fn x -> send(x, {:kink_maj, new_data}) end)
    end
    {:ok, state}
  end


  # process_message :kink_maj recibe unn data y un state que son maps
  # si mul > n/2 + f entonces actualizamos con maj la posicion j del arreglo
  # como terminamos una ronda aumentamos el valor de ronda en uno
  # si no entonces lo actualizamos con king_maj que nos pasan en data
  # como terminamos otra ronda aumentamos el valor de ronda en uno
  # devolvemos {:ok, state} donde state ya esta modificado
  def process_message({:kink_maj, data}, state) do
    %{:king_maj => k_maj, :new_id => n_id} = data
    %{:mult => mult, :maj => maj, :arreglo => arreglos, :round => ronda} = state
    if mult > (5/2) + 1 do
      arreglos = List.replace_at(arreglos, n_id - 1, maj)
      state = Map.put(state, :arreglo, arreglos)
      ronda = ronda + 1
      state = Map.put(state, :round, ronda)
      {:ok, state}
    else
      arreglos = List.replace_at(arreglos, n_id - 1, k_maj)
      state = Map.put(state, :arreglo, arreglos)
      ronda = ronda + 1
      state = Map.put(state, :round, ronda)
      {:ok,state}
    end
  end

  # process_message :terminamos verifica si k == f +1
  # es decir verifica si el numero de rondas es igual al numero de fallas + 1
  # si lo es terminamos y entonces imprimimos el elemento propuesto de ese proceso
  # devolvemos {:ok, state} state no se modifica
  def process_message({:terminamos}, state) do
    %{:round => ronda, :maj => maj} = state
    if ronda == 2 do
      IO.puts "Este es el elemento propuesto #{maj}"
    end
    {:ok, state}
  end

  # majF calcula el maj de una lista es decir nos devuelve
  # el elemento que mas se repite en la lista
  def majF([elemento]) do
    elemento
  end

  def majF([x | xs]) do
    if x == List.first(xs) do
      x
    else
      majF(xs)
    end
  end

end



  a = spawn(Pconcenso, :init, [])
  b = spawn(Pconcenso, :init, [])
  c = spawn(Pconcenso, :init, [])
  d = spawn(Pconcenso, :init, [])

  # Este es el proceso que falla
  e = spawn(Pconcenso, :init, [])

  data_a = %{:id => 1, :vecinos => [b,c,d,e], :arreglo => ["x",nil,nil,nil,nil]}

  send(a, {:data, data_a})

  data_b = %{:id => 2, :vecinos => [a,c,d,e], :arreglo => [nil,"x",nil,nil,nil]}

  send(b, {:data, data_b})

  data_c = %{:id => 3, :vecinos => [a,b,d,e], :arreglo => [nil,nil,"x",nil,nil]}

  send(c, {:data, data_c})

  data_d = %{:id => 4, :vecinos => [a,b,c,e], :arreglo => [nil,nil,nil,"x",nil]}

  send(d, {:data, data_d})

  # este el proceso que falla
  data_e = %{:id => 5, :vecinos => [a,b,c,d], :arreglo => [nil,nil,nil,nil,"y"]}
  
  send(e, {:data, data_e})

  send(a, {:init, "x"})
  send(b, {:init, "x"})
  send(c, {:init, "x"})
  send(d, {:init, "x"})
  #Este es el proceso que genera una falla visantina
  send(e, {:init, "y"})

  Process.sleep(1000)
  all = [a,b,c,d,e]
  Enum.each(all, &(send(&1, {:cuenta})))
  Process.sleep(1000)
  Enum.each(all, &(send(&1, {:terminamos})))
