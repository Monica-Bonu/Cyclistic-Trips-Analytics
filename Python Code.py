def readMap(mapName)-> list:
   
    with open (mapName, 'r') as map:
        buffer = map.read()
   
    txt_file = buffer.split("\n")
    maplist = []

    for row in range (len(txt_file)-1):
        maplist.append(list(txt_file[row].replace(',','')))
    
    return maplist


# Part 2: Function to locate the robot position and stain positions on the map
def locate(map): # This return expression ( ->(str, list)) is showing as a problem in VS code but doesn't on notebook where I developed the codes
      
    indexed = {}
    staincount = []

    for i in range(len(map)):
        key = chr(65 + i)     # 65 is ASCII for 'A'
        value = map[i]        # the row/sublist
        indexed[key] = value
  
    for key, value in indexed.items ():
        for i in range (len(value)):
            if value[i] == "#":
                location = key+str(i)
            if value[i] == "@":
                staincount.append(key+str(i))
            
    return location, staincount


# Part 3: Functions to convert coordinates and calculate distances

def coord_convert(coord)->(tuple):

    row = ord(coord[0]) - 65
    col = int(coord[1:])
    return row, col
    
def calculateDistances(start, stains_coords) ->{dict}:
    
    from math import sqrt
   
    distance = {}     
    for items in stains_coords: 
        x2, y2 = coord_convert(items) 
        x1, y1 = coord_convert(start) 
    
        dist = sqrt(pow((x2-x1),2) + pow((y2-y1),2))
        distance[items] = round(dist, 2)
    
    return distance


# Part 4: Function solves map and generate the path taken by the robot to clean stains

def coord_split(coord) ->(tuple):
    
    r_letter = ""
    c_digit = ""

    for ch in coord:
        if ch.isalpha():
            r_letter += ch
        elif ch.isdigit():
            c_digit += ch
    
    row_num = ord(r_letter) - ord("A") + 1
    col_num = int(c_digit)
    return row_num, col_num   


def solveMap(map, start, stains_coords, distances) -> str:
    
    path = ""
    unclean = stains_coords.copy()
    current = start

    while len(unclean) > 0:        
        nearest_stain = None
        stain_dist = None

        for stain in unclean:
            d = distances[stain]  
            if nearest_stain is None or d < stain_dist:
                nearest_stain = stain
                stain_dist = d

        
        cr, cc = coord_split(current)       
        tr, tc = coord_split(nearest_stain) 

        # Vertical movement 
        while cr > tr:
            path += "U"
            cr -= 1
        while cr < tr:
            path += "D"
            cr += 1

        # Horizontal movement 
        while cc > tc:
            path += "L"
            cc -= 1
        while cc < tc:
            path += "R"
            cc += 1

        # 3) Update unclean stain
        current = nearest_stain
        unclean.remove(nearest_stain)

    return path
