# Universidad Nacional Autonoma de Mexico
# Facultad de Ciencias
# Computación Distribuida 2022-2
# Practica #07
# Integrantes del equipo:
# * Marín Parra José Guadalupe de Jesús
# * Lázaro Pérez David Jonathan
# * Licona Aldo Daniel
# * Ramirez Lopez Alvaro

defmodule DFSWOSR do

  # Funcion que contiene un estado por defecto con el map %{:parent => nil, :leader => -1,:children => [], :unexplored => []}
  def init do
    init_state = %{:parent => nil, :leader => -1,:children => [], :unexplored => []}
    message_receive(init_state)
  end

  # Funcion que recive un estado que es el mensaje que recibe
  def message_receive(state) do
    receive do
      msge -> {:ok, new_state} = process_message(msge, state)
      message_receive(new_state)
    end
  end

  # Funcion que recibe un estado y un data
  # el cual le dice al estado cual es su id y cuales son sus vecinos y sus inexplorados
  # los cuales vienen en el data que le pasan.
  # y devolvemos {:ok, state} donde state ya esta modificado
  def process_message({:data, data}, state) do
    %{:id => id, :neighbours => ngbs} = data
    state = Map.put(state, :id, id)
    state = Map.put(state, :neighbours, ngbs)
    state = Map.put(state, :unexplored, ngbs)
    {:ok, state}
  end

  # Funcion que imprime quien es ese proceso y quienes son su hijos
  def process_message({:ask_child}, state) do
    %{:id => id, :children => child} = state
    IO.puts("soy #{id} #{inspect self()}, mis hijos son #{inspect(child, charlists: false)}")
    {:ok, state}
  end

  # Funcion que inicia un proceso es decir lo "depierta" para
  # iniciar con el algoritmo
  # donde le decimos quien es su papa, y quien es el leader, en este caso el
  # y llamamos a explore y lo que devuelva sera state
  # y devolvemos {:ok, state} donde state ya esta modificado
  def process_message({:init, msg}, state) do
    %{:id => id_leader} = state
    state = Map.put(state, :root, true)
    state = Map.put(state, :parent, self())
    state = Map.put(state, :leader, id_leader)
    data = %{:message => msg, :from => self()} # remove id (number)
    state = explore(state, data)
    {:ok, state}
  end

  #Funcion que recibe un data y un state
  # que verifica si el id que recibe de state es mayor al id del lider
  # si el lider es mayor a su id entonces se traga el mensaje
  # es decir devolvemos {:ok, state} donde estate no ha sido modificado
  # si el lider es menor a el id entonces el id es el nuevo lider
  # y lo quitamos de la lista de inexplorados
  # y llamamos a explore y lo que devuelva explore sera state
  # y devolvemos {:ok, state} donde state ya esta modificado
  # si el lider es igual a el id entonces le mandamos :already al proceso from y le decimos cual es el lider
  # llamamos a explore y lo que devuelva sera state
  # devolvemos {:ok, state} donde state ya esta modificado
  def process_message({:leader, data}, state) do
    %{:message => msg, :from => from} = data
    %{:unexplored => unexp, :id => id, :leader => id_leader} = state
    new_data = %{:message => msg, :from => self()}
    if id_leader < id do
      state = Map.put(state, :parent, from)
      nexp = List.delete(unexp, from)
      state = Map.put(state, :unexplored, nexp)
      state = Map.put(state, :leader, id)
      state = Map.put(state, :children, [])
      state = explore(state, new_data)
      {:ok, state}
    else
      if id_leader == id do
        new_data = Map.put(new_data, :leader, id_leader)
        send(from, {:already, self(), new_data})
        state = explore(state, new_data)
        {:ok, state}
      else
        {:ok, state}
      end
    end
  end

  # Funcion que recibe un data y un state y si el id del estado es igual
  # al id del lider entonces agrega el lider al estado y llama al metodo explore
  # y lo que devuelva explore sera state
  # y devolvemos {:ok, state} donde state ya esta modificado
  def process_message({:already, _not_child, data}, state) do
    %{:message => msg, :leader => id_leader} = data
    %{:id => id} = state
    if id == id_leader do
      new_data = %{:message => msg, :from => self()}
      state = Map.put(state, :leader, id_leader)
      state = explore(state, new_data)
      {:ok, state}
    else
      {:ok, state}
    end
  end


  # Funcion que recibe un data, child_proc y state
  # si recibimos :parent entonces preguntamos si nuestra lista de hijos ya contiene child_proc
  # si si no hacemos nada pero si no entonces lo agregamos a nuestra lista de hijos
  # lo agregamos a state y llamamos a explore y lo que devuelva explore sera el nuevo state
  # entonces regresamos {:ok, state} donde state ya esta modificado
  def process_message({:parent, child_proc, data}, state) do
    %{:children => children, :id => id, :leader => id_leader} = state
    flag = Enum.member?(children, child_proc)
    if id == id_leader do
      if flag do
        {:ok, state}
      else
        children = children ++ [child_proc]
        state = Map.put(state, :children, children)
        state = explore(state, data)
        {:ok, state}
      end
    else
      {:ok, state}
    end
  end


  # Funcion que recibe un map state y data y revisa si la lista de inexplorados es vacia
  # si lo es entonces pregunta si su papa de un proceso es el mismo
  # y si lo es solo regresa el estado state que recibe si no entonces
  # le manda :parent a su padre.
  # Si la lista es distinto del vacio entonces toma a cualquer proceso de la lista
  # en este caso al primero y le manda la llave :leader con nuw_data que contiene el lider.
  # y regresamos state
  def explore(state, data) do
    %{:unexplored => unexp, :parent => parent, :leader => id_leader} = state
    %{:message => msg} = data
    new_data = %{:message => msg, :from => self(), :leader => id_leader}
    if unexp != [] do
      [u | nexp] = unexp
      state = Map.put(state, :unexplored, nexp)
      send(u, {:leader, new_data})
      state
    else
      if parent != self() do
        send(parent, {:parent, self(), new_data})
      end
      state
    end
  end

end

a = spawn(DFSWOSR, :init, [])
b = spawn(DFSWOSR, :init, [])
c = spawn(DFSWOSR, :init, [])
d = spawn(DFSWOSR, :init, [])
e = spawn(DFSWOSR, :init, [])
f = spawn(DFSWOSR, :init, [])
g = spawn(DFSWOSR, :init, [])
h = spawn(DFSWOSR, :init, [])

data_a = %{:id => 1, :neighbours => [b,c]}
send(a, {:data, data_a})
data_b = %{:id => 2, :neighbours => [a,c,d,e]}
send(b, {:data, data_b})
data_c = %{:id => 3, :neighbours => [a,b,f]}
send(c, {:data, data_c})
data_d = %{:id => 4, :neighbours => [b]}
send(d, {:data, data_d})
data_e = %{:id => 5, :neighbours => [b,f,g,h]}
send(e, {:data, data_e})
data_f = %{:id => 6, :neighbours => [c,e,h]}
send(f, {:data, data_f})
data_g = %{:id => 7, :neighbours => [e,h]}
send(g, {:data, data_g})
data_h = %{:id => 8, :neighbours => [e,f,g]}
send(h, {:data, data_h})

lista = [a,b,c,d,e,f,g,h]
azar = Enum.random(lista)
send(azar, {:init, "Hola"})
Process.sleep(1000)
all = [a,b,c,d,e,f,g,h]
Process.sleep(1000)
Enum.each(all, &(send(&1, {:ask_child})))
