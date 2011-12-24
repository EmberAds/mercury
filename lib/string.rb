module StringConstantise
  def constantise
    split("::").inject(Kernel) {|klass, str| klass.const_get(str) }
  end
end

String.__send__ :include, StringConstantise
