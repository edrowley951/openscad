/* Mounting Plate for IEC320 Fused Socket with Switch (Jaycar Prod Number PP4003
http://www.jaycar.com.au/productView.asp?ID=PP4003)
Created by David Bainbridge
4th November 2014

Creative Commons License
This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.



*/

//78.5x31.5x2.5

socket_ext_length = 50;
socket_ext_height = 31;

socket_int_length = 48;
socket_int_height = 28;

plate_length = 78.5;//socket_int_length + 20;
plate_height = 36.5;//socket_int_height + 20;
plate_depth = 2.5;

socket_clip_depth = 0.7;
socket_clip_height = (socket_ext_height-socket_int_height)/2;
socket_clip_cutout_depth = plate_depth - socket_clip_depth;

support_length = 18;


transpoint = [(plate_length-socket_int_length)/2, (plate_height-socket_ext_height)/2,0];


module plate() {
	cube([plate_length, plate_height, plate_depth]);
}

module opening() {
	cube([socket_int_length, socket_ext_height, plate_depth]);
}

module clip() {
	cube([socket_int_length, socket_clip_height, socket_clip_depth]);
}





difference() {
	plate();
	translate(transpoint) opening();

}

translate(transpoint) clip();
translate(transpoint + [0,socket_ext_height-socket_clip_height,0]) clip();

translate(transpoint + [(socket_int_length-support_length)/2, 0, socket_clip_depth]) cube([support_length, socket_clip_height, socket_clip_cutout_depth]);

translate(transpoint + [(socket_int_length-support_length)/2, socket_ext_height-socket_clip_height, socket_clip_depth]) cube([support_length, socket_clip_height, socket_clip_cutout_depth]);


