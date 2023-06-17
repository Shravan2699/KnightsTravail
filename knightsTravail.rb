
require 'set'

def get_neighbors(x, y)
  neighbors = [
    [x + 2, y + 1], [x - 2, y + 1],
    [x + 2, y - 1], [x - 2, y - 1],
    [x + 1, y + 2], [x - 1, y + 2],
    [x + 1, y - 2], [x - 1, y - 2]
  ]

  valid_neighbors = neighbors.select { |n| n[0] >=0 && n[1] >= 0 && n[0] <= 8 && n[1] <= 8 }
  valid_neighbors
end

# p get_neighbors(3,3)


def knight_moves(start, goal)
  queue = Queue.new()
  queue << start
  # p queue
  
  visited = Set.new
  visited.add(start)
  # p visited

  distances = {}
  distances[start] = [0,[start]]


  while !queue.empty?
    current = queue.pop

    if current[0] == goal[0] && current[1] == goal[1]
      distance,path = distances[current]
      # p distances[current]
      return [distance,path]
    end

    neighbors = get_neighbors(current[0],current[1])
  
    neighbors.each do |neighbor|
      if !visited.include?(neighbor)
        queue << neighbor
        visited.add(neighbor)
        
        distance,path = distances[current]
        # p distances[current]
        distances[neighbor] = [distance + 1, path.dup.concat([neighbor])]
        # p  distances
        # p visited
      end
    end
  end
  return [-1,[]]      
end


def shortest_path(start, goal)
  result = knight_moves(start, goal)
  distance, path = result
  if distance == -1
    puts "No valid path exists."
  else
    puts "Shortest distance: #{distance}"
    puts "Path: #{path}"
  end
end

shortest_path([0, 0], [7, 7])
