//
// Trial MK52 key
//

ks1 = 0;
ks2 = 1;

td=  1.0;
tx = 8.5;
ty = 5.7;

module rounded_cube(td, tx, ty, tz)
{
cube([tx-td, ty, tz], center=true);
cube([tx, ty-td, tz], center=true);

translate([tx/2-td/2, ty/2-td/2, 0])
cylinder(d=td, h=tz, $fn=100, center=true);

translate([tx/2-td/2, -ty/2+td/2, 0])
cylinder(d=td, h=tz, $fn=100, center=true);

translate([-tx/2+td/2, ty/2-td/2, 0])
cylinder(d=td, h=tz, $fn=100, center=true);

translate([-tx/2+td/2, -ty/2+td/2, 0])
cylinder(d=td, h=tz, $fn=100, center=true);
}

tz = 4.8;
tz_f = 0.5;
pin_h = 1.5;
sprue_z= 1.6;

module keya()
{
rounded_cube(1.0, 8.5, 5.7, tz);
translate([0,0,-tz/2+tz_f/2])
rounded_cube(1.0, 6.5, 5.7+2, tz_f);

translate([-5, 0, -tz/2+sprue_z/2])
cube([3, 2, sprue_z], center=true);

translate([0, 5, -tz/2+sprue_z/2])
cube([2, 3, sprue_z], center=true);

//translate([0,0, -tz/2-pin_h/2])
//cylinder(d1=2.5, d2=4.0, h=pin_h, $fn=100, center=true);
}

th = 1.0;
module hollow_cube(h)
{
 
 difference()
 {
     cube([8.5, 5.7+2, h], center=true);
     cube([8.5-th, 5.7-th+2, h+0.3], center=true);
     
 }   
}

module cross(a)
{
    rotate([0,0,a])
translate([0,0,-tz/2-pin_h/2-0.55])
cube([10,1,0.5], center=true);
}

module key(string)
{
difference()
    {
        keya();
        
        translate([-4.0,-1, 5/2-0.8])
        scale([.2, .2, .5])

        linear_extrude(height = 2)
        {
        text(string, center=true);
        }
        translate([0,0,-tz/2-4.5/2+3.0])
        cylinder(d=2.7,h=4.5,$fn=100,center=true);
    }
    //translate([0,0,-tz/2-pin_h/2-0.1])
    //hollow_cube(pin_h-0.1);
    //cross(45);
    //cross(-45);
}

scx=1.2;
scy=1.5;
labi = 0;
labels1 = [ 
" SST", "  RCL", "  BST", " STO", " R/W", " RTN", " GTO", "  ADR", "  R/S", " GSB"
];

labels2 = [ 
"  CHS", "  EEX", " X<>Y", "  ENT",

];

echo("ks1=", ks1);


xm = ks1*4 + ks2*3;
ym = ks1*1 + ks2*0;

echo("xm=", xm);
echo("ym=", ym);

for(x = [0 : tx*scx : tx*scx*xm])
{
for(y = [0 : ty*scy : ty*scy*ym])
{
  
if( ks2 )
{    
translate([x,y,0])
rotate([0, 0, 0])
key(labels2[(x/(tx*scx))+5*y/(ty*scy)]);
}

if(ks1)
{
translate([x,y,0])
rotate([0, 0, 0])
key(labels1[(x/(tx*scx))+5*y/(ty*scy)]);
}

labi = labi+1;
}
}

echo("X step:",tx*scx);
echo("Y step:",ty*scy);