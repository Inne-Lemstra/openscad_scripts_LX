//(c) Inne Lemstra 09-09-19

$fn = 100;

width = 20;
heigth = 20;
edge_size = 5;

coord_edge =[[1,1], [1, 0], [0,0], [0,1]];
   

difference(){
   square([width,heigth]);
    
        for(idx = [0:3]){
            place_edge_x = coord_edge[idx][0] * (width  - 2*edge_size);
            place_edge_y = coord_edge[idx][1] * (heigth - 2*edge_size);
            translate([place_edge_x, place_edge_y, 0]){
                intersection(){
                    difference(){
                        square(edge_size *2);
                        translate([edge_size,edge_size]) {
                                circle(edge_size);
                        }

                    }
                    translate( edge_size * coord_edge[idx]) {
                        square(edge_size);
                    }
                }
            }
        }   
}

