defmodule BridgeApp.Bridge.Server do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:add_message, new_message}, messages) do
    {:noreply, [new_message | messages]}
  end
  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end
  def handle_call(:queue, _from, state) do
    {:reply, state, state}
  end
  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}
  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end
  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

end
