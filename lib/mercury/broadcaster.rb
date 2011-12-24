module Mercury::Broadcaster

  def queue message_queue, data
    push message_queue, data
  end

  def retrieve_next_message_from message_queue
    pop_from message_queue
  end


end