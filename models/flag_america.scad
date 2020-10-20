




module star(w_star = 40, angle_point = 20){
    
    o_triangle = w_star / 3 /2;
    s_triangle = o_triangle / sin(angle_point);
    a_triangle = o_triangle / tan(angle_point);
    
    
   
    angle_pent = 360 / 5;
    h_inside_star = (o_triangle * 2) / sin(angle_pent / 2)  + (cos(angle_pent / 2 ) * o_triangle * 2);
    for(i = [0:1:4]){
        rotate([0,0, angle_pent * i])
   //translate([0, h_inside_star,0])
   polygon([[-o_triangle, 0], [0, a_triangle] , [o_triangle, 0]]); 
    }

}

module place_stars(x_offset_star_1, y_offset_star_1){
    color("white")
    for(i = [0:1:8]){
        
        if(i%2 == 0){ //switch star placement between rows
           for(j = [0:1:5]){ // place 6 stars
               translate([x_offset_star_1 + w_star*j, h_flag - y_offset_star_1 - h_star * i ,0])
               star();
           }
        }else{
           for(j = [0:1:4]){
               translate([x_offset_star_1 +w_star/2 +  w_star *j, h_flag - y_offset_star_1 - h_star * i ,0])
               star();
           }
           
        } 
        
        
    }
}

module blue_square(x_star_offset, y_star_offset){
    color("blue"){
    w_blue_square = x_star_offset * 2 +32.5 * 11;
    h_blue_square = y_star_offset * 2 + 29* 9;
    translate([0, h_flag - h_blue_square, 0])
    square([w_blue_square, h_blue_square]);
    }
}

module stripes(){
    h_bar = h_flag /13;
    for(i = [0:1:12]){
        if(i % 2 == 0){
            color("red")
            translate([0,h_bar * i,0])
            square([w_flag, h_bar]);
            
        }else{
            color("white")
            translate([0,h_bar * i,0])
            square([w_flag, h_bar]);       
        }
        
        
    }
    
    
}

h_flag = 596;
w_flag =  1100;

w_star = 70;
h_star = (w_star / 3 /2) / tan(20) ;
x_star_offset = 30;
y_star_offset = 30;

translate([0,0,.2])
place_stars(x_star_offset, y_star_offset);

translate([0,0,.1])
blue_square(x_star_offset, y_star_offset);

stripes();