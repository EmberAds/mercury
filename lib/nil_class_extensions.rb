module NilClassExtensions
  def blank?
    return true
  end
end


NilClass.__send__ :include, NilClassExtensions