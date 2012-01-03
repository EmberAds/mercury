module Mercury::Delayed
  def delay
    Proxy.new(self)
  end

  def self.included base
    base.extend self
  end

  class Proxy
    def initialize target
      @target = target
    end

    def method_missing message, *args
      if block_given?
        EventMachine.next_tick { @target.send message, *args, &Proc.new }
      else
        EventMachine.next_tick { @target.send message, *args }
      end
    end
  end
end