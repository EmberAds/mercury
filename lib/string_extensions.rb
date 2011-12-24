module StringExtensions
  def constantise
    split("::").inject(Kernel) {|klass, str| klass.const_get(str) }
  end

  def blank?
    self == ""
  end
end

String.__send__ :include, StringExtensions
