//(c) Inne Lemstra 11-09-2021
//templates for assiting with sketching out ideas
//models can be 3D printed or lasercut.
//based on templates from Spohy Wong
//https://www.thingiverse.com/thing:4665340
//https://www.youtube.com/watch?v=1bn5baWig0w

render_rounded_outer_corners = true;
render_thumbnail = false;
render_storyboard = true;

set_grid = false;

render_2D = true;   //if false make stl files (for 3D printing)

//choose "square_size", "square_number", "custom_grid" for which variable you want to set
render_by = "square_size"; // square_size, square_number or custom_grid



international_paper = [
    [841,1189],  //A0 international paper is index 0
    [594, 841 ],
    [420, 594 ],
    [297, 420 ],
    [210, 297 ],
    [148, 210 ],
    [105, 148 ],
    [74, 105 ],
    [52, 74 ],      //A8 international paper is index 8
    //[x, y]             // your custom sketchbook size in mm, use index 9 (paper_A[9])
];

//use 9 for custom canvas size if you added it in above list.
paper_A = 4;
sketchbook_size = international_paper[paper_A];

//if render outer corners is true, these are the radius of the corneres in mm.
r_outer_corners = 10;


square_size = [30, 30];
//separation in mm between squares (side, top)
square_rim = [10, 10];
// garanteed to have at least this many mm of plastic on the side and top edges
min_edge = [5, 5];


num_cols = floor((sketchbook_size.x + square_rim.x  - min_edge.x * 2) / (square_size.x + square_rim.x));
num_rows = floor((sketchbook_size.y +square_rim.y - min_edge.y * 2) / (square_size.y + square_rim.y));

//storyboard parameters
story_window_size = [50, 50];
//distance between window to draw in and line underneath to draw comment on.
story_h_noteline = 15;
// length of noteline, thickness of noteline (for pencil)
story_noteline = [story_window_size.x, 2];  
story_rim = [10,10];

echo([num_cols, num_rows]);


difference(){
    make_outer_shell();
if(render_thumbnail){
    grid = set_grid ? [num_cols, num_rows] : calculate_grid(square_size, square_rim);
    thumb_offset = center_grid_offset(square_size, square_rim, grid);
    translate([thumb_offset.x / 2, thumb_offset.y / 2,0])
    #make_thumbnail_grid();
} else if(render_storyboard){
    let( story_dim = [story_window_size.x + min_edge.x/2,  story_window_size.y + story_h_noteline + story_noteline.y]){
    grid = set_grid ? [num_cols, num_rows] : calculate_grid(story_dim, story_rim);
    story_offset = center_grid_offset(story_dim, story_rim, grid);
    translate([story_offset.x / 2, story_offset.y / 2, 0])
    make_storyboard_grid();
    }
}
}



function center_grid_offset(object, rim, grid) = [
    sketchbook_size.x - grid.x * (object.x + rim.x) +  rim.x,
    sketchbook_size.y - grid.y * (object.y + rim.y) + rim.y
];
    
function calculate_grid(object, rim) = [
floor((sketchbook_size.x + rim.x  - min_edge.x * 2) / (object.x + rim.x)),
floor((sketchbook_size.y + rim.y  - min_edge.y * 2) / (object.y + rim.y))
];

module make_thumbnail_grid(){
    
    for(x = [0 : num_cols - 1], y = [0 : num_rows - 1]){
            translate(-sketchbook_size / 2)
            //translate(square_rim)
            translate([x, 0 ,0] * (square_rim.x + square_size.x) )
            translate([0, y ,0] * (square_rim.y + square_size.y) )
            square(square_size);
        
    }
}

module make_storyboard_grid(){
    
    story_dim = [
    story_window_size.x + story_rim.x, 
    story_window_size.y + story_h_noteline + story_noteline.y + story_rim.y
    ];
    echo(story_dim);
    story_grid = set_grid ? 
                            [num_cols, num_rows] :
        [ floor((sketchbook_size.x + story_rim.x  - min_edge.x * 2) / story_dim.x),
        floor((sketchbook_size.y + story_rim.y  - min_edge.x * 2) / story_dim.y)];
    echo(story_grid);
    for(x=[0:1:story_grid.x - 1], y=[0:1:story_grid.y - 1]){
    translate([story_dim.x * x, story_dim.y * y,0])
    translate(-sketchbook_size /2)
    translate(story_dim /2)
    #storyboard();

    }
        
}



module storyboard(){
    
    square(story_window_size, center = true);
    translate([0, -story_window_size.y / 2, 0])
    translate([0, - story_h_noteline,0])
    square(story_noteline, center = true);
    
}

module make_outer_shell(){
    //2D outer body from which to cut the squares out off 
    
if(render_rounded_outer_corners){
        round_outer_corners() square(sketchbook_size, center = true);
    }else{ 
            square(sketchbook_size, center = true) ;
    }
 
}


module round_outer_corners(sketchbook_size = sketchbook_size, r_corner = r_outer_corners){
    color("blue")
    difference(){
    children(0);
    
    for(x = [0,1] , y = [0,1] ){
        mirror([x,0,0])
        mirror([0,y,0])
        translate(sketchbook_size /2 )
        translate(concat([-1,-1] * r_corner))
        fillet_template(r_corner);
    }
}
}

module fillet_template(r_fillet, $fn=100){
    //quikly create a rounded 2D fillet template to difference with to be filleted body
    difference(){
    color("red")
    square([1,1] * r_fillet);
    circle(r = r_fillet);
    }
}



module canvas_check(condition, sketchbook_size){
    //Check if the number of requested squares still fits in sketchbook
    //If false return error message and stop render
    
    assert(1 > 0, "template does not fit in sketchbook, check your square sizes");
    
    
}


