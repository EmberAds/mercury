module Mercury
  Dir['./lib/mercury/*.rb'].each do | file | 
    puts file
    require file
  end
end