module Mercury
  Dir['./lib/mercury/*.rb'].each do | file | 
    require file
  end
end