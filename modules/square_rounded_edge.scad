//(c) Inne Lemstra 09-09-19

$fn = 100;

//parameters
width = 40;
heigth = 30;
edge_size = 5;

//list for translation of every corner ("boolean" if x or y is needed)
coord_edge =[[1,1], [1, 0], [0,0], [0,1]];


difference(){
    //base square where corners are substracted from
   square([width,heigth]);
        //loop to substract all corners
        for(idx = [0:3]){
            place_edge_x = coord_edge[idx][0] * (width  - 2*edge_size);
            place_edge_y = coord_edge[idx][1] * (heigth - 2*edge_size);
            translate([place_edge_x, place_edge_y, 0]){
                intersection(){
                    //substract circle from (quarter) square, create egde pieces 
                    difference(){
                        translate( edge_size * coord_edge[idx]) {
                            square(edge_size);
                        }
                        //move circle from origin center to x+ and y+                    
                        translate([edge_size,edge_size]) {
                                circle(edge_size);
                        }       
                    }
                }
            }
        }
}

