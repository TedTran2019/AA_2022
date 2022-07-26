@benches.each do |bench|
  json.set! bench.id do 
    json.extract! bench, :id, :description, :lat, :lng, :seating, :rating, :comment
  end
end
