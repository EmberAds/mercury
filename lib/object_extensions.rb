module ObjectExtensions
  def blank?
    return false
  end
end


Object.__send__ :include, ObjectExtensions