

coords = [[0,0], [0,1], [1,,1], [1,0]];

y_flag = 10;
x_flag = 16.5;

x_small_square = x_flag * 0.3818 ;
y_small_square = y_flag * 0.3182;

x_big_square = (x_flag - 2 * x_small_square) / 3 + x_small_square;
y_big_square = (y_flag - 2 * y_small_square) / 3 + y_small_square;


color("green")
square([x_flag, y_flag]);

for(i =[0:3]){
    
    if(i%2 == 0){
        color("blue")
         make_square(x_small_square, y_small_square, coords,  i, 0.02);
    }else{
        color("red")
        make_square(x_small_square, y_small_square,coords,  i, 0.02);
    }
    
    color("white")
    make_square(x_big_square, y_big_square, coords, i , 0.01);
    
    
    
}

module make_square(x,y, coords, i, h){
    
    translate([coords[i][0] *( x_flag - x), coords[i][1] * (y_flag - y),  h])
    square([x, y]);
    
}
