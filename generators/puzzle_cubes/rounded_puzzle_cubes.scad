//(c) Inne Lemstra 19-10-20
//requires version 2019.05 or newer


//there are no binairy operations so we have to hack our functionality by using strings and search()

//positioning system kinda works, shows weird behaviour when stacking more than 6 blocks (number of 6 digits)
// because str() turn it into "6+e100.1" instead of the whole number
//found bug when rendering a standing square

$fn = 20;
//echo(100101);
w_cube = 5;
r_edge = .4; //the radius of the rounding on an edge
render_piece = true;



//represent your shape as 2 dimesional matrix with binaity numbers to indicate block arrangement in z axis
piece_grid = [
    [0,     0,      1,     0],
    [1,     1,      11,     0],
    [0,      0,     1,     0],
    [0,     0,      0,      0],
    ];
    
    
bin_grid = [ for (bii = piece_grid) [ for (j = bii) each(search(str(1),list_to_string(reverse(str(j))), 0))] ];
 
for (bii = piece_grid) {
    for (j = bii) {
        t1 = len(reverse(str(j)))-1;
        //echo(list_to_string(reverse(str(j))));
        }
        
    } 

if(search(1,bin_grid[1][1])){
//echo("whats up");
}
//echo(reverse("hallo"));
//echo( list_to_string(reverse("hallo")) );


////echo(str("h", "q"));

if(render_piece){
    //echo(bin_grid);
    //echo("search whole list", search(2,  bin_grid, 0));
     for(y_row = [0: 1 :len(bin_grid)-1 ]){
        //determine what edges to round off
         //no neighbour edge rounded
     for(x_col = [0:1:len(bin_grid[y_row])]){
         for(z_heigth = bin_grid[y_row][x_col] ){
              neighbours =  neighbour_blocks( y_row, x_col,  z_heigth, bin_grid);
    //         //echo("z_h:", z_heigth);
    //         //echo("len z: ", max( bin_grid[y_row][x_col] ));
             //echo("row, col: ", y_row, x_col);
             len_z = max(bin_grid[y_row][x_col]);
             translate([x_col, y_row, z_heigth]  * w_cube)
             //cube([1,1,1] * w_cube);
            
             rounded_cube(neighbours);
         }
     }
        
         }
     
 }
     
module rounded_cube(neighbours){
 //make a cube with along certain edges rounded curves
 //also no pointy corners
    difference(){
    cube([1,1,1] *w_cube);
        outer_cube() make_frame()cube([r_edge, r_edge, w_cube]);
    }
  

    //echo("rounded nb: ", neighbours );
    outer_cube() edge_frame();
    
    for(nb = neighbours){
        ////echo("rounded nb: ", nb );
        //connecting upstairs downstair neighbour
        if(nb[2] != 0 && (nb[1] == 0 && nb[0] == 0)){
            translate([0,0, (w_cube / 2 + r_edge /2) * nb[2]])
            translate([0,0, w_cube / 2 - r_edge /2 ])
            //make_frame()translate([0,0, r_edge])cube([r_edge, r_edge, w_cube - r_edge * 2]); 
            rounded_frame();
        }
        //connecting nextdoor neighbour
        if(nb[2] == 0 && nb[1] !=0){
            translate([0,(w_cube /2 +r_edge /2) * nb[1] ,0])
            translate([0, r_edge + (w_cube - r_edge )/2 ,0 ])
            rotate([90,0,0] )
            //make_frame()translate([0,0, r_edge])cube([r_edge, r_edge, w_cube - r_edge * 2]);    
            rounded_frame();
        }else if(nb[2] == 0 && nb[0] != 0){
                        translate([(w_cube /2 +r_edge /2) * nb[0] ,0,0])
            translate([ r_edge + (w_cube - r_edge )/2, 0 ,0 ])
            rotate([0,-90,0] )
            //make_frame()translate([0,0, r_edge])cube([r_edge, r_edge, w_cube - r_edge * 2]);    
            rounded_frame();
        }
    }

 }
 
    
    


 
 module outer_cube(){
     children();
     translate([0,0,w_cube])
     mirror([0,0,1])
     children();
     
     translate([0,w_cube,0])
     rotate([90,0,0])
     children();
     
     mirror([0,1,0])
     rotate([90,0,0])
     children();
 }
 
 module rounded_frame(){
                 make_frame()
     union(){
     translate([0,0, r_edge])
     cube([r_edge, r_edge, w_cube - r_edge * 2]);
     
         translate([0,0, w_cube])
                rotate([-90,0,0])
                  translate([1,1,1] * r_edge)
       rotate([0,-90,0])
         difference(){
     cylinder(r_edge, r =r_edge);
             translate([0,-1,0]* r_edge)
             cube([1,2,1] *r_edge);
             translate([-1,0,0]* r_edge)
             cube([1,1,1] *r_edge);
         }
     
         
         translate([1,1,1] * r_edge)
       rotate([0,-90,0])
         difference(){
     cylinder(r_edge, r =r_edge);
             translate([0,-1,0]* r_edge)
             cube([1,2,1] *r_edge);
             translate([-1,0,0]* r_edge)
             cube([1,1,1] *r_edge);
         }
     }
 }
 
 
 //rounded_frame();
//edge_frame();
 module edge_frame(){
    intersection(){
        make_frame()cube([r_edge, r_edge, w_cube]);
        make_frame()translate([1,1,0] * r_edge ) bumper();
    }
     
 }
 
 module bumper(){
     translate([0,0, r_edge])
     cylinder(w_cube - r_edge * 2, r= r_edge);
     translate([0,0,r_edge ])
     sphere(r_edge);
     translate([0,0,r_edge  + w_cube - r_edge * 2])
     sphere(r_edge);
     
 }
 
 module make_frame(){
     
     mirror([0,0,1])
      rotate([0,90,0])
     children();
    
       translate([0,w_cube,0])
     mirror([0,1,0])
     mirror([0,0,1])
    rotate([0,90,0])
    children();

    rotate([0,-90,0])
    rotate([-90,0,0])
     children();

    translate([w_cube,0,0])
    mirror([1,0,0])
    rotate([0,-90,0])
    rotate([-90,0,0])
    children();
     
 }
 
 
 
 function list_to_string(list, c_n=0) =
     c_n == len(list) - 1 ?
     list[c_n]:
     str(list[c_n] ,list_to_string(list , c_n + 1));
  
  
 function reverse(string) =  [for (i = [len(string) - 1: -1: 0]) string[i]];
 
////echo("ref index:", bin_grid[-1][0]); 
// //echo("nb_func:", neighbour_blocks(1,2, 1, bin_grid));
// 
// //echo("t4:", search(1, undef));
// 
// for(x=[-1,0,1],y=[-1,0,1], z= [-1,0,1]){
//     heigth =0;
//     y_row =1;
//     x_col =1;
//     grid =bin_grid;
// if(
//            ((x == 0 || y ==0) ? ([x,y,z] !=[0,0,0]) : false )
//                && 
//                    (
//                    search(heigth + z, grid[y_row + y][x_col + x]) 
//                        &&
//                            !is_undef(grid[y_row + y][x_col + x])
//                    )
//            )
//        
//            //echo([x,y, z]);
//     
// }
// 
// //echo(bin_grid[1][2]);
 
module  corners_to_round(x_col, y_row, heigth, grid) {
        pos_mod = [-1,0,1];
 
    for(x =pos_mod, y=pos_mod){
    if(((x == 0 || y ==0 ) ? x!=y : false )&& search(heigth, grid[x_col + x][y_row + y])){
        
    }
        
       
    }
};

function neighbour_blocks(y_row, x_col, heigth, grid) = 
    [
    for(x=[-1,0,1],y=[-1,0,1], z= [-1,0,1])
        if(
            ((x == 0 || y ==0) ? ([x,y,z] !=[0,0,0]) : false )
                && 
                    (
                    search(heigth + z, grid[y_row + y][x_col + x]) 
                        &&
                            !is_undef(grid[y_row + y][x_col + x])
                    )
            )
        
            [x,y, z]
        ];