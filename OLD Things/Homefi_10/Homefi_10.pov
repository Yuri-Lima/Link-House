//POVRay-Ficheiro criado por 3d41.ulp v20110101
//C:/Users/ymlim/Dropbox/Arduino/Homefi_10/Homefi_10.brd
//25/02/2016 11:18

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 202;
#local cam_z = -108;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -4;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 16;
#local lgt1_pos_y = 26;
#local lgt1_pos_z = 24;
#local lgt1_intense = 0.728773;
#local lgt2_pos_x = -16;
#local lgt2_pos_y = 26;
#local lgt2_pos_z = 24;
#local lgt2_intense = 0.728773;
#local lgt3_pos_x = 16;
#local lgt3_pos_y = 26;
#local lgt3_pos_z = -16;
#local lgt3_intense = 0.728773;
#local lgt4_pos_x = -16;
#local lgt4_pos_y = 26;
#local lgt4_pos_z = -16;
#local lgt4_intense = 0.728773;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 42.862500;
#declare pcb_y_size = 46.990000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(610);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Dados da animaçao
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "Sem/poucos dados para a animaçao (min. 3 pontos) (Caminho de vôo)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "Sem/poucos dados para a animaçao (min. 3 pontos) (Ver caminho)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-21.431250,0,-23.495000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro HOMEFI_10(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Placa
prism{-1.500000,0.000000,52
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,0.000000,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,0.000000,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,10.001111,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,10.001111,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,20.002222,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,20.002222,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,30.003334,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,30.003334,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,40.004445,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,40.004445,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,50.005556,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,50.005556,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,60.006667,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,60.006667,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,70.007779,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,70.007779,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,80.008890,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,80.008890,0>)+<11.430000,0,11.430000>).z>
<(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,90.010001,0>)+<11.430000,0,11.430000>).x,(vrotate(<11.430000,0,0.000000>-<11.430000,0,11.430000>,<0,90.010001,0>)+<11.430000,0,11.430000>).z>
<0.000000,11.430000>
<0.000000,11.430000><0.000000,35.560000>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,0.000000,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,0.000000,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,10.001111,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,10.001111,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,20.002222,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,20.002222,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,30.003334,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,30.003334,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,40.004445,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,40.004445,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,50.005556,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,50.005556,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,60.006667,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,60.006667,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,70.007779,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,70.007779,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,80.008890,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,80.008890,0>)+<11.430000,0,35.560000>).z>
<(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,90.010001,0>)+<11.430000,0,35.560000>).x,(vrotate(<0.000000,0,35.560000>-<11.430000,0,35.560000>,<0,90.010001,0>)+<11.430000,0,35.560000>).z>
<11.430000,46.990000>
<11.430000,46.990000><31.432500,46.990000>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,0.000000,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,0.000000,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,10.001111,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,10.001111,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,20.002222,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,20.002222,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,30.003334,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,30.003334,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,40.004445,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,40.004445,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,50.005556,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,50.005556,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,60.006667,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,60.006667,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,70.007779,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,70.007779,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,80.008890,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,80.008890,0>)+<31.432500,0,35.560000>).z>
<(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,90.010001,0>)+<31.432500,0,35.560000>).x,(vrotate(<31.432500,0,46.990000>-<31.432500,0,35.560000>,<0,90.010001,0>)+<31.432500,0,35.560000>).z>
<42.862500,35.560000>
<42.862500,35.560000><42.862500,11.430000>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,0.000000,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,0.000000,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,10.001111,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,10.001111,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,20.002222,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,20.002222,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,30.003334,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,30.003334,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,40.004445,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,40.004445,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,50.005556,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,50.005556,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,60.006667,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,60.006667,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,70.007779,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,70.007779,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,80.008890,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,80.008890,0>)+<31.432500,0,11.430000>).z>
<(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,90.010001,0>)+<31.432500,0,11.430000>).x,(vrotate(<42.862500,0,11.430000>-<31.432500,0,11.430000>,<0,90.010001,0>)+<31.432500,0,11.430000>).z>
<31.432500,0.000000>
<31.432500,0.000000><11.430000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Furos(real)/Comps
//Furos(real)/Placa
//Furos(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Componentes
union{
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("103",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<8.241000,-1.500000,27.407000>translate<0,-0.035000,0> }#end		//SMD Resistor 0805 1 10k M0805
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<33.020000,0.000000,15.875000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 2 10k M0805
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("104",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<15.240000,-1.500000,3.810000>translate<0,-0.035000,0> }#end		//SMD Resistor 0805 3 100k M0805
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("331",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<30.480000,0.000000,15.875000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 4 330R M0805
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("331",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<36.830000,0.000000,22.860000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 5 330 M0805
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("221",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<31.143000,-1.500000,32.556000>translate<0,-0.035000,0> }#end		//SMD Resistor 0805 6 220 M0805
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("331",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<8.062500,-1.500000,23.810000>translate<0,-0.035000,0> }#end		//SMD Resistor 0805 7 330 M0805
#ifndef(pack_Z) #declare global_pack_Z=yes; object {RES_SMD_CHIP_0805("472",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<17.780000,-1.500000,38.650000>translate<0,-0.035000,0> }#end		//SMD Resistor 0805 8 4k7 M0805
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_SMD_CHIP_0805()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,180> translate<27.940000,-1.500000,32.385000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0805 C1 100 6,3v C0805
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_SMD_CHIP_0805()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,180> translate<22.860000,-1.500000,3.810000>translate<0,-0.035000,0> }#end		//SMD Capacitor 0805 C2 100 6,3v C0805
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_SMD_ELKO_0605("",)translate<0,-0,0> rotate<0,180.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<31.750000,-1.500000,8.890000>translate<0,-0.035000,0> }#end		//SMD Elko Case-Code BCComponents (rcl.lib) C3  153CLV-0605
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_SMD_CHIP_0805()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<33.020000,0.000000,20.320000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C5 100uF C0805
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_SMD_CHIP_0805()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<30.480000,0.000000,20.320000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C6 100uF C0805
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_SMD_SOT223("","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<25.400000,0.000000,40.005000>translate<0,0.035000,0> }#end		//SOT223 IC2  SOT223
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_SMD_LED_CHIP_0805(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,90.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<36.830000,0.000000,25.400000>translate<0,0.035000,0> }#end		//SMD-LED im 0805 LED1  CHIPLED_0805
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {IC_SMD_SOT23("BC817-16SMD","",)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<19.050000,-1.500000,31.750000>translate<0,-0.035000,0> }#end		//SOT23 Q1 BC817-16SMD SOT23-BEC
#ifndef(pack_USB) #declare global_pack_USB=yes; object {CON_PH_1X3()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-135.000000,0> rotate<0,0,180> translate<5.080000,-1.500000,41.275000>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) USB  1X03
#ifndef(pack_X2) #declare global_pack_X2=yes; object {CON_ARK_5MM_2()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<5.080000,-1.500000,14.605000>}#end		//Screw Terminal conn. 2Pin (con-ptr500.lib) X2  AK500/2
#ifndef(pack_X3) #declare global_pack_X3=yes; object {CON_ARK_5MM_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<38.100000,0.000000,15.875000>}#end		//Screw Terminal conn. 2Pin (con-ptr500.lib) X3  AK500/2
#ifndef(pack_X4) #declare global_pack_X4=yes; object {CON_ARK_5MM_2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<38.100000,0.000000,32.385000>}#end		//Screw Terminal conn. 2Pin (con-ptr500.lib) X4  AK500/2
}//End union
#end
#if(pcb_pads_smds=on)
//Pads e SMD/Comps
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<8.241000,-1.537000,28.357000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<8.241000,-1.537000,26.457000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<33.020000,0.000000,16.825000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<33.020000,0.000000,14.925000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<16.190000,-1.537000,3.810000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<14.290000,-1.537000,3.810000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<30.480000,0.000000,14.925000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<30.480000,0.000000,16.825000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<35.880000,0.000000,22.860000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<37.780000,0.000000,22.860000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<31.143000,-1.537000,33.506000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<31.143000,-1.537000,31.606000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<7.112500,-1.537000,23.810000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<9.012500,-1.537000,23.810000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<16.830000,-1.537000,38.650000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<18.730000,-1.537000,38.650000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.940000,-1.537000,33.235000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<27.940000,-1.537000,31.535000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<22.010000,-1.537000,3.810000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<23.710000,-1.537000,3.810000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<29.050000,-1.537000,8.890000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<34.450000,-1.537000,8.890000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<33.020000,0.000000,19.370000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<33.020000,0.000000,21.270000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<30.480000,0.000000,19.370000>}
object{TOOLS_PCB_SMD(1.300000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<30.480000,0.000000,21.270000>}
#ifndef(global_pack_F1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<7.620000,0,31.115000> texture{col_thl}}
#ifndef(global_pack_F1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<7.620000,0,20.955000> texture{col_thl}}
#ifndef(global_pack_GPIO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.540000,1.300000,1,16,1+global_tmp,0) rotate<0,-45.000000,0>translate<34.574900,0,3.845900> texture{col_thl}}
#ifndef(global_pack_GPIO) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.540000,1.300000,1,16,1+global_tmp,0) rotate<0,-45.000000,0>translate<39.171097,0,8.442097> texture{col_thl}}
#ifndef(global_pack_HKLP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<21.550000,0,33.115000> texture{col_thl}}
#ifndef(global_pack_HKLP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<16.550000,0,33.115000> texture{col_thl}}
#ifndef(global_pack_HKLP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<26.750000,0,3.715000> texture{col_thl}}
#ifndef(global_pack_HKLP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,0+global_tmp,0) rotate<0,-270.000000,0>translate<11.350000,0,3.715000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.219200,2.235200,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<23.088600,0.000000,36.906200>}
object{TOOLS_PCB_SMD(1.219200,2.235200,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<25.400000,0.000000,36.906200>}
object{TOOLS_PCB_SMD(1.219200,2.235200,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<27.711400,0.000000,36.906200>}
object{TOOLS_PCB_SMD(3.600000,2.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<25.400000,0.000000,43.104000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<35.780000,0.000000,25.400000>}
object{TOOLS_PCB_SMD(1.200000,1.200000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<37.880000,0.000000,25.400000>}
object{TOOLS_PCB_SMD(1.000000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<20.000000,-1.537000,30.650000>}
object{TOOLS_PCB_SMD(1.000000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<19.050000,-1.537000,32.850000>}
object{TOOLS_PCB_SMD(1.000000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<18.100000,-1.537000,30.650000>}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<2.413000,0,23.495000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.914400,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<5.207000,0,28.575000> texture{col_thl}}
#ifndef(global_pack_RESET) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.540000,1.300000,1,16,1+global_tmp,0) rotate<0,-315.000000,0>translate<3.385900,0,8.201097> texture{col_thl}}
#ifndef(global_pack_RESET) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.540000,1.300000,1,16,1+global_tmp,0) rotate<0,-315.000000,0>translate<7.982097,0,3.604900> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,0.800000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<16.860000,0,42.105200> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,0.800000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<11.780000,0,42.105200> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,0.800000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<14.320000,0,42.105200> texture{col_thl}}
#ifndef(global_pack_U_1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,0.800000,1,16,0+global_tmp,0) rotate<0,-180.000000,0>translate<19.400000,0,42.105200> texture{col_thl}}
#ifndef(global_pack_U1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.100000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<31.170000,0,42.925000> texture{col_thl}}
#ifndef(global_pack_U1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.100000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<31.170000,0,37.845000> texture{col_thl}}
#ifndef(global_pack_U1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.100000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<31.170000,0,27.685000> texture{col_thl}}
#ifndef(global_pack_U1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.032000,1.100000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<31.170000,0,25.145000> texture{col_thl}}
#ifndef(global_pack_USB) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,1+global_tmp,0) rotate<0,-315.000000,0>translate<3.283950,0,39.478947> texture{col_thl}}
#ifndef(global_pack_USB) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,1+global_tmp,0) rotate<0,-315.000000,0>translate<5.080000,0,41.275000> texture{col_thl}}
#ifndef(global_pack_USB) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,1+global_tmp,0) rotate<0,-315.000000,0>translate<6.876053,0,43.071050> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<5.080000,0,12.090400> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<5.080000,0,17.119600> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,13.360400> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,18.389600> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,29.870400> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.981200,1.320800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<38.100000,0,34.899600> texture{col_thl}}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,13.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,15.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,17.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,19.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,21.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,23.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,25.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.550000,-1.537000,27.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,27.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,25.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,23.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,21.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,19.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,17.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,15.915000>}
object{TOOLS_PCB_SMD(2.000000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.550000,-1.537000,13.915000>}
//Pads/Vias
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<24.130000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<27.940000,0,39.370000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<31.115000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<20.320000,0,36.830000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<18.415000,0,26.987500> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<27.940000,0,29.527500> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<29.210000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<11.430000,0,36.195000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<35.560000,0,11.112500> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<13.970000,0,30.480000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<38.100000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<15.875000,0,22.225000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<30.480000,0,6.350000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.006400,0.600000,1,16,1,0) translate<20.320000,0,17.780000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.206400,0.800000,1,16,1,0) translate<22.860000,0,20.955000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Sinais
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.270000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.270000,-1.535000,34.290000>}
box{<0,0,-0.533400><7.620000,0.035000,0.533400> rotate<0,90.000000,0> translate<1.270000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.905000,-1.535000,9.681997>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.905000,-1.535000,13.970000>}
box{<0,0,-0.533400><4.288003,0.035000,0.533400> rotate<0,90.000000,0> translate<1.905000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.905000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,14.605000>}
box{<0,0,-0.533400><0.898026,0.035000,0.533400> rotate<0,-44.997030,0> translate<1.905000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,0.000000,22.225000>}
box{<0,0,-0.533400><0.127000,0.035000,0.533400> rotate<0,-90.000000,0> translate<2.540000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.413000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,0.000000,22.352000>}
box{<0,0,-0.533400><1.150034,0.035000,0.533400> rotate<0,83.654287,0> translate<2.413000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,0.000000,22.352000>}
box{<0,0,-0.533400><10.033000,0.035000,0.533400> rotate<0,-90.000000,0> translate<2.540000,0.000000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.270000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,25.400000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<1.270000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,33.020000>}
box{<0,0,-0.533400><5.080000,0.035000,0.533400> rotate<0,90.000000,0> translate<2.540000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.905000,-1.535000,9.681997>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.385900,-1.535000,8.201097>}
box{<0,0,-0.533400><2.094309,0.035000,0.533400> rotate<0,44.997030,0> translate<1.905000,-1.535000,9.681997> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.810000,0.000000,20.955000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<2.540000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.810000,-1.535000,25.400000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,0.000000,0> translate<2.540000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.810000,-1.535000,26.670000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<2.540000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<4.762500,0.000000,34.607500>}
box{<0,0,-0.533400><3.143090,0.035000,0.533400> rotate<0,-44.997030,0> translate<2.540000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.810000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,-1.535000,24.130000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<3.810000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,-1.535000,24.130000>}
box{<0,0,-0.533400><3.810000,0.035000,0.533400> rotate<0,90.000000,0> translate<5.080000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,27.178000>}
box{<0,0,-0.533400><2.413000,0.035000,0.533400> rotate<0,90.000000,0> translate<5.080000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,27.432000>}
box{<0,0,-0.533400><4.318000,0.035000,0.533400> rotate<0,-90.000000,0> translate<5.080000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,27.178000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.207000,0.000000,28.575000>}
box{<0,0,-0.533400><1.402761,0.035000,0.533400> rotate<0,-84.799974,0> translate<5.080000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.207000,0.000000,28.575000>}
box{<0,0,-0.533400><1.150034,0.035000,0.533400> rotate<0,-83.654287,0> translate<5.080000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,-1.535000,19.050000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<5.080000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,0.000000,23.495000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<5.080000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.810000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,-1.535000,26.670000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,0.000000,0> translate<3.810000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<1.270000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,-1.535000,39.370000>}
box{<0,0,-0.533400><7.184205,0.035000,0.533400> rotate<0,-44.997030,0> translate<1.270000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.445000,0.000000,33.115000>}
box{<0,0,-0.533400><1.930402,0.035000,0.533400> rotate<0,-44.997030,0> translate<5.080000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<7.112500,-1.535000,25.907500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<7.112500,-1.535000,23.810000>}
box{<0,0,-0.533400><2.097500,0.035000,0.533400> rotate<0,-90.000000,0> translate<7.112500,-1.535000,23.810000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<7.112500,-1.535000,25.907500>}
box{<0,0,-0.533400><1.078338,0.035000,0.533400> rotate<0,44.997030,0> translate<6.350000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<7.302500,-1.535000,37.782500>}
box{<0,0,-0.533400><6.735192,0.035000,0.533400> rotate<0,-44.997030,0> translate<2.540000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.810000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<7.620000,0.000000,20.955000>}
box{<0,0,-0.533400><3.810000,0.035000,0.533400> rotate<0,0.000000,0> translate<3.810000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.028000,-1.535000,26.670000>}
box{<0,0,-0.533400><1.678000,0.035000,0.533400> rotate<0,0.000000,0> translate<6.350000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.028000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.241000,-1.535000,26.457000>}
box{<0,0,-0.533400><0.301227,0.035000,0.533400> rotate<0,44.997030,0> translate<8.028000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.255000,-1.535000,41.275000>}
box{<0,0,-0.533400><3.175000,0.035000,0.533400> rotate<0,0.000000,0> translate<5.080000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<5.080000,0.000000,17.119600>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<8.864600,0.000000,17.119600>}
box{<0,0,-0.711200><3.784600,0.035000,0.711200> rotate<0,0.000000,0> translate<5.080000,0.000000,17.119600> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<2.540000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,14.605000>}
box{<0,0,-0.533400><6.350000,0.035000,0.533400> rotate<0,0.000000,0> translate<2.540000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,19.050000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,0.000000,0> translate<6.350000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,0.000000,23.495000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,0.000000,0> translate<6.350000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.255000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,41.910000>}
box{<0,0,-0.533400><0.898026,0.035000,0.533400> rotate<0,-44.997030,0> translate<8.255000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,43.180000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,90.000000,0> translate<8.890000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<5.080000,0.000000,12.090400>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.915400,0.000000,12.090400>}
box{<0,0,-0.533400><3.835400,0.035000,0.533400> rotate<0,0.000000,0> translate<5.080000,0.000000,12.090400> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<9.012500,-1.535000,23.810000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<9.117500,-1.535000,23.915000>}
box{<0,0,-0.533400><0.148492,0.035000,0.533400> rotate<0,-44.997030,0> translate<9.012500,-1.535000,23.810000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.876053,-1.535000,43.071050>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<9.525003,-1.535000,45.720000>}
box{<0,0,-0.533400><3.746181,0.035000,0.533400> rotate<0,-44.997030,0> translate<6.876053,-1.535000,43.071050> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,14.605000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<9.580000,-1.535000,13.915000>}
box{<0,0,-0.533400><0.975807,0.035000,0.533400> rotate<0,44.997030,0> translate<8.890000,-1.535000,14.605000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<7.982097,0.000000,3.604900>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.092197,0.000000,1.270000>}
box{<0,0,-0.533400><3.147107,0.035000,0.533400> rotate<0,47.892031,0> translate<7.982097,0.000000,3.604900> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<8.864600,0.000000,17.119600>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.160000,0.000000,18.415000>}
box{<0,0,-0.711200><1.831972,0.035000,0.711200> rotate<0,-44.997030,0> translate<8.864600,0.000000,17.119600> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.160000,0.000000,22.225000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<8.890000,0.000000,23.495000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.160000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.160000,0.000000,22.225000>}
box{<0,0,-0.533400><3.810000,0.035000,0.533400> rotate<0,90.000000,0> translate<10.160000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<7.620000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.160000,0.000000,31.115000>}
box{<0,0,-0.711200><2.540000,0.035000,0.711200> rotate<0,0.000000,0> translate<7.620000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.160000,-1.535000,44.450000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,-44.997030,0> translate<8.890000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.890000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.795000,-1.535000,20.002500>}
box{<0,0,-0.533400><2.129855,0.035000,0.533400> rotate<0,-26.563298,0> translate<8.890000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<3.283950,0.000000,39.478947>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.321053,0.000000,39.478947>}
box{<0,0,-0.533400><8.037103,0.035000,0.533400> rotate<0,0.000000,0> translate<3.283950,0.000000,39.478947> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.350000,0.000000,3.715000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.350000,0.000000,10.715000>}
box{<0,0,-0.533400><7.000000,0.035000,0.533400> rotate<0,90.000000,0> translate<11.350000,0.000000,10.715000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.241000,-1.535000,28.357000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,-1.535000,31.546000>}
box{<0,0,-0.533400><4.509927,0.035000,0.533400> rotate<0,-44.997030,0> translate<8.241000,-1.535000,28.357000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,-1.535000,31.546000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,-1.535000,36.195000>}
box{<0,0,-0.533400><4.649000,0.035000,0.533400> rotate<0,90.000000,0> translate<11.430000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,36.830000>}
box{<0,0,-0.533400><0.635000,0.035000,0.533400> rotate<0,90.000000,0> translate<11.430000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.321053,0.000000,39.478947>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,39.370000>}
box{<0,0,-0.533400><0.154074,0.035000,0.533400> rotate<0,44.997030,0> translate<11.321053,0.000000,39.478947> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,39.370000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,90.000000,0> translate<11.430000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,41.755200>}
box{<0,0,-0.533400><2.385200,0.035000,0.533400> rotate<0,90.000000,0> translate<11.430000,0.000000,41.755200> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<9.580000,-1.535000,13.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.550000,-1.535000,13.915000>}
box{<0,0,-0.533400><1.970000,0.035000,0.533400> rotate<0,0.000000,0> translate<9.580000,-1.535000,13.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.795000,-1.535000,20.002500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.550000,-1.535000,19.915000>}
box{<0,0,-0.533400><0.760053,0.035000,0.533400> rotate<0,6.610311,0> translate<10.795000,-1.535000,20.002500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<9.117500,-1.535000,23.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.550000,-1.535000,23.915000>}
box{<0,0,-0.533400><2.432500,0.035000,0.533400> rotate<0,0.000000,0> translate<9.117500,-1.535000,23.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.550000,-1.535000,27.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.575000,-1.535000,27.940000>}
box{<0,0,-0.406400><0.035355,0.035000,0.406400> rotate<0,-44.997030,0> translate<11.550000,-1.535000,27.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,41.755200>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.780000,0.000000,42.105200>}
box{<0,0,-0.533400><0.494975,0.035000,0.533400> rotate<0,-44.997030,0> translate<11.430000,0.000000,41.755200> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<8.915400,0.000000,12.090400>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.065000,0.000000,15.240000>}
box{<0,0,-0.533400><4.454207,0.035000,0.533400> rotate<0,-44.997030,0> translate<8.915400,0.000000,12.090400> }
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<10.160000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.711200 translate<12.065000,0.000000,29.210000>}
box{<0,0,-0.711200><2.694077,0.035000,0.711200> rotate<0,44.997030,0> translate<10.160000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.065000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.065000,0.000000,29.210000>}
box{<0,0,-0.533400><13.970000,0.035000,0.533400> rotate<0,90.000000,0> translate<12.065000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<7.302500,-1.535000,37.782500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.382500,-1.535000,37.782500>}
box{<0,0,-0.533400><5.080000,0.035000,0.533400> rotate<0,0.000000,0> translate<7.302500,-1.535000,37.782500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.550000,-1.535000,17.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.565000,-1.535000,17.915000>}
box{<0,0,-0.533400><1.015000,0.035000,0.533400> rotate<0,0.000000,0> translate<11.550000,-1.535000,17.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.575000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.700000,-1.535000,27.940000>}
box{<0,0,-0.533400><1.125000,0.035000,0.533400> rotate<0,0.000000,0> translate<11.575000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<4.762500,0.000000,34.607500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.700000,0.000000,34.607500>}
box{<0,0,-0.533400><7.937500,0.035000,0.533400> rotate<0,0.000000,0> translate<4.762500,0.000000,34.607500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.700000,0.000000,34.607500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.335000,0.000000,35.242500>}
box{<0,0,-0.533400><0.898026,0.035000,0.533400> rotate<0,-44.997030,0> translate<12.700000,0.000000,34.607500> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.550000,-1.535000,23.915000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<13.755000,-1.535000,23.915000>}
box{<0,0,-0.508000><2.205000,0.035000,0.508000> rotate<0,0.000000,0> translate<11.550000,-1.535000,23.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.350000,0.000000,10.715000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,0.000000,13.335000>}
box{<0,0,-0.533400><3.705240,0.035000,0.533400> rotate<0,-44.997030,0> translate<11.350000,0.000000,10.715000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.565000,-1.535000,17.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,16.510000>}
box{<0,0,-0.533400><1.986970,0.035000,0.533400> rotate<0,44.997030,0> translate<12.565000,-1.535000,17.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,4.130000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,16.510000>}
box{<0,0,-0.533400><12.380000,0.035000,0.533400> rotate<0,90.000000,0> translate<13.970000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<13.755000,-1.535000,23.915000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<13.970000,-1.535000,24.130000>}
box{<0,0,-0.508000><0.304056,0.035000,0.508000> rotate<0,-44.997030,0> translate<13.755000,-1.535000,23.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,0.000000,27.305000>}
box{<0,0,-0.533400><13.970000,0.035000,0.533400> rotate<0,90.000000,0> translate<13.970000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.700000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,29.210000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,-44.997030,0> translate<12.700000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,29.210000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,-90.000000,0> translate<13.970000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,33.020000>}
box{<0,0,-0.533400><3.175000,0.035000,0.533400> rotate<0,-90.000000,0> translate<13.970000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<12.382500,-1.535000,37.782500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,36.195000>}
box{<0,0,-0.533400><2.245064,0.035000,0.533400> rotate<0,44.997030,0> translate<12.382500,-1.535000,37.782500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,4.130000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<14.290000,-1.535000,3.810000>}
box{<0,0,-0.533400><0.452548,0.035000,0.533400> rotate<0,44.997030,0> translate<13.970000,-1.535000,4.130000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<14.605000,0.000000,31.115000>}
box{<0,0,-0.533400><0.898026,0.035000,0.533400> rotate<0,-44.997030,0> translate<13.970000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<15.240000,0.000000,28.575000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,-44.997030,0> translate<13.970000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.550000,-1.535000,21.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<15.565000,-1.535000,21.915000>}
box{<0,0,-0.533400><4.015000,0.035000,0.533400> rotate<0,0.000000,0> translate<11.550000,-1.535000,21.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<15.565000,-1.535000,21.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<15.875000,-1.535000,22.225000>}
box{<0,0,-0.533400><0.438406,0.035000,0.533400> rotate<0,-44.997030,0> translate<15.565000,-1.535000,21.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<15.875000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.510000,0.000000,22.860000>}
box{<0,0,-0.533400><0.898026,0.035000,0.533400> rotate<0,-44.997030,0> translate<15.875000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<13.970000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<16.510000,-1.535000,24.130000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<13.970000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.510000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.510000,-1.535000,26.670000>}
box{<0,0,-0.533400><3.810000,0.035000,0.533400> rotate<0,-90.000000,0> translate<16.510000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.970000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.510000,-1.535000,30.480000>}
box{<0,0,-0.533400><3.592102,0.035000,0.533400> rotate<0,44.997030,0> translate<13.970000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.445000,0.000000,33.115000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.550000,0.000000,33.115000>}
box{<0,0,-0.533400><10.105000,0.035000,0.533400> rotate<0,0.000000,0> translate<6.445000,0.000000,33.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.830000,-1.535000,38.650000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.860000,-1.535000,38.680000>}
box{<0,0,-0.533400><0.042426,0.035000,0.533400> rotate<0,-44.997030,0> translate<16.830000,-1.535000,38.650000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.860000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.860000,-1.535000,38.680000>}
box{<0,0,-0.533400><0.690000,0.035000,0.533400> rotate<0,-90.000000,0> translate<16.860000,-1.535000,38.680000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<6.350000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.860000,-1.535000,39.370000>}
box{<0,0,-0.533400><10.510000,0.035000,0.533400> rotate<0,0.000000,0> translate<6.350000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.860000,-1.535000,42.105200>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.860000,-1.535000,39.370000>}
box{<0,0,-0.533400><2.735200,0.035000,0.533400> rotate<0,-90.000000,0> translate<16.860000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.510000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<17.780000,-1.535000,25.400000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<16.510000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<18.100000,-1.535000,30.650000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<18.100000,-1.535000,27.307500>}
box{<0,0,-0.533400><3.342500,0.035000,0.533400> rotate<0,-90.000000,0> translate<18.100000,-1.535000,27.307500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<18.100000,-1.535000,27.307500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<18.415000,-1.535000,26.987500>}
box{<0,0,-0.533400><0.449027,0.035000,0.533400> rotate<0,45.448139,0> translate<18.100000,-1.535000,27.307500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<17.780000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.050000,-1.535000,25.400000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,0.000000,0> translate<17.780000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.050000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.050000,-1.535000,32.850000>}
box{<0,0,-0.533400><1.440000,0.035000,0.533400> rotate<0,-90.000000,0> translate<19.050000,-1.535000,32.850000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<18.730000,-1.535000,38.650000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.400000,-1.535000,39.320000>}
box{<0,0,-0.533400><0.947523,0.035000,0.533400> rotate<0,-44.997030,0> translate<18.730000,-1.535000,38.650000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.400000,-1.535000,42.105200>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.400000,-1.535000,39.320000>}
box{<0,0,-0.533400><2.785200,0.035000,0.533400> rotate<0,-90.000000,0> translate<19.400000,-1.535000,39.320000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.050000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.000000,-1.535000,26.350000>}
box{<0,0,-0.533400><1.343503,0.035000,0.533400> rotate<0,-44.997030,0> translate<19.050000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.000000,-1.535000,26.350000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.000000,-1.535000,30.650000>}
box{<0,0,-0.533400><4.300000,0.035000,0.533400> rotate<0,90.000000,0> translate<20.000000,-1.535000,30.650000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<19.050000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.002500,-1.535000,35.242500>}
box{<0,0,-0.533400><1.347038,0.035000,0.533400> rotate<0,-44.997030,0> translate<19.050000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<16.510000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,20.320000>}
box{<0,0,-0.508000><5.388154,0.035000,0.508000> rotate<0,44.997030,0> translate<16.510000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,-1.535000,20.320000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,90.000000,0> translate<20.320000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<11.430000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.320000,0.000000,36.830000>}
box{<0,0,-0.533400><8.890000,0.035000,0.533400> rotate<0,0.000000,0> translate<11.430000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.320000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.396200,0.000000,36.906200>}
box{<0,0,-0.533400><0.107763,0.035000,0.533400> rotate<0,-44.997030,0> translate<20.320000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<13.335000,0.000000,35.242500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.637500,0.000000,35.242500>}
box{<0,0,-0.533400><7.302500,0.035000,0.533400> rotate<0,0.000000,0> translate<13.335000,0.000000,35.242500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.637500,0.000000,35.242500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<21.550000,0.000000,34.330000>}
box{<0,0,-0.533400><1.290470,0.035000,0.533400> rotate<0,44.997030,0> translate<20.637500,0.000000,35.242500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<21.550000,0.000000,33.115000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<21.550000,0.000000,34.330000>}
box{<0,0,-0.533400><1.215000,0.035000,0.533400> rotate<0,90.000000,0> translate<21.550000,0.000000,34.330000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.190000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.010000,-1.535000,3.810000>}
box{<0,0,-0.533400><5.820000,0.035000,0.533400> rotate<0,0.000000,0> translate<16.190000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.010000,-1.535000,6.770000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.010000,-1.535000,3.810000>}
box{<0,0,-0.533400><2.960000,0.035000,0.533400> rotate<0,-90.000000,0> translate<22.010000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,-1.535000,15.240000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,90.000000,0> translate<22.860000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,0.000000,20.955000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,90.000000,0> translate<22.860000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.396200,0.000000,36.906200>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.088600,0.000000,36.906200>}
box{<0,0,-0.533400><2.692400,0.035000,0.533400> rotate<0,0.000000,0> translate<20.396200,0.000000,36.906200> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.002500,-1.535000,35.242500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.177500,-1.535000,35.242500>}
box{<0,0,-0.533400><3.175000,0.035000,0.533400> rotate<0,0.000000,0> translate<20.002500,-1.535000,35.242500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<16.510000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.495000,0.000000,22.860000>}
box{<0,0,-0.533400><6.985000,0.035000,0.533400> rotate<0,0.000000,0> translate<16.510000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<15.240000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.495000,0.000000,28.575000>}
box{<0,0,-0.533400><8.255000,0.035000,0.533400> rotate<0,0.000000,0> translate<15.240000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<14.605000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.495000,0.000000,31.115000>}
box{<0,0,-0.533400><8.890000,0.035000,0.533400> rotate<0,0.000000,0> translate<14.605000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,-1.535000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.535000,-1.535000,15.915000>}
box{<0,0,-0.533400><0.954594,0.035000,0.533400> rotate<0,-44.997030,0> translate<22.860000,-1.535000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.710000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.805000,-1.535000,3.715000>}
box{<0,0,-0.533400><0.134350,0.035000,0.533400> rotate<0,44.997030,0> translate<23.710000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,-1.535000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.820000,-1.535000,21.915000>}
box{<0,0,-0.533400><1.357645,0.035000,0.533400> rotate<0,-44.997030,0> translate<22.860000,-1.535000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.177500,-1.535000,35.242500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.130000,-1.535000,34.290000>}
box{<0,0,-0.533400><1.347038,0.035000,0.533400> rotate<0,44.997030,0> translate<23.177500,-1.535000,35.242500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.130000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.130000,-1.535000,34.290000>}
box{<0,0,-0.533400><8.890000,0.035000,0.533400> rotate<0,90.000000,0> translate<24.130000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.130000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.385000,0.000000,25.145000>}
box{<0,0,-0.533400><0.360624,0.035000,0.533400> rotate<0,44.997030,0> translate<24.130000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.447500,-1.535000,12.382500>}
box{<0,0,-0.533400><2.245064,0.035000,0.533400> rotate<0,44.997030,0> translate<22.860000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.092197,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.750000,0.000000,1.270000>}
box{<0,0,-0.533400><14.657803,0.035000,0.533400> rotate<0,0.000000,0> translate<10.092197,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.765000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.765000,0.000000,20.320000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,-90.000000,0> translate<24.765000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.495000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.765000,0.000000,21.590000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<23.495000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<20.320000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.765000,-1.535000,36.830000>}
box{<0,0,-0.533400><4.445000,0.035000,0.533400> rotate<0,0.000000,0> translate<20.320000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<18.415000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,26.987500>}
box{<0,0,-0.533400><6.985000,0.035000,0.533400> rotate<0,0.000000,0> translate<18.415000,0.000000,26.987500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.495000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,33.020000>}
box{<0,0,-0.533400><2.694077,0.035000,0.533400> rotate<0,-44.997030,0> translate<23.495000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,36.906200>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,33.020000>}
box{<0,0,-0.533400><3.886200,0.035000,0.533400> rotate<0,-90.000000,0> translate<25.400000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,43.104000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,36.906200>}
box{<0,0,-0.533400><6.197800,0.035000,0.533400> rotate<0,-90.000000,0> translate<25.400000,0.000000,36.906200> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<10.160000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,-1.535000,44.450000>}
box{<0,0,-0.533400><15.240000,0.035000,0.533400> rotate<0,0.000000,0> translate<10.160000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,43.104000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,44.450000>}
box{<0,0,-0.533400><1.346000,0.035000,0.533400> rotate<0,90.000000,0> translate<25.400000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.765000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.715000,0.000000,19.370000>}
box{<0,0,-0.533400><1.343503,0.035000,0.533400> rotate<0,44.997030,0> translate<24.765000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.035000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.035000,-1.535000,31.750000>}
box{<0,0,-0.533400><3.810000,0.035000,0.533400> rotate<0,-90.000000,0> translate<26.035000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.765000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.035000,-1.535000,35.560000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<24.765000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.010000,-1.535000,6.770000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.352500,-1.535000,11.112500>}
box{<0,0,-0.533400><6.141222,0.035000,0.533400> rotate<0,-44.997030,0> translate<22.010000,-1.535000,6.770000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.495000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,13.915000>}
box{<0,0,-0.533400><0.077782,0.035000,0.533400> rotate<0,44.997030,0> translate<26.495000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.535000,-1.535000,15.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,15.915000>}
box{<0,0,-0.533400><3.015000,0.035000,0.533400> rotate<0,0.000000,0> translate<23.535000,-1.535000,15.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.820000,-1.535000,21.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,21.915000>}
box{<0,0,-0.533400><2.730000,0.035000,0.533400> rotate<0,0.000000,0> translate<23.820000,-1.535000,21.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,25.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,27.915000>}
box{<0,0,-0.533400><2.000000,0.035000,0.533400> rotate<0,90.000000,0> translate<26.550000,-1.535000,27.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,27.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,28.137500>}
box{<0,0,-0.533400><0.222500,0.035000,0.533400> rotate<0,90.000000,0> translate<26.550000,-1.535000,28.137500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,13.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.605000,-1.535000,13.970000>}
box{<0,0,-0.533400><0.077782,0.035000,0.533400> rotate<0,-44.997030,0> translate<26.550000,-1.535000,13.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.035000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.670000,-1.535000,31.115000>}
box{<0,0,-0.533400><0.898026,0.035000,0.533400> rotate<0,44.997030,0> translate<26.035000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.670000,0.000000,45.720000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,-44.997030,0> translate<25.400000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.805000,-1.535000,3.715000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.750000,-1.535000,3.715000>}
box{<0,0,-0.533400><2.945000,0.035000,0.533400> rotate<0,0.000000,0> translate<23.805000,-1.535000,3.715000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.750000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.750000,0.000000,3.715000>}
box{<0,0,-0.533400><3.158801,0.035000,0.533400> rotate<0,-50.713627,0> translate<24.750000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<18.730000,-1.535000,38.650000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.220000,-1.535000,38.650000>}
box{<0,0,-0.533400><8.490000,0.035000,0.533400> rotate<0,0.000000,0> translate<18.730000,-1.535000,38.650000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.670000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.305000,-1.535000,31.115000>}
box{<0,0,-0.533400><0.635000,0.035000,0.533400> rotate<0,0.000000,0> translate<26.670000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,0.000000,26.987500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,29.527500>}
box{<0,0,-0.533400><3.592102,0.035000,0.533400> rotate<0,-44.997030,0> translate<25.400000,0.000000,26.987500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,28.137500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,-1.535000,29.527500>}
box{<0,0,-0.533400><1.965757,0.035000,0.533400> rotate<0,-44.997030,0> translate<26.550000,-1.535000,28.137500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.305000,-1.535000,31.115000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,-1.535000,31.535000>}
box{<0,0,-0.533400><0.761331,0.035000,0.533400> rotate<0,-33.479131,0> translate<27.305000,-1.535000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,-1.535000,29.527500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,-1.535000,31.535000>}
box{<0,0,-0.533400><2.007500,0.035000,0.533400> rotate<0,90.000000,0> translate<27.940000,-1.535000,31.535000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<23.495000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,33.020000>}
box{<0,0,-0.533400><6.286179,0.035000,0.533400> rotate<0,-44.997030,0> translate<23.495000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,34.290000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,90.000000,0> translate<27.940000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.711400,0.000000,36.906200>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,36.677600>}
box{<0,0,-0.533400><0.323289,0.035000,0.533400> rotate<0,44.997030,0> translate<27.711400,0.000000,36.906200> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,36.677600>}
box{<0,0,-0.533400><2.387600,0.035000,0.533400> rotate<0,90.000000,0> translate<27.940000,0.000000,36.677600> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.711400,0.000000,36.906200>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,37.134800>}
box{<0,0,-0.533400><0.323289,0.035000,0.533400> rotate<0,-44.997030,0> translate<27.711400,0.000000,36.906200> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,37.134800>}
box{<0,0,-0.533400><2.235200,0.035000,0.533400> rotate<0,-90.000000,0> translate<27.940000,0.000000,37.134800> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.220000,-1.535000,38.650000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,-1.535000,39.370000>}
box{<0,0,-0.533400><1.018234,0.035000,0.533400> rotate<0,-44.997030,0> translate<27.220000,-1.535000,38.650000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.575000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.575000,0.000000,19.050000>}
box{<0,0,-0.533400><3.810000,0.035000,0.533400> rotate<0,90.000000,0> translate<28.575000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.550000,-1.535000,25.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.695000,-1.535000,25.915000>}
box{<0,0,-0.533400><2.145000,0.035000,0.533400> rotate<0,0.000000,0> translate<26.550000,-1.535000,25.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.575000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.890000,0.000000,14.925000>}
box{<0,0,-0.533400><0.445477,0.035000,0.533400> rotate<0,44.997030,0> translate<28.575000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.575000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.895000,0.000000,19.370000>}
box{<0,0,-0.533400><0.452548,0.035000,0.533400> rotate<0,-44.997030,0> translate<28.575000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.695000,-1.535000,25.915000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<29.210000,-1.535000,25.400000>}
box{<0,0,-0.533400><0.728320,0.035000,0.533400> rotate<0,44.997030,0> translate<28.695000,-1.535000,25.915000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<29.210000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<29.210000,-1.535000,25.400000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,90.000000,0> translate<29.210000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.400000,-1.535000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<29.210000,-1.535000,40.640000>}
box{<0,0,-0.533400><5.388154,0.035000,0.533400> rotate<0,44.997030,0> translate<25.400000,-1.535000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.050000,-1.535000,7.780000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,-1.535000,6.350000>}
box{<0,0,-0.508000><2.022325,0.035000,0.508000> rotate<0,44.997030,0> translate<29.050000,-1.535000,7.780000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<20.320000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,0.000000,7.620000>}
box{<0,0,-0.508000><14.368410,0.035000,0.508000> rotate<0,44.997030,0> translate<20.320000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,0.000000,6.350000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<30.480000,0.000000,7.620000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,90.000000,0> translate<30.480000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.605000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,-1.535000,13.970000>}
box{<0,0,-0.533400><3.875000,0.035000,0.533400> rotate<0,0.000000,0> translate<26.605000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.890000,0.000000,14.925000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,14.925000>}
box{<0,0,-0.533400><1.590000,0.035000,0.533400> rotate<0,0.000000,0> translate<28.890000,0.000000,14.925000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<25.715000,0.000000,19.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,19.370000>}
box{<0,0,-0.533400><4.765000,0.035000,0.533400> rotate<0,0.000000,0> translate<25.715000,0.000000,19.370000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<28.895000,0.000000,19.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,19.370000>}
box{<0,0,-0.533400><1.585000,0.035000,0.533400> rotate<0,0.000000,0> translate<28.895000,0.000000,19.370000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<29.210000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,21.590000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<29.210000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,21.590000>}
box{<0,0,-0.533400><0.320000,0.035000,0.533400> rotate<0,90.000000,0> translate<30.480000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,-1.535000,33.235000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.872000,-1.535000,33.235000>}
box{<0,0,-0.533400><2.932000,0.035000,0.533400> rotate<0,0.000000,0> translate<27.940000,-1.535000,33.235000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<27.940000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.115000,0.000000,34.290000>}
box{<0,0,-0.533400><3.175000,0.035000,0.533400> rotate<0,0.000000,0> translate<27.940000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.115000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.115000,0.000000,34.290000>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,-90.000000,0> translate<31.115000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.143000,-1.535000,31.606000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.143000,-1.535000,27.712000>}
box{<0,0,-0.533400><3.894000,0.035000,0.533400> rotate<0,-90.000000,0> translate<31.143000,-1.535000,27.712000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.872000,-1.535000,33.235000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.143000,-1.535000,33.506000>}
box{<0,0,-0.533400><0.383252,0.035000,0.533400> rotate<0,-44.997030,0> translate<30.872000,-1.535000,33.235000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.115000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.143000,-1.535000,34.897000>}
box{<0,0,-0.533400><0.663591,0.035000,0.533400> rotate<0,87.575926,0> translate<31.115000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.143000,-1.535000,33.506000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.143000,-1.535000,34.897000>}
box{<0,0,-0.533400><1.391000,0.035000,0.533400> rotate<0,90.000000,0> translate<31.143000,-1.535000,34.897000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.385000,0.000000,25.145000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.170000,0.000000,25.145000>}
box{<0,0,-0.533400><6.785000,0.035000,0.533400> rotate<0,0.000000,0> translate<24.385000,0.000000,25.145000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.143000,-1.535000,27.712000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.170000,-1.535000,27.685000>}
box{<0,0,-0.533400><0.038184,0.035000,0.533400> rotate<0,44.997030,0> translate<31.143000,-1.535000,27.712000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.170000,0.000000,37.845000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.425000,0.000000,38.100000>}
box{<0,0,-0.406400><0.360624,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.170000,0.000000,37.845000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<24.447500,-1.535000,12.382500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.432500,-1.535000,12.382500>}
box{<0,0,-0.533400><6.985000,0.035000,0.533400> rotate<0,0.000000,0> translate<24.447500,-1.535000,12.382500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<29.210000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.750000,-1.535000,40.640000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,0.000000,0> translate<29.210000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<9.525003,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.750000,-1.535000,45.720000>}
box{<0,0,-0.533400><22.224997,0.035000,0.533400> rotate<0,0.000000,0> translate<9.525003,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.670000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.750000,0.000000,45.720000>}
box{<0,0,-0.533400><5.080000,0.035000,0.533400> rotate<0,0.000000,0> translate<26.670000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.170000,0.000000,25.145000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<32.185000,0.000000,24.130000>}
box{<0,0,-0.533400><1.435427,0.035000,0.533400> rotate<0,44.997030,0> translate<31.170000,0.000000,25.145000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.352500,-1.535000,11.112500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<32.702500,-1.535000,11.112500>}
box{<0,0,-0.533400><6.350000,0.035000,0.533400> rotate<0,0.000000,0> translate<26.352500,-1.535000,11.112500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,12.382500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,14.925000>}
box{<0,0,-0.533400><2.542500,0.035000,0.533400> rotate<0,90.000000,0> translate<33.020000,0.000000,14.925000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,-1.535000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,-1.535000,16.510000>}
box{<0,0,-0.533400><3.592102,0.035000,0.533400> rotate<0,-44.997030,0> translate<30.480000,-1.535000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,-1.535000,16.510000>}
box{<0,0,-0.533400><22.860000,0.035000,0.533400> rotate<0,-90.000000,0> translate<33.020000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,16.825000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,16.825000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,0.000000,0> translate<30.480000,0.000000,16.825000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,16.825000>}
box{<0,0,-0.533400><0.955000,0.035000,0.533400> rotate<0,-90.000000,0> translate<33.020000,0.000000,16.825000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,19.370000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,17.780000>}
box{<0,0,-0.533400><1.590000,0.035000,0.533400> rotate<0,-90.000000,0> translate<33.020000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<30.480000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,21.270000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,0.000000,0> translate<30.480000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.115000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,34.290000>}
box{<0,0,-0.533400><1.905000,0.035000,0.533400> rotate<0,0.000000,0> translate<31.115000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.750000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,-1.535000,39.370000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<31.750000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.750000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,44.450000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<31.750000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<22.860000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.207097,0.000000,8.442097>}
box{<0,0,-0.533400><14.370846,0.035000,0.533400> rotate<0,43.942115,0> translate<22.860000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,12.382500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,11.112500>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<33.020000,0.000000,12.382500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<32.185000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,24.130000>}
box{<0,0,-0.533400><2.105000,0.035000,0.533400> rotate<0,0.000000,0> translate<32.185000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,33.020000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<33.020000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,26.890000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,33.020000>}
box{<0,0,-0.533400><6.130000,0.035000,0.533400> rotate<0,90.000000,0> translate<34.290000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<26.750000,0.000000,3.715000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.444000,0.000000,3.715000>}
box{<0,0,-0.533400><7.694000,0.035000,0.533400> rotate<0,0.000000,0> translate<26.750000,0.000000,3.715000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.170000,0.000000,42.925000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.545000,0.000000,42.925000>}
box{<0,0,-0.533400><3.375000,0.035000,0.533400> rotate<0,0.000000,0> translate<31.170000,0.000000,42.925000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.444000,0.000000,3.715000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.574900,0.000000,3.845900>}
box{<0,0,-0.533400><0.185121,0.035000,0.533400> rotate<0,-44.997030,0> translate<34.444000,0.000000,3.715000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.450000,-1.535000,3.845900>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.574900,-1.535000,3.845900>}
box{<0,0,-0.508000><0.124900,0.035000,0.508000> rotate<0,0.000000,0> translate<34.450000,-1.535000,3.845900> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.432500,-1.535000,12.382500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.607500,-1.535000,15.557500>}
box{<0,0,-0.533400><4.490128,0.035000,0.533400> rotate<0,-44.997030,0> translate<31.432500,-1.535000,12.382500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.607500,-1.535000,42.862500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.607500,-1.535000,15.557500>}
box{<0,0,-0.533400><27.305000,0.035000,0.533400> rotate<0,-90.000000,0> translate<34.607500,-1.535000,15.557500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.750000,-1.535000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.607500,-1.535000,42.862500>}
box{<0,0,-0.533400><4.041115,0.035000,0.533400> rotate<0,44.997030,0> translate<31.750000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,14.925000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.610000,0.000000,14.925000>}
box{<0,0,-0.533400><1.590000,0.035000,0.533400> rotate<0,0.000000,0> translate<33.020000,0.000000,14.925000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.610000,0.000000,21.270000>}
box{<0,0,-0.533400><1.590000,0.035000,0.533400> rotate<0,0.000000,0> translate<33.020000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<32.702500,-1.535000,11.112500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.950400,-1.535000,13.360400>}
box{<0,0,-0.533400><3.179011,0.035000,0.533400> rotate<0,-44.997030,0> translate<32.702500,-1.535000,11.112500> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,11.112500>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,8.572500>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,-90.000000,0> translate<35.560000,-1.535000,8.572500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,11.112500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,11.112500>}
box{<0,0,-0.533400><1.270000,0.035000,0.533400> rotate<0,0.000000,0> translate<34.290000,0.000000,11.112500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.610000,0.000000,14.925000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,15.875000>}
box{<0,0,-0.533400><1.343503,0.035000,0.533400> rotate<0,-44.997030,0> translate<34.610000,0.000000,14.925000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.610000,0.000000,21.270000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,20.320000>}
box{<0,0,-0.533400><1.343503,0.035000,0.533400> rotate<0,44.997030,0> translate<34.610000,0.000000,21.270000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,22.860000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<34.290000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,44.450000>}
box{<0,0,-0.533400><2.540000,0.035000,0.533400> rotate<0,0.000000,0> translate<33.020000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.290000,0.000000,26.890000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.780000,0.000000,25.400000>}
box{<0,0,-0.533400><2.107178,0.035000,0.533400> rotate<0,44.997030,0> translate<34.290000,0.000000,26.890000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.880000,0.000000,22.860000>}
box{<0,0,-0.533400><0.320000,0.035000,0.533400> rotate<0,0.000000,0> translate<35.560000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<31.425000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<36.830000,0.000000,38.100000>}
box{<0,0,-0.533400><5.405000,0.035000,0.533400> rotate<0,0.000000,0> translate<31.425000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.020000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<37.505400,0.000000,17.780000>}
box{<0,0,-0.533400><4.485400,0.035000,0.533400> rotate<0,0.000000,0> translate<33.020000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<37.780000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<37.880000,0.000000,22.960000>}
box{<0,0,-0.533400><0.141421,0.035000,0.533400> rotate<0,-44.997030,0> translate<37.780000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<37.880000,0.000000,22.960000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<37.880000,0.000000,25.400000>}
box{<0,0,-0.533400><2.440000,0.035000,0.533400> rotate<0,90.000000,0> translate<37.880000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.950400,-1.535000,13.360400>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,-1.535000,13.360400>}
box{<0,0,-0.533400><3.149600,0.035000,0.533400> rotate<0,0.000000,0> translate<34.950400,-1.535000,13.360400> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<37.505400,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,0.000000,18.389600>}
box{<0,0,-0.533400><0.851564,0.035000,0.533400> rotate<0,-45.710645,0> translate<37.505400,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<36.830000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,0.000000,36.830000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<36.830000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,0.000000,34.899600>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,0.000000,36.830000>}
box{<0,0,-0.533400><1.930400,0.035000,0.533400> rotate<0,90.000000,0> translate<38.100000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,0.000000,41.910000>}
box{<0,0,-0.533400><3.592102,0.035000,0.533400> rotate<0,44.997030,0> translate<35.560000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<33.207097,0.000000,8.442097>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<39.171097,0.000000,8.442097>}
box{<0,0,-0.533400><5.964000,0.035000,0.533400> rotate<0,0.000000,0> translate<33.207097,0.000000,8.442097> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.005000,0.000000,15.875000>}
box{<0,0,-0.533400><4.445000,0.035000,0.533400> rotate<0,0.000000,0> translate<35.560000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<35.560000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.005000,0.000000,20.320000>}
box{<0,0,-0.533400><4.445000,0.035000,0.533400> rotate<0,0.000000,0> translate<35.560000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,-1.535000,13.360400>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.030400,-1.535000,13.360400>}
box{<0,0,-0.533400><1.930400,0.035000,0.533400> rotate<0,0.000000,0> translate<38.100000,-1.535000,13.360400> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,0.000000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.030400,0.000000,29.870400>}
box{<0,0,-0.533400><1.930400,0.035000,0.533400> rotate<0,0.000000,0> translate<38.100000,0.000000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.030400,-1.535000,13.360400>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.957500,-1.535000,14.287500>}
box{<0,0,-0.533400><1.311117,0.035000,0.533400> rotate<0,-44.997030,0> translate<40.030400,-1.535000,13.360400> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<38.100000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.957500,-1.535000,39.052500>}
box{<0,0,-0.533400><4.041115,0.035000,0.533400> rotate<0,44.997030,0> translate<38.100000,-1.535000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.957500,-1.535000,14.287500>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.957500,-1.535000,39.052500>}
box{<0,0,-0.533400><24.765000,0.035000,0.533400> rotate<0,90.000000,0> translate<40.957500,-1.535000,39.052500> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.005000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,17.145000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,-44.997030,0> translate<40.005000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.005000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,19.050000>}
box{<0,0,-0.533400><1.796051,0.035000,0.533400> rotate<0,44.997030,0> translate<40.005000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,19.050000>}
box{<0,0,-0.533400><1.905000,0.035000,0.533400> rotate<0,90.000000,0> translate<41.275000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<40.030400,0.000000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,31.115000>}
box{<0,0,-0.533400><1.760130,0.035000,0.533400> rotate<0,-44.997030,0> translate<40.030400,0.000000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,31.115000>}
box{<0,0,-0.533400><5.080000,0.035000,0.533400> rotate<0,-90.000000,0> translate<41.275000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<34.545000,0.000000,42.925000>}
cylinder{<0,0,0><0,0.035000,0>0.533400 translate<41.275000,0.000000,36.195000>}
box{<0,0,-0.533400><9.517657,0.035000,0.533400> rotate<0,44.997030,0> translate<34.545000,0.000000,42.925000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polignos
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.015997,0.000000,32.754503>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.015997,0.000000,35.560009>}
box{<0,0,-0.406400><2.805506,0.035000,0.406400> rotate<0,90.000000,0> translate<1.015997,0.000000,35.560009> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.015997,0.000000,32.754503>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.226481,0.000000,33.262663>}
box{<0,0,-0.406400><0.550027,0.035000,0.406400> rotate<0,-67.495750,0> translate<1.015997,0.000000,32.754503> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.015997,0.000000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.288619,0.000000,33.324800>}
box{<0,0,-0.406400><0.272622,0.035000,0.406400> rotate<0,0.000000,0> translate<1.015997,0.000000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.015997,0.000000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.101419,0.000000,34.137600>}
box{<0,0,-0.406400><1.085422,0.035000,0.406400> rotate<0,0.000000,0> translate<1.015997,0.000000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.015997,0.000000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.914219,0.000000,34.950400>}
box{<0,0,-0.406400><1.898222,0.035000,0.406400> rotate<0,0.000000,0> translate<1.015997,0.000000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.015997,0.000000,35.560009>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.048100,0.000000,36.377072>}
box{<0,0,-0.406400><0.817693,0.035000,0.406400> rotate<0,-87.744163,0> translate<1.015997,0.000000,35.560009> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.023978,0.000000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.727019,0.000000,35.763200>}
box{<0,0,-0.406400><2.703041,0.035000,0.406400> rotate<0,0.000000,0> translate<1.023978,0.000000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.043281,-1.535000,36.254463>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.048100,-1.535000,36.377072>}
box{<0,0,-0.406400><0.122704,0.035000,0.406400> rotate<0,-87.743549,0> translate<1.043281,-1.535000,36.254463> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.043281,-1.535000,36.254463>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.897678,-1.535000,38.108856>}
box{<0,0,-0.406400><2.622511,0.035000,0.406400> rotate<0,-44.996982,0> translate<1.043281,-1.535000,36.254463> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.048100,0.000000,36.377072>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.303737,0.000000,37.991100>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,-80.994635,0> translate<1.048100,0.000000,36.377072> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.048100,-1.535000,36.377072>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.303737,-1.535000,37.991100>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,-80.994635,0> translate<1.048100,-1.535000,36.377072> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.079606,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.364822,-1.535000,36.576000>}
box{<0,0,-0.406400><0.285216,0.035000,0.406400> rotate<0,0.000000,0> translate<1.079606,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.079606,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.505581,0.000000,36.576000>}
box{<0,0,-0.406400><11.425975,0.035000,0.406400> rotate<0,0.000000,0> translate<1.079606,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.208341,-1.535000,37.388800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.177622,-1.535000,37.388800>}
box{<0,0,-0.406400><0.969281,0.035000,0.406400> rotate<0,0.000000,0> translate<1.208341,-1.535000,37.388800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.208341,0.000000,37.388800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,37.388800>}
box{<0,0,-0.406400><20.610259,0.035000,0.406400> rotate<0,0.000000,0> translate<1.208341,0.000000,37.388800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.226481,0.000000,33.262663>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.662334,0.000000,33.698516>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,-44.997030,0> translate<1.226481,0.000000,33.262663> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.303737,0.000000,37.991100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.808716,0.000000,39.545266>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,-71.995278,0> translate<1.303737,0.000000,37.991100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.303737,-1.535000,37.991100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.808716,-1.535000,39.545266>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,-71.995278,0> translate<1.303737,-1.535000,37.991100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.372131,0.000000,38.201600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.657775,0.000000,38.201600>}
box{<0,0,-0.406400><1.285644,0.035000,0.406400> rotate<0,0.000000,0> translate<1.372131,0.000000,38.201600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.372131,-1.535000,38.201600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.657775,-1.535000,38.201600>}
box{<0,0,-0.406400><1.285644,0.035000,0.406400> rotate<0,0.000000,0> translate<1.372131,-1.535000,38.201600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.636225,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.939288,0.000000,39.014400>}
box{<0,0,-0.406400><0.303063,0.035000,0.406400> rotate<0,0.000000,0> translate<1.636225,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.636225,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.939288,-1.535000,39.014400>}
box{<0,0,-0.406400><0.303063,0.035000,0.406400> rotate<0,0.000000,0> translate<1.636225,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.662334,0.000000,33.698516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.448981,0.000000,35.485163>}
box{<0,0,-0.406400><2.526700,0.035000,0.406400> rotate<0,-44.997030,0> translate<1.662334,0.000000,33.698516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.808716,0.000000,39.545266>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.874897,0.000000,39.675156>}
box{<0,0,-0.406400><0.145779,0.035000,0.406400> rotate<0,-62.996308,0> translate<1.808716,0.000000,39.545266> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.808716,-1.535000,39.545266>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.874900,-1.535000,39.675159>}
box{<0,0,-0.406400><0.145783,0.035000,0.406400> rotate<0,-62.995771,0> translate<1.808716,-1.535000,39.545266> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,0.000000,39.367000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.896575,0.000000,39.145866>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,80.994463,0> translate<1.861550,0.000000,39.367000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,-1.535000,39.367000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.896575,-1.535000,39.145866>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,80.994463,0> translate<1.861550,-1.535000,39.367000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,0.000000,39.590891>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,0.000000,39.367000>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,-90.000000,0> translate<1.861550,0.000000,39.367000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,-1.535000,39.590891>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,-1.535000,39.367000>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,-90.000000,0> translate<1.861550,-1.535000,39.367000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,0.000000,39.590891>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.874897,0.000000,39.675156>}
box{<0,0,-0.406400><0.085316,0.035000,0.406400> rotate<0,-80.994315,0> translate<1.861550,0.000000,39.590891> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.861550,-1.535000,39.590891>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.874900,-1.535000,39.675159>}
box{<0,0,-0.406400><0.085320,0.035000,0.406400> rotate<0,-80.992571,0> translate<1.861550,-1.535000,39.590891> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.896575,0.000000,39.145866>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.965759,0.000000,38.932934>}
box{<0,0,-0.406400><0.223889,0.035000,0.406400> rotate<0,71.995536,0> translate<1.896575,0.000000,39.145866> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.896575,-1.535000,39.145866>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.965759,-1.535000,38.932934>}
box{<0,0,-0.406400><0.223889,0.035000,0.406400> rotate<0,71.995536,0> translate<1.896575,-1.535000,39.145866> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.965759,0.000000,38.932934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.067403,0.000000,38.733444>}
box{<0,0,-0.406400><0.223893,0.035000,0.406400> rotate<0,62.996253,0> translate<1.965759,0.000000,38.932934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<1.965759,-1.535000,38.932934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.067403,-1.535000,38.733444>}
box{<0,0,-0.406400><0.223893,0.035000,0.406400> rotate<0,62.996253,0> translate<1.965759,-1.535000,38.932934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.067403,0.000000,38.733444>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.199003,0.000000,38.552316>}
box{<0,0,-0.406400><0.223888,0.035000,0.406400> rotate<0,53.995874,0> translate<2.067403,0.000000,38.733444> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.067403,-1.535000,38.733444>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.199003,-1.535000,38.552316>}
box{<0,0,-0.406400><0.223888,0.035000,0.406400> rotate<0,53.995874,0> translate<2.067403,-1.535000,38.733444> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.199003,0.000000,38.552316>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278147,0.000000,38.473169>}
box{<0,0,-0.406400><0.111928,0.035000,0.406400> rotate<0,44.998161,0> translate<2.199003,0.000000,38.552316> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.199003,-1.535000,38.552316>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278147,-1.535000,38.473169>}
box{<0,0,-0.406400><0.111928,0.035000,0.406400> rotate<0,44.998161,0> translate<2.199003,-1.535000,38.552316> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278147,0.000000,38.473169>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283916,0.000000,39.478934>}
box{<0,0,-0.406400><1.422370,0.035000,0.406400> rotate<0,-44.996941,0> translate<2.278147,0.000000,38.473169> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278147,-1.535000,38.473169>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283916,-1.535000,39.478934>}
box{<0,0,-0.406400><1.422370,0.035000,0.406400> rotate<0,-44.996941,0> translate<2.278147,-1.535000,38.473169> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278172,0.000000,38.473144>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.357319,0.000000,38.394000>}
box{<0,0,-0.406400><0.111928,0.035000,0.406400> rotate<0,44.995899,0> translate<2.278172,0.000000,38.473144> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278172,-1.535000,38.473144>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.357319,-1.535000,38.394000>}
box{<0,0,-0.406400><0.111928,0.035000,0.406400> rotate<0,44.995899,0> translate<2.278172,-1.535000,38.473144> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278172,0.000000,38.473144>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283937,0.000000,39.478912>}
box{<0,0,-0.406400><1.422370,0.035000,0.406400> rotate<0,-44.997119,0> translate<2.278172,0.000000,38.473144> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.278172,-1.535000,38.473144>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283937,-1.535000,39.478912>}
box{<0,0,-0.406400><1.422370,0.035000,0.406400> rotate<0,-44.997119,0> translate<2.278172,-1.535000,38.473144> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.357319,0.000000,38.394000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.538447,0.000000,38.262400>}
box{<0,0,-0.406400><0.223888,0.035000,0.406400> rotate<0,35.998186,0> translate<2.357319,0.000000,38.394000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.357319,-1.535000,38.394000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.538447,-1.535000,38.262400>}
box{<0,0,-0.406400><0.223888,0.035000,0.406400> rotate<0,35.998186,0> translate<2.357319,-1.535000,38.394000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.496325,0.000000,6.095222>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.550603,0.000000,5.988697>}
box{<0,0,-0.406400><0.119556,0.035000,0.406400> rotate<0,62.995447,0> translate<2.496325,0.000000,6.095222> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.496325,-1.535000,6.095222>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.550603,-1.535000,5.988697>}
box{<0,0,-0.406400><0.119556,0.035000,0.406400> rotate<0,62.995447,0> translate<2.496325,-1.535000,6.095222> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.496325,0.000000,6.095222>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.931184,0.000000,5.915097>}
box{<0,0,-0.406400><0.470689,0.035000,0.406400> rotate<0,22.498554,0> translate<2.496325,0.000000,6.095222> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.496325,-1.535000,6.095222>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.931184,-1.535000,5.915097>}
box{<0,0,-0.406400><0.470689,0.035000,0.406400> rotate<0,22.498554,0> translate<2.496325,-1.535000,6.095222> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.538447,0.000000,38.262400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.737938,0.000000,38.160756>}
box{<0,0,-0.406400><0.223893,0.035000,0.406400> rotate<0,26.997808,0> translate<2.538447,0.000000,38.262400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.538447,-1.535000,38.262400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.737938,-1.535000,38.160756>}
box{<0,0,-0.406400><0.223893,0.035000,0.406400> rotate<0,26.997808,0> translate<2.538447,-1.535000,38.262400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.550603,0.000000,5.988697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.511131,0.000000,4.666647>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,53.996363,0> translate<2.550603,0.000000,5.988697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.550603,-1.535000,5.988697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.511131,-1.535000,4.666647>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,53.996363,0> translate<2.550603,-1.535000,5.988697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.737938,-1.535000,38.160756>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.897678,-1.535000,38.108856>}
box{<0,0,-0.406400><0.167960,0.035000,0.406400> rotate<0,17.997879,0> translate<2.737938,-1.535000,38.160756> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.737938,0.000000,38.160756>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.950869,0.000000,38.091572>}
box{<0,0,-0.406400><0.223889,0.035000,0.406400> rotate<0,17.998524,0> translate<2.737938,0.000000,38.160756> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.767912,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,5.689600>}
box{<0,0,-0.406400><7.032688,0.035000,0.406400> rotate<0,0.000000,0> translate<2.767912,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.767912,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,5.689600>}
box{<0,0,-0.406400><7.266088,0.035000,0.406400> rotate<0,0.000000,0> translate<2.767912,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.819378,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.819428,0.000000,39.014400>}
box{<0,0,-0.406400><0.000050,0.035000,0.406400> rotate<0,0.000000,0> translate<2.819378,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.819378,-1.535000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.819428,-1.535000,39.014400>}
box{<0,0,-0.406400><0.000050,0.035000,0.406400> rotate<0,0.000000,0> translate<2.819378,-1.535000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.931184,0.000000,5.915097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.840613,0.000000,5.915097>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,0.000000,0> translate<2.931184,0.000000,5.915097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.931184,-1.535000,5.915097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.840613,-1.535000,5.915097>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,0.000000,0> translate<2.931184,-1.535000,5.915097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<2.950869,0.000000,38.091572>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.172003,0.000000,38.056547>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,8.999597,0> translate<2.950869,0.000000,38.091572> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.172003,0.000000,38.056547>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.395894,0.000000,38.056547>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,0.000000,0> translate<3.172003,0.000000,38.056547> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283916,0.000000,39.478934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283937,0.000000,39.478912>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,44.997030,0> translate<3.283916,0.000000,39.478934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283916,-1.535000,39.478934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283937,-1.535000,39.478912>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,44.997030,0> translate<3.283916,-1.535000,39.478934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283956,0.000000,39.478909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283981,0.000000,39.478934>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,-44.997030,0> translate<3.283956,0.000000,39.478909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283956,0.000000,39.478909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.289722,0.000000,38.473147>}
box{<0,0,-0.406400><1.422365,0.035000,0.406400> rotate<0,44.996941,0> translate<3.283956,0.000000,39.478909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.283981,0.000000,39.478934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.289747,0.000000,38.473169>}
box{<0,0,-0.406400><1.422367,0.035000,0.406400> rotate<0,44.997030,0> translate<3.283981,0.000000,39.478934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.358447,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.524847,0.000000,4.876800>}
box{<0,0,-0.406400><3.166400,0.035000,0.406400> rotate<0,0.000000,0> translate<3.358447,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.358447,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.524847,-1.535000,4.876800>}
box{<0,0,-0.406400><3.166400,0.035000,0.406400> rotate<0,0.000000,0> translate<3.358447,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.395894,0.000000,38.056547>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.617028,0.000000,38.091572>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,-8.999597,0> translate<3.395894,0.000000,38.056547> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.448981,0.000000,35.485163>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.884834,0.000000,35.921016>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,-44.997030,0> translate<3.448981,0.000000,35.485163> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.511131,0.000000,4.666647>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.666647,0.000000,3.511131>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,44.997030,0> translate<3.511131,0.000000,4.666647> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.511131,-1.535000,4.666647>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.666647,-1.535000,3.511131>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,44.997030,0> translate<3.511131,-1.535000,4.666647> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.617028,0.000000,38.091572>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.829959,0.000000,38.160756>}
box{<0,0,-0.406400><0.223889,0.035000,0.406400> rotate<0,-17.998524,0> translate<3.617028,0.000000,38.091572> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.748469,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.748516,0.000000,39.014400>}
box{<0,0,-0.406400><0.000047,0.035000,0.406400> rotate<0,0.000000,0> translate<3.748469,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.829959,0.000000,38.160756>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.029450,0.000000,38.262400>}
box{<0,0,-0.406400><0.223893,0.035000,0.406400> rotate<0,-26.997808,0> translate<3.829959,0.000000,38.160756> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.840613,0.000000,5.915097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.680813,0.000000,6.263119>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-22.498494,0> translate<3.840613,0.000000,5.915097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.840613,-1.535000,5.915097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.680813,-1.535000,6.263119>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-22.498494,0> translate<3.840613,-1.535000,5.915097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.884834,0.000000,35.921016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.454303,0.000000,36.156897>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-22.498478,0> translate<3.884834,0.000000,35.921016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<3.910119,0.000000,38.201600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.841028,0.000000,38.201600>}
box{<0,0,-0.406400><17.930909,0.035000,0.406400> rotate<0,0.000000,0> translate<3.910119,0.000000,38.201600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.029450,0.000000,38.262400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.210578,0.000000,38.394000>}
box{<0,0,-0.406400><0.223888,0.035000,0.406400> rotate<0,-35.998186,0> translate<4.029450,0.000000,38.262400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.089397,-1.535000,30.276166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.089397,-1.535000,32.378216>}
box{<0,0,-0.406400><2.102050,0.035000,0.406400> rotate<0,90.000000,0> translate<4.089397,-1.535000,32.378216> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.089397,-1.535000,30.276166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.152238,-1.535000,30.302197>}
box{<0,0,-0.406400><0.068019,0.035000,0.406400> rotate<0,-22.499924,0> translate<4.089397,-1.535000,30.276166> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.089397,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.283200,-1.535000,30.886400>}
box{<0,0,-0.406400><1.193803,0.035000,0.406400> rotate<0,0.000000,0> translate<4.089397,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.089397,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.387062,-1.535000,31.699200>}
box{<0,0,-0.406400><1.297666,0.035000,0.406400> rotate<0,0.000000,0> translate<4.089397,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.089397,-1.535000,32.378216>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.944281,-1.535000,36.233100>}
box{<0,0,-0.406400><5.451630,0.035000,0.406400> rotate<0,-44.997030,0> translate<4.089397,-1.535000,32.378216> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.113778,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.106616,0.000000,4.064000>}
box{<0,0,-0.406400><1.992837,0.035000,0.406400> rotate<0,0.000000,0> translate<4.113778,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.113778,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.106616,-1.535000,4.064000>}
box{<0,0,-0.406400><1.992837,0.035000,0.406400> rotate<0,0.000000,0> translate<4.113778,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.152238,-1.535000,30.302197>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.481753,-1.535000,30.302197>}
box{<0,0,-0.406400><1.329516,0.035000,0.406400> rotate<0,0.000000,0> translate<4.152238,-1.535000,30.302197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.210578,0.000000,38.394000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.289722,0.000000,38.473147>}
box{<0,0,-0.406400><0.111928,0.035000,0.406400> rotate<0,-44.998161,0> translate<4.210578,0.000000,38.394000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.223181,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.985813,-1.535000,32.512000>}
box{<0,0,-0.406400><1.762631,0.035000,0.406400> rotate<0,0.000000,0> translate<4.223181,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.289747,0.000000,38.473169>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.368894,0.000000,38.552316>}
box{<0,0,-0.406400><0.111931,0.035000,0.406400> rotate<0,-44.997030,0> translate<4.289747,0.000000,38.473169> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.368894,0.000000,38.552316>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.500494,0.000000,38.733444>}
box{<0,0,-0.406400><0.223888,0.035000,0.406400> rotate<0,-53.995874,0> translate<4.368894,0.000000,38.552316> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.454303,0.000000,36.156897>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.058216,0.000000,36.156897>}
box{<0,0,-0.406400><7.603913,0.035000,0.406400> rotate<0,0.000000,0> translate<4.454303,0.000000,36.156897> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.500494,0.000000,38.733444>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.602138,0.000000,38.932934>}
box{<0,0,-0.406400><0.223893,0.035000,0.406400> rotate<0,-62.996253,0> translate<4.500494,0.000000,38.733444> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.602138,0.000000,38.932934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.671322,0.000000,39.145866>}
box{<0,0,-0.406400><0.223889,0.035000,0.406400> rotate<0,-71.995536,0> translate<4.602138,0.000000,38.932934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.628606,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,39.014400>}
box{<0,0,-0.406400><19.221994,0.035000,0.406400> rotate<0,0.000000,0> translate<4.628606,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.666647,0.000000,3.511131>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.988697,0.000000,2.550603>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,35.997697,0> translate<4.666647,0.000000,3.511131> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.666647,-1.535000,3.511131>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.988697,-1.535000,2.550603>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,35.997697,0> translate<4.666647,-1.535000,3.511131> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.671322,0.000000,39.145866>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.706347,0.000000,39.367000>}
box{<0,0,-0.406400><0.223891,0.035000,0.406400> rotate<0,-80.994463,0> translate<4.671322,0.000000,39.145866> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.680813,0.000000,6.263119>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,0.000000,6.906181>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,-44.997030,0> translate<4.680813,0.000000,6.263119> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.680813,-1.535000,6.263119>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,-1.535000,6.906181>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,-44.997030,0> translate<4.680813,-1.535000,6.263119> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.706347,0.000000,39.367000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.706347,0.000000,39.505281>}
box{<0,0,-0.406400><0.138281,0.035000,0.406400> rotate<0,90.000000,0> translate<4.706347,0.000000,39.505281> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.706347,0.000000,39.505281>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.726331,0.000000,39.497000>}
box{<0,0,-0.406400><0.021632,0.035000,0.406400> rotate<0,22.506959,0> translate<4.706347,0.000000,39.505281> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.726331,0.000000,39.497000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.433666,0.000000,39.497000>}
box{<0,0,-0.406400><0.707334,0.035000,0.406400> rotate<0,0.000000,0> translate<4.726331,0.000000,39.497000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.736081,0.000000,10.083800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,0.000000,9.496009>}
box{<0,0,-0.406400><0.831264,0.035000,0.406400> rotate<0,44.996878,0> translate<4.736081,0.000000,10.083800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.736081,-1.535000,10.083800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,-1.535000,9.496009>}
box{<0,0,-0.406400><0.831264,0.035000,0.406400> rotate<0,44.996878,0> translate<4.736081,-1.535000,10.083800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.736081,0.000000,10.083800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.469737,0.000000,10.083800>}
box{<0,0,-0.406400><1.733656,0.035000,0.406400> rotate<0,0.000000,0> translate<4.736081,0.000000,10.083800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.736081,-1.535000,10.083800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.469737,-1.535000,10.083800>}
box{<0,0,-0.406400><1.733656,0.035000,0.406400> rotate<0,0.000000,0> translate<4.736081,-1.535000,10.083800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.920094,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,6.502400>}
box{<0,0,-0.406400><4.880506,0.035000,0.406400> rotate<0,0.000000,0> translate<4.920094,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<4.920094,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,6.502400>}
box{<0,0,-0.406400><5.113906,0.035000,0.406400> rotate<0,0.000000,0> translate<4.920094,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.024413,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.081603,0.000000,3.251200>}
box{<0,0,-0.406400><1.057191,0.035000,0.406400> rotate<0,0.000000,0> translate<5.024413,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.024413,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.081603,-1.535000,3.251200>}
box{<0,0,-0.406400><1.057191,0.035000,0.406400> rotate<0,0.000000,0> translate<5.024413,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.035981,-1.535000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,33.324800>}
box{<0,0,-0.406400><7.384619,0.035000,0.406400> rotate<0,0.000000,0> translate<5.035981,-1.535000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.066284,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,9.753600>}
box{<0,0,-0.406400><4.734316,0.035000,0.406400> rotate<0,0.000000,0> translate<5.066284,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.066284,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,9.753600>}
box{<0,0,-0.406400><4.967716,0.035000,0.406400> rotate<0,0.000000,0> translate<5.066284,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.283200,-1.535000,30.781541>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.481753,-1.535000,30.302197>}
box{<0,0,-0.406400><0.518839,0.035000,0.406400> rotate<0,67.495296,0> translate<5.283200,-1.535000,30.781541> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.283200,-1.535000,31.448456>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.283200,-1.535000,30.781541>}
box{<0,0,-0.406400><0.666916,0.035000,0.406400> rotate<0,-90.000000,0> translate<5.283200,-1.535000,30.781541> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.283200,-1.535000,31.448456>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.538416,-1.535000,32.064603>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,-67.495606,0> translate<5.283200,-1.535000,31.448456> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,0.000000,6.906181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,0.000000,7.746381>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-67.495566,0> translate<5.323875,0.000000,6.906181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,-1.535000,6.906181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,-1.535000,7.746381>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-67.495566,0> translate<5.323875,-1.535000,6.906181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,0.000000,9.496009>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,0.000000,8.655809>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,67.495566,0> translate<5.323875,0.000000,9.496009> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.323875,-1.535000,9.496009>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,-1.535000,8.655809>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,67.495566,0> translate<5.323875,-1.535000,9.496009> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.433666,0.000000,39.497000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.087153,0.000000,39.767684>}
box{<0,0,-0.406400><0.707330,0.035000,0.406400> rotate<0,-22.498589,0> translate<5.433666,0.000000,39.497000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.493294,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,7.315200>}
box{<0,0,-0.406400><4.307306,0.035000,0.406400> rotate<0,0.000000,0> translate<5.493294,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.493294,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,7.315200>}
box{<0,0,-0.406400><4.540706,0.035000,0.406400> rotate<0,0.000000,0> translate<5.493294,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.538416,-1.535000,32.064603>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.009994,-1.535000,32.536181>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,-44.997030,0> translate<5.538416,-1.535000,32.064603> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.553853,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,8.940800>}
box{<0,0,-0.406400><4.246747,0.035000,0.406400> rotate<0,0.000000,0> translate<5.553853,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.553853,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,8.940800>}
box{<0,0,-0.406400><4.480147,0.035000,0.406400> rotate<0,0.000000,0> translate<5.553853,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,0.000000,7.746381>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,0.000000,8.655809>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,90.000000,0> translate<5.671897,0.000000,8.655809> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,-1.535000,7.746381>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,-1.535000,8.655809>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,90.000000,0> translate<5.671897,-1.535000,8.655809> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,8.128000>}
box{<0,0,-0.406400><4.128703,0.035000,0.406400> rotate<0,0.000000,0> translate<5.671897,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.671897,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,8.128000>}
box{<0,0,-0.406400><4.362103,0.035000,0.406400> rotate<0,0.000000,0> translate<5.671897,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.848781,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,34.137600>}
box{<0,0,-0.406400><6.571819,0.035000,0.406400> rotate<0,0.000000,0> translate<5.848781,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.988697,0.000000,2.550603>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.636431,0.000000,2.220563>}
box{<0,0,-0.406400><0.726971,0.035000,0.406400> rotate<0,26.998462,0> translate<5.988697,0.000000,2.550603> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<5.988697,-1.535000,2.550603>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.636434,-1.535000,2.220563>}
box{<0,0,-0.406400><0.726974,0.035000,0.406400> rotate<0,26.998350,0> translate<5.988697,-1.535000,2.550603> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.009994,-1.535000,32.536181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.626141,-1.535000,32.791397>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,-22.498454,0> translate<6.009994,-1.535000,32.536181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,0.000000,3.478372>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,0.000000,3.227488>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,82.494876,0> translate<6.051697,0.000000,3.478372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,-1.535000,3.478372>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,-1.535000,3.227488>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,82.494876,0> translate<6.051697,-1.535000,3.478372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,0.000000,3.731425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,0.000000,3.478372>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,-90.000000,0> translate<6.051697,0.000000,3.478372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,-1.535000,3.731425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,-1.535000,3.478372>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,-90.000000,0> translate<6.051697,-1.535000,3.478372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,0.000000,3.731425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,0.000000,3.982309>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-82.494876,0> translate<6.051697,0.000000,3.731425> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.051697,-1.535000,3.731425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,-1.535000,3.982309>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-82.494876,0> translate<6.051697,-1.535000,3.731425> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,0.000000,3.227488>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,0.000000,2.983059>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,74.994491,0> translate<6.084725,0.000000,3.227488> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,-1.535000,3.227488>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,-1.535000,2.983059>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,74.994491,0> translate<6.084725,-1.535000,3.227488> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,0.000000,3.982309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,0.000000,4.226738>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-74.994491,0> translate<6.084725,0.000000,3.982309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.084725,-1.535000,3.982309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,-1.535000,4.226738>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-74.994491,0> translate<6.084725,-1.535000,3.982309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.087153,0.000000,39.767684>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.587313,0.000000,40.267844>}
box{<0,0,-0.406400><0.707332,0.035000,0.406400> rotate<0,-44.997030,0> translate<6.087153,0.000000,39.767684> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.146669,0.000000,39.827200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,39.827200>}
box{<0,0,-0.406400><17.703931,0.035000,0.406400> rotate<0,0.000000,0> translate<6.146669,0.000000,39.827200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,0.000000,2.983059>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,0.000000,2.749272>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,67.495640,0> translate<6.150222,0.000000,2.983059> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,-1.535000,2.983059>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,-1.535000,2.749272>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,67.495640,0> translate<6.150222,-1.535000,2.983059> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,0.000000,4.226738>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,0.000000,4.460525>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-67.495640,0> translate<6.150222,0.000000,4.226738> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.150222,-1.535000,4.226738>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,-1.535000,4.460525>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-67.495640,0> translate<6.150222,-1.535000,4.226738> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.208906,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.443966,0.000000,2.438400>}
box{<0,0,-0.406400><0.235059,0.035000,0.406400> rotate<0,0.000000,0> translate<6.208906,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.208909,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.443966,-1.535000,2.438400>}
box{<0,0,-0.406400><0.235056,0.035000,0.406400> rotate<0,0.000000,0> translate<6.208909,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,0.000000,2.749272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,0.000000,2.530125>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,59.995944,0> translate<6.247059,0.000000,2.749272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,-1.535000,2.749272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,-1.535000,2.530125>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,59.995944,0> translate<6.247059,-1.535000,2.749272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,0.000000,4.460525>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,0.000000,4.679672>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<6.247059,0.000000,4.460525> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.247059,-1.535000,4.460525>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,-1.535000,4.679672>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<6.247059,-1.535000,4.460525> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,0.000000,2.530125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,0.000000,2.329366>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<6.373584,0.000000,2.530125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,-1.535000,2.530125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,-1.535000,2.329366>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<6.373584,-1.535000,2.530125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,0.000000,4.679672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,0.000000,4.880431>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<6.373584,0.000000,4.679672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.373584,-1.535000,4.679672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,-1.535000,4.880431>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<6.373584,-1.535000,4.679672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.469737,0.000000,10.083800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.207247,0.000000,10.389288>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<6.469737,0.000000,10.083800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.469737,-1.535000,10.083800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.207247,-1.535000,10.389288>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<6.469737,-1.535000,10.083800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,0.000000,2.329366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617084,0.000000,2.239909>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,44.998031,0> translate<6.527631,0.000000,2.329366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,-1.535000,2.329366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617084,-1.535000,2.239909>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,44.998031,0> translate<6.527631,-1.535000,2.329366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,0.000000,4.880431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617088,0.000000,4.969884>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.996029,0> translate<6.527631,0.000000,4.880431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.527631,-1.535000,4.880431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617088,-1.535000,4.969884>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.996029,0> translate<6.527631,-1.535000,4.880431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.587313,0.000000,40.267844>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.857997,0.000000,40.921331>}
box{<0,0,-0.406400><0.707330,0.035000,0.406400> rotate<0,-67.495471,0> translate<6.587313,0.000000,40.267844> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617084,0.000000,2.239909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982063,0.000000,3.604888>}
box{<0,0,-0.406400><1.930371,0.035000,0.406400> rotate<0,-44.997030,0> translate<6.617084,0.000000,2.239909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617084,-1.535000,2.239909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982063,-1.535000,3.604888>}
box{<0,0,-0.406400><1.930371,0.035000,0.406400> rotate<0,-44.997030,0> translate<6.617084,-1.535000,2.239909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617088,0.000000,4.969884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982059,0.000000,3.604906>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997161,0> translate<6.617088,0.000000,4.969884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617088,-1.535000,4.969884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982059,-1.535000,3.604906>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997161,0> translate<6.617088,-1.535000,4.969884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,0.000000,2.239888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.636431,0.000000,2.220563>}
box{<0,0,-0.406400><0.027330,0.035000,0.406400> rotate<0,44.997030,0> translate<6.617106,0.000000,2.239888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,-1.535000,2.239888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.636434,-1.535000,2.220563>}
box{<0,0,-0.406400><0.027332,0.035000,0.406400> rotate<0,44.992398,0> translate<6.617106,-1.535000,2.239888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,0.000000,2.239888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,0.000000,3.604866>}
box{<0,0,-0.406400><1.930371,0.035000,0.406400> rotate<0,-44.997030,0> translate<6.617106,0.000000,2.239888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,-1.535000,2.239888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,-1.535000,3.604866>}
box{<0,0,-0.406400><1.930371,0.035000,0.406400> rotate<0,-44.997030,0> translate<6.617106,-1.535000,2.239888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,0.000000,4.969903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.706563,0.000000,5.059363>}
box{<0,0,-0.406400><0.126512,0.035000,0.406400> rotate<0,-44.998031,0> translate<6.617106,0.000000,4.969903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,-1.535000,4.969903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.706563,-1.535000,5.059363>}
box{<0,0,-0.406400><0.126512,0.035000,0.406400> rotate<0,-44.998031,0> translate<6.617106,-1.535000,4.969903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,0.000000,4.969903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,0.000000,3.604931>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.996899,0> translate<6.617106,0.000000,4.969903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.617106,-1.535000,4.969903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,-1.535000,3.604931>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.996899,0> translate<6.617106,-1.535000,4.969903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.626141,-1.535000,32.791397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.613856,-1.535000,32.791397>}
box{<0,0,-0.406400><1.987716,0.035000,0.406400> rotate<0,0.000000,0> translate<6.626141,-1.535000,32.791397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.661581,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,34.950400>}
box{<0,0,-0.406400><5.759019,0.035000,0.406400> rotate<0,0.000000,0> translate<6.661581,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.706563,0.000000,5.059363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.907322,0.000000,5.213409>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<6.706563,0.000000,5.059363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.706563,-1.535000,5.059363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.907322,-1.535000,5.213409>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<6.706563,-1.535000,5.059363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.710172,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.710209,0.000000,4.876800>}
box{<0,0,-0.406400><0.000038,0.035000,0.406400> rotate<0,0.000000,0> translate<6.710172,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.710172,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.710209,-1.535000,4.876800>}
box{<0,0,-0.406400><0.000038,0.035000,0.406400> rotate<0,0.000000,0> translate<6.710172,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.741462,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.142772,0.000000,40.640000>}
box{<0,0,-0.406400><3.401309,0.035000,0.406400> rotate<0,0.000000,0> translate<6.741462,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.792681,0.000000,44.849047>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.229719,0.000000,44.849047>}
box{<0,0,-0.406400><0.437037,0.035000,0.406400> rotate<0,0.000000,0> translate<6.792681,0.000000,44.849047> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.792681,0.000000,44.849047>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.444734,0.000000,45.181281>}
box{<0,0,-0.406400><0.731815,0.035000,0.406400> rotate<0,-26.997989,0> translate<6.792681,0.000000,44.849047> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.815575,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.815619,0.000000,2.438400>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<6.815575,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.815575,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.815619,-1.535000,2.438400>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<6.815575,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.857997,0.000000,40.921331>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.857997,0.000000,41.293050>}
box{<0,0,-0.406400><0.371719,0.035000,0.406400> rotate<0,90.000000,0> translate<6.857997,0.000000,41.293050> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.857997,0.000000,41.293050>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.229719,0.000000,41.293050>}
box{<0,0,-0.406400><0.371722,0.035000,0.406400> rotate<0,0.000000,0> translate<6.857997,0.000000,41.293050> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.907322,0.000000,5.213409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.126469,0.000000,5.339934>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<6.907322,0.000000,5.213409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<6.907322,-1.535000,5.213409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.126469,-1.535000,5.339934>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<6.907322,-1.535000,5.213409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.126469,0.000000,5.339934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.360256,0.000000,5.436772>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<7.126469,0.000000,5.339934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.126469,-1.535000,5.339934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.360256,-1.535000,5.436772>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<7.126469,-1.535000,5.339934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.207247,0.000000,10.389288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.358956,0.000000,10.541000>}
box{<0,0,-0.406400><0.214552,0.035000,0.406400> rotate<0,-44.997620,0> translate<7.207247,0.000000,10.389288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.207247,-1.535000,10.389288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.771709,-1.535000,10.953750>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,-44.997030,0> translate<7.207247,-1.535000,10.389288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.229719,0.000000,41.293050>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.883206,0.000000,41.563734>}
box{<0,0,-0.406400><0.707330,0.035000,0.406400> rotate<0,-22.498589,0> translate<7.229719,0.000000,41.293050> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.229719,0.000000,44.849047>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.883206,0.000000,44.578363>}
box{<0,0,-0.406400><0.707330,0.035000,0.406400> rotate<0,22.498589,0> translate<7.229719,0.000000,44.849047> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.358956,0.000000,10.541000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.223594,0.000000,10.541000>}
box{<0,0,-0.406400><1.864638,0.035000,0.406400> rotate<0,0.000000,0> translate<7.358956,0.000000,10.541000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.360256,0.000000,5.436772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.604684,0.000000,5.502269>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<7.360256,0.000000,5.436772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.360256,-1.535000,5.436772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.604684,-1.535000,5.502269>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<7.360256,-1.535000,5.436772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.384359,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,10.566400>}
box{<0,0,-0.406400><2.649641,0.035000,0.406400> rotate<0,0.000000,0> translate<7.384359,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.444734,0.000000,45.181281>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.998900,0.000000,45.686259>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,-17.998782,0> translate<7.444734,0.000000,45.181281> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.474381,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.210616,-1.535000,35.763200>}
box{<0,0,-0.406400><4.736234,0.035000,0.406400> rotate<0,0.000000,0> translate<7.474381,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.522969,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.523013,0.000000,4.064000>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<7.522969,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.522969,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.523013,-1.535000,4.064000>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<7.522969,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.579894,0.000000,44.704000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.707397,0.000000,44.704000>}
box{<0,0,-0.406400><15.127503,0.035000,0.406400> rotate<0,0.000000,0> translate<7.579894,0.000000,44.704000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.604684,0.000000,5.502269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.855569,0.000000,5.535297>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<7.604684,0.000000,5.502269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.604684,-1.535000,5.502269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.855569,-1.535000,5.535297>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<7.604684,-1.535000,5.502269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.615388,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,41.452800>}
box{<0,0,-0.406400><2.412012,0.035000,0.406400> rotate<0,0.000000,0> translate<7.615388,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.628375,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.628419,0.000000,3.251200>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<7.628375,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.628375,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.628419,-1.535000,3.251200>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<7.628375,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.771709,-1.535000,10.953750>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.077197,-1.535000,11.691259>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-67.495471,0> translate<7.771709,-1.535000,10.953750> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.842722,-1.535000,13.055600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.077197,-1.535000,12.489538>}
box{<0,0,-0.406400><0.612703,0.035000,0.406400> rotate<0,67.495179,0> translate<7.842722,-1.535000,13.055600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.842722,-1.535000,13.055600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.248216,-1.535000,13.055600>}
box{<0,0,-0.406400><0.405494,0.035000,0.406400> rotate<0,0.000000,0> translate<7.842722,-1.535000,13.055600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.855569,0.000000,5.535297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,0.000000,5.535297>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,0.000000,0> translate<7.855569,0.000000,5.535297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.855569,-1.535000,5.535297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,-1.535000,5.535297>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,0.000000,0> translate<7.855569,-1.535000,5.535297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.857800,-1.535000,1.674500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,-1.535000,1.674500>}
box{<0,0,-0.406400><0.250822,0.035000,0.406400> rotate<0,0.000000,0> translate<7.857800,-1.535000,1.674500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.857800,-1.535000,1.674500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.998897,-1.535000,1.303737>}
box{<0,0,-0.406400><1.199820,0.035000,0.406400> rotate<0,17.998705,0> translate<7.857800,-1.535000,1.674500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.857803,0.000000,1.674500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,0.000000,1.674500>}
box{<0,0,-0.406400><0.250819,0.035000,0.406400> rotate<0,0.000000,0> translate<7.857803,0.000000,1.674500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.857803,0.000000,1.674500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.998897,0.000000,1.303737>}
box{<0,0,-0.406400><1.199817,0.035000,0.406400> rotate<0,17.998751,0> translate<7.857803,0.000000,1.674500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.863766,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.299016,-1.535000,13.004800>}
box{<0,0,-0.406400><0.435250,0.035000,0.406400> rotate<0,0.000000,0> translate<7.863766,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.883206,0.000000,41.563734>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.383366,0.000000,42.063894>}
box{<0,0,-0.406400><0.707332,0.035000,0.406400> rotate<0,-44.997030,0> translate<7.883206,0.000000,41.563734> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.883206,0.000000,44.578363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.383366,0.000000,44.078203>}
box{<0,0,-0.406400><0.707332,0.035000,0.406400> rotate<0,44.997030,0> translate<7.883206,0.000000,44.578363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.944281,-1.535000,36.233100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.740716,-1.535000,36.233100>}
box{<0,0,-0.406400><3.796434,0.035000,0.406400> rotate<0,0.000000,0> translate<7.944281,-1.535000,36.233100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.947934,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,11.379200>}
box{<0,0,-0.406400><2.086066,0.035000,0.406400> rotate<0,0.000000,0> translate<7.947934,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982059,0.000000,3.604906>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,0.000000,3.604931>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,-44.997030,0> translate<7.982059,0.000000,3.604906> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982059,-1.535000,3.604906>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,-1.535000,3.604931>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,-44.997030,0> translate<7.982059,-1.535000,3.604906> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982063,0.000000,3.604888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,0.000000,3.604866>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,44.997030,0> translate<7.982063,0.000000,3.604888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982063,-1.535000,3.604888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982084,-1.535000,3.604866>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,44.997030,0> translate<7.982063,-1.535000,3.604888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982103,0.000000,3.604863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,0.000000,3.604888>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,-44.997030,0> translate<7.982103,0.000000,3.604863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982103,-1.535000,3.604863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,-1.535000,3.604888>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,-44.997030,0> translate<7.982103,-1.535000,3.604863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982103,0.000000,3.604863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,0.000000,2.239891>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.996899,0> translate<7.982103,0.000000,3.604863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982103,-1.535000,3.604863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,-1.535000,2.239891>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.996899,0> translate<7.982103,-1.535000,3.604863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982106,0.000000,3.604931>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,0.000000,3.604909>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,44.997030,0> translate<7.982106,0.000000,3.604931> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982106,-1.535000,3.604931>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,-1.535000,3.604909>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,44.997030,0> translate<7.982106,-1.535000,3.604931> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982106,0.000000,3.604931>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,0.000000,4.969903>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,-44.996965,0> translate<7.982106,0.000000,3.604931> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982106,-1.535000,3.604931>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,-1.535000,4.969903>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,-44.996965,0> translate<7.982106,-1.535000,3.604931> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,0.000000,3.604888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,0.000000,2.239909>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997161,0> translate<7.982128,0.000000,3.604888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,-1.535000,3.604888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,-1.535000,2.239909>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997161,0> translate<7.982128,-1.535000,3.604888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,0.000000,3.604909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,0.000000,4.969884>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,-44.997096,0> translate<7.982128,0.000000,3.604909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<7.982128,-1.535000,3.604909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,-1.535000,4.969884>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,-44.997096,0> translate<7.982128,-1.535000,3.604909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.008300,-1.535000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.854191,-1.535000,1.625600>}
box{<0,0,-0.406400><26.845891,0.035000,0.406400> rotate<0,0.000000,0> translate<8.008300,-1.535000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.008303,0.000000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.854191,0.000000,1.625600>}
box{<0,0,-0.406400><26.845887,0.035000,0.406400> rotate<0,0.000000,0> translate<8.008303,0.000000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.077197,-1.535000,11.691259>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.077197,-1.535000,12.489538>}
box{<0,0,-0.406400><0.798278,0.035000,0.406400> rotate<0,90.000000,0> translate<8.077197,-1.535000,12.489538> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.077197,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,12.192000>}
box{<0,0,-0.406400><1.956803,0.035000,0.406400> rotate<0,0.000000,0> translate<8.077197,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,0.000000,1.674500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,0.000000,1.707528>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<8.108622,0.000000,1.674500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,-1.535000,1.674500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,-1.535000,1.707528>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<8.108622,-1.535000,1.674500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,0.000000,5.535297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,0.000000,5.502269>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,7.499184,0> translate<8.108622,0.000000,5.535297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.108622,-1.535000,5.535297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,-1.535000,5.502269>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,7.499184,0> translate<8.108622,-1.535000,5.535297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.248216,-1.535000,13.055600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.266481,-1.535000,13.037334>}
box{<0,0,-0.406400><0.025831,0.035000,0.406400> rotate<0,44.997030,0> translate<8.248216,-1.535000,13.055600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.266481,-1.535000,13.037334>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.702334,-1.535000,12.601481>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,44.997030,0> translate<8.266481,-1.535000,13.037334> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.335769,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.335813,0.000000,3.251200>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<8.335769,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.335769,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.335813,-1.535000,3.251200>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<8.335769,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,0.000000,1.707528>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,0.000000,1.773025>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<8.359506,0.000000,1.707528> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,-1.535000,1.707528>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,-1.535000,1.773025>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<8.359506,-1.535000,1.707528> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,0.000000,5.502269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,0.000000,5.436772>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,14.999569,0> translate<8.359506,0.000000,5.502269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.359506,-1.535000,5.502269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,-1.535000,5.436772>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,14.999569,0> translate<8.359506,-1.535000,5.502269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.383366,0.000000,42.063894>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.654050,0.000000,42.717381>}
box{<0,0,-0.406400><0.707330,0.035000,0.406400> rotate<0,-67.495471,0> translate<8.383366,0.000000,42.063894> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.383366,0.000000,44.078203>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.654050,0.000000,43.424716>}
box{<0,0,-0.406400><0.707330,0.035000,0.406400> rotate<0,67.495471,0> translate<8.383366,0.000000,44.078203> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.441175,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.441219,0.000000,4.064000>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<8.441175,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.441175,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.441219,-1.535000,4.064000>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<8.441175,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.460828,0.000000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.484759,0.000000,43.891200>}
box{<0,0,-0.406400><4.023931,0.035000,0.406400> rotate<0,0.000000,0> translate<8.460828,0.000000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.466913,0.000000,42.265600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,42.265600>}
box{<0,0,-0.406400><1.560487,0.035000,0.406400> rotate<0,0.000000,0> translate<8.466913,0.000000,42.265600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.477356,0.000000,45.516800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.275619,0.000000,45.516800>}
box{<0,0,-0.406400><15.798262,0.035000,0.406400> rotate<0,0.000000,0> translate<8.477356,0.000000,45.516800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,0.000000,1.773025>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,0.000000,1.869862>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<8.603934,0.000000,1.773025> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,-1.535000,1.773025>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,-1.535000,1.869862>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<8.603934,-1.535000,1.773025> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,0.000000,5.436772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,0.000000,5.339934>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,22.498420,0> translate<8.603934,0.000000,5.436772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.603934,-1.535000,5.436772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,-1.535000,5.339934>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,22.498420,0> translate<8.603934,-1.535000,5.436772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.613856,-1.535000,32.791397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.230003,-1.535000,32.536181>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,22.498454,0> translate<8.613856,-1.535000,32.791397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.654050,0.000000,42.717381>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.654050,0.000000,43.424716>}
box{<0,0,-0.406400><0.707334,0.035000,0.406400> rotate<0,90.000000,0> translate<8.654050,0.000000,43.424716> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.654050,0.000000,43.078400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,43.078400>}
box{<0,0,-0.406400><1.373350,0.035000,0.406400> rotate<0,0.000000,0> translate<8.654050,0.000000,43.078400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.702334,-1.535000,12.601481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.271803,-1.535000,12.365600>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,22.498478,0> translate<8.702334,-1.535000,12.601481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,0.000000,1.869862>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,0.000000,1.996388>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<8.837722,0.000000,1.869862> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,-1.535000,1.869862>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,-1.535000,1.996388>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<8.837722,-1.535000,1.869862> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,0.000000,5.339934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,0.000000,5.213409>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,29.998117,0> translate<8.837722,0.000000,5.339934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.837722,-1.535000,5.339934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,-1.535000,5.213409>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,29.998117,0> translate<8.837722,-1.535000,5.339934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.998897,0.000000,1.303737>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.612925,0.000000,1.048100>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,8.999425,0> translate<8.998897,0.000000,1.303737> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.998897,-1.535000,1.303737>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.612925,-1.535000,1.048100>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,8.999425,0> translate<8.998897,-1.535000,1.303737> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<8.998900,0.000000,45.686259>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.612928,0.000000,45.941897>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,-8.999425,0> translate<8.998900,0.000000,45.686259> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,0.000000,1.996388>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,0.000000,2.150434>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<9.056869,0.000000,1.996388> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,-1.535000,1.996388>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,-1.535000,2.150434>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<9.056869,-1.535000,1.996388> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,0.000000,5.213409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,0.000000,5.059363>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,37.497308,0> translate<9.056869,0.000000,5.213409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.056869,-1.535000,5.213409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,-1.535000,5.059363>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,37.497308,0> translate<9.056869,-1.535000,5.213409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.146694,-1.535000,29.659309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.230003,-1.535000,29.693816>}
box{<0,0,-0.406400><0.090173,0.035000,0.406400> rotate<0,-22.497562,0> translate<9.146694,-1.535000,29.659309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.146694,-1.535000,29.659309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.233631,-1.535000,29.642019>}
box{<0,0,-0.406400><0.088640,0.035000,0.406400> rotate<0,11.247788,0> translate<9.146694,-1.535000,29.659309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.148572,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.148609,0.000000,2.438400>}
box{<0,0,-0.406400><0.000038,0.035000,0.406400> rotate<0,0.000000,0> translate<9.148572,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.148572,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.148609,-1.535000,2.438400>}
box{<0,0,-0.406400><0.000038,0.035000,0.406400> rotate<0,0.000000,0> translate<9.148572,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.223594,0.000000,10.541000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.793063,0.000000,10.776881>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-22.498478,0> translate<9.223594,0.000000,10.541000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.230003,-1.535000,29.693816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.701581,-1.535000,30.165394>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,-44.997030,0> translate<9.230003,-1.535000,29.693816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.230003,-1.535000,32.536181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.701581,-1.535000,32.064603>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,44.997030,0> translate<9.230003,-1.535000,32.536181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.233631,-1.535000,29.642019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.353816,-1.535000,29.592238>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<9.233631,-1.535000,29.642019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.253975,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.254019,0.000000,4.876800>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<9.253975,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.253975,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.254019,-1.535000,4.876800>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<9.253975,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.254184,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.503359,-1.535000,32.512000>}
box{<0,0,-0.406400><3.249175,0.035000,0.406400> rotate<0,0.000000,0> translate<9.254184,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,0.000000,2.150434>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,0.000000,2.239891>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.998031,0> translate<9.257628,0.000000,2.150434> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,-1.535000,2.150434>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,-1.535000,2.239891>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.998031,0> translate<9.257628,-1.535000,2.150434> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,0.000000,5.059363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,0.000000,4.969903>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.999032,0> translate<9.257628,0.000000,5.059363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.257628,-1.535000,5.059363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347081,-1.535000,4.969903>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.999032,0> translate<9.257628,-1.535000,5.059363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.271803,-1.535000,12.365600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,12.365600>}
box{<0,0,-0.406400><0.762197,0.035000,0.406400> rotate<0,0.000000,0> translate<9.271803,-1.535000,12.365600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.284913,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,10.566400>}
box{<0,0,-0.406400><0.515688,0.035000,0.406400> rotate<0,0.000000,0> translate<9.284913,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,0.000000,2.239909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,0.000000,2.329366>}
box{<0,0,-0.406400><0.126512,0.035000,0.406400> rotate<0,-44.996029,0> translate<9.347100,0.000000,2.239909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,-1.535000,2.239909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,-1.535000,2.329366>}
box{<0,0,-0.406400><0.126512,0.035000,0.406400> rotate<0,-44.996029,0> translate<9.347100,-1.535000,2.239909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,0.000000,4.969884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,0.000000,4.880431>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.995029,0> translate<9.347100,0.000000,4.969884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.347100,-1.535000,4.969884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,-1.535000,4.880431>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.995029,0> translate<9.347100,-1.535000,4.969884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.353816,-1.535000,29.592238>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.461978,-1.535000,29.519963>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<9.353816,-1.535000,29.592238> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,0.000000,2.329366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,0.000000,2.530125>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<9.436559,0.000000,2.329366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,-1.535000,2.329366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,-1.535000,2.530125>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<9.436559,-1.535000,2.329366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,0.000000,4.880431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,0.000000,4.679672>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<9.436559,0.000000,4.880431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.436559,-1.535000,4.880431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,-1.535000,4.679672>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<9.436559,-1.535000,4.880431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.439347,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,4.876800>}
box{<0,0,-0.406400><0.361253,0.035000,0.406400> rotate<0,0.000000,0> translate<9.439347,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.439347,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.806628,-1.535000,4.876800>}
box{<0,0,-0.406400><0.367281,0.035000,0.406400> rotate<0,0.000000,0> translate<9.439347,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.461978,-1.535000,29.519963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.553963,-1.535000,29.427978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<9.461978,-1.535000,29.519963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.520222,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.881756,0.000000,2.438400>}
box{<0,0,-0.406400><0.361534,0.035000,0.406400> rotate<0,0.000000,0> translate<9.520222,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.520222,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.881756,-1.535000,2.438400>}
box{<0,0,-0.406400><0.361534,0.035000,0.406400> rotate<0,0.000000,0> translate<9.520222,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.553963,-1.535000,29.427978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.626238,-1.535000,29.319816>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<9.553963,-1.535000,29.427978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,0.000000,2.530125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.717131,0.000000,2.749272>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<9.590606,0.000000,2.530125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,-1.535000,2.530125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.717131,-1.535000,2.749272>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<9.590606,-1.535000,2.530125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,-1.535000,4.679672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,-1.535000,4.524831>}
box{<0,0,-0.406400><0.178793,0.035000,0.406400> rotate<0,59.997019,0> translate<9.590606,-1.535000,4.679672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.590606,0.000000,4.679672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,0.000000,4.524834>}
box{<0,0,-0.406400><0.178790,0.035000,0.406400> rotate<0,59.996518,0> translate<9.590606,0.000000,4.679672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.609788,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.385725,-1.535000,30.073600>}
box{<0,0,-0.406400><2.775937,0.035000,0.406400> rotate<0,0.000000,0> translate<9.609788,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.626238,-1.535000,29.319816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.676019,-1.535000,29.199631>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<9.626238,-1.535000,29.319816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.650684,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.858963,-1.535000,29.260800>}
box{<0,0,-0.406400><0.208278,0.035000,0.406400> rotate<0,0.000000,0> translate<9.650684,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.676019,-1.535000,29.199631>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.696222,-1.535000,29.098059>}
box{<0,0,-0.406400><0.103562,0.035000,0.406400> rotate<0,78.745224,0> translate<9.676019,-1.535000,29.199631> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,-1.535000,4.571094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,-1.535000,4.524831>}
box{<0,0,-0.406400><0.046263,0.035000,0.406400> rotate<0,-90.000000,0> translate<9.680000,-1.535000,4.524831> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,0.000000,4.571094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,0.000000,4.524834>}
box{<0,0,-0.406400><0.046259,0.035000,0.406400> rotate<0,-90.000000,0> translate<9.680000,0.000000,4.524834> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,0.000000,4.571094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,4.862250>}
box{<0,0,-0.406400><0.315145,0.035000,0.406400> rotate<0,-67.495691,0> translate<9.680000,0.000000,4.571094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.680000,-1.535000,4.571094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.834675,-1.535000,4.944516>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<9.680000,-1.535000,4.571094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.696222,-1.535000,29.098059>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.974481,-1.535000,29.376322>}
box{<0,0,-0.406400><0.393520,0.035000,0.406400> rotate<0,-44.997352,0> translate<9.696222,-1.535000,29.098059> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.701581,-1.535000,30.165394>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.956797,-1.535000,30.781541>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,-67.495606,0> translate<9.701581,-1.535000,30.165394> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.701581,-1.535000,32.064603>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.956797,-1.535000,31.448456>}
box{<0,0,-0.406400><0.666912,0.035000,0.406400> rotate<0,67.495606,0> translate<9.701581,-1.535000,32.064603> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.717131,0.000000,2.749272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.721272,0.000000,2.759269>}
box{<0,0,-0.406400><0.010820,0.035000,0.406400> rotate<0,-67.496603,0> translate<9.717131,0.000000,2.749272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.717131,-1.535000,2.749272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.721272,-1.535000,2.759272>}
box{<0,0,-0.406400><0.010823,0.035000,0.406400> rotate<0,-67.502933,0> translate<9.717131,-1.535000,2.749272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.721272,0.000000,2.759269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.834675,0.000000,2.485481>}
box{<0,0,-0.406400><0.296344,0.035000,0.406400> rotate<0,67.496147,0> translate<9.721272,0.000000,2.759269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.721272,-1.535000,2.759272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.834675,-1.535000,2.485481>}
box{<0,0,-0.406400><0.296347,0.035000,0.406400> rotate<0,67.496379,0> translate<9.721272,-1.535000,2.759272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.793063,0.000000,10.776881>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,10.784422>}
box{<0,0,-0.406400><0.010662,0.035000,0.406400> rotate<0,-45.008904,0> translate<9.793063,0.000000,10.776881> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,10.406803>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,4.862250>}
box{<0,0,-0.406400><5.544553,0.035000,0.406400> rotate<0,-90.000000,0> translate<9.800600,0.000000,4.862250> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,10.784422>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.800600,0.000000,10.406803>}
box{<0,0,-0.406400><0.377619,0.035000,0.406400> rotate<0,-90.000000,0> translate<9.800600,0.000000,10.406803> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.834675,0.000000,2.485481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.120481,0.000000,2.199675>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,44.997030,0> translate<9.834675,0.000000,2.485481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.834675,-1.535000,2.485481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.120481,-1.535000,2.199675>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,44.997030,0> translate<9.834675,-1.535000,2.485481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.834675,-1.535000,4.944516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.054231,-1.535000,5.164069>}
box{<0,0,-0.406400><0.310497,0.035000,0.406400> rotate<0,-44.996622,0> translate<9.834675,-1.535000,4.944516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.852938,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.899313,-1.535000,31.699200>}
box{<0,0,-0.406400><3.046375,0.035000,0.406400> rotate<0,0.000000,0> translate<9.852938,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.956797,-1.535000,30.781541>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.956797,-1.535000,31.448456>}
box{<0,0,-0.406400><0.666916,0.035000,0.406400> rotate<0,90.000000,0> translate<9.956797,-1.535000,31.448456> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.956797,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.385728,-1.535000,30.886400>}
box{<0,0,-0.406400><2.428931,0.035000,0.406400> rotate<0,0.000000,0> translate<9.956797,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<9.974481,-1.535000,29.376322>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.347903,-1.535000,29.530997>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<9.974481,-1.535000,29.376322> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,40.947953>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.052778,0.000000,40.820366>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<10.027400,0.000000,40.947953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,42.105181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,40.947953>}
box{<0,0,-0.406400><1.157228,0.035000,0.406400> rotate<0,-90.000000,0> translate<10.027400,0.000000,40.947953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,42.105181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779966,0.000000,42.105181>}
box{<0,0,-0.406400><1.752566,0.035000,0.406400> rotate<0,0.000000,0> translate<10.027400,0.000000,42.105181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,42.105213>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779966,0.000000,42.105213>}
box{<0,0,-0.406400><1.752566,0.035000,0.406400> rotate<0,0.000000,0> translate<10.027400,0.000000,42.105213> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,43.262444>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,42.105213>}
box{<0,0,-0.406400><1.157231,0.035000,0.406400> rotate<0,-90.000000,0> translate<10.027400,0.000000,42.105213> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.027400,0.000000,43.262444>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.052778,0.000000,43.390031>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<10.027400,0.000000,43.262444> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,5.212903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.054231,-1.535000,5.164069>}
box{<0,0,-0.406400><0.052859,0.035000,0.406400> rotate<0,67.492151,0> translate<10.034000,-1.535000,5.212903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,12.365600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.034000,-1.535000,5.212903>}
box{<0,0,-0.406400><7.152697,0.035000,0.406400> rotate<0,-90.000000,0> translate<10.034000,-1.535000,5.212903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.052778,0.000000,40.820366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.102559,0.000000,40.700181>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<10.052778,0.000000,40.820366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.052778,0.000000,43.390031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.102559,0.000000,43.510216>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<10.052778,0.000000,43.390031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.102559,0.000000,40.700181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.174834,0.000000,40.592019>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<10.102559,0.000000,40.700181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.102559,0.000000,43.510216>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.174834,0.000000,43.618378>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<10.102559,0.000000,43.510216> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.120481,0.000000,2.199675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.493903,0.000000,2.045000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<10.120481,0.000000,2.199675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.120481,-1.535000,2.199675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.493903,-1.535000,2.045000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<10.120481,-1.535000,2.199675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.174834,0.000000,40.592019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.266819,0.000000,40.500034>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<10.174834,0.000000,40.592019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.174834,0.000000,43.618378>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.266819,0.000000,43.710363>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<10.174834,0.000000,43.618378> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.266819,0.000000,40.500034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.374981,0.000000,40.427759>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<10.266819,0.000000,40.500034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.266819,0.000000,43.710363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.374981,0.000000,43.782637>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<10.266819,0.000000,43.710363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.347903,-1.535000,29.530997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.099819,-1.535000,29.530997>}
box{<0,0,-0.406400><1.751916,0.035000,0.406400> rotate<0,0.000000,0> translate<10.347903,-1.535000,29.530997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.374981,0.000000,40.427759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.495166,0.000000,40.377978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<10.374981,0.000000,40.427759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.374981,0.000000,43.782637>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.495166,0.000000,43.832419>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<10.374981,0.000000,43.782637> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.493903,0.000000,2.045000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.206094,0.000000,2.045000>}
box{<0,0,-0.406400><1.712191,0.035000,0.406400> rotate<0,0.000000,0> translate<10.493903,0.000000,2.045000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.493903,-1.535000,2.045000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.206094,-1.535000,2.045000>}
box{<0,0,-0.406400><1.712191,0.035000,0.406400> rotate<0,0.000000,0> translate<10.493903,-1.535000,2.045000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.495166,0.000000,40.377978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.622753,0.000000,40.352600>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<10.495166,0.000000,40.377978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.495166,0.000000,43.832419>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.622753,0.000000,43.857797>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<10.495166,0.000000,43.832419> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.612925,0.000000,1.048100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.429997,0.000000,1.015997>}
box{<0,0,-0.406400><0.817702,0.035000,0.406400> rotate<0,2.249871,0> translate<10.612925,0.000000,1.048100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.612925,-1.535000,1.048100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.429997,-1.535000,1.015997>}
box{<0,0,-0.406400><0.817702,0.035000,0.406400> rotate<0,2.249871,0> translate<10.612925,-1.535000,1.048100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.612928,0.000000,45.941897>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.429984,0.000000,45.974000>}
box{<0,0,-0.406400><0.817687,0.035000,0.406400> rotate<0,-2.249914,0> translate<10.612928,0.000000,45.941897> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.622753,0.000000,40.352600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,40.352597>}
box{<0,0,-0.406400><1.157228,0.035000,0.406400> rotate<0,0.000155,0> translate<10.622753,0.000000,40.352600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<10.622753,0.000000,43.857797>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,43.857797>}
box{<0,0,-0.406400><1.157228,0.035000,0.406400> rotate<0,0.000000,0> translate<10.622753,0.000000,43.857797> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.429984,0.000000,45.974000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.732822,0.000000,45.974000>}
box{<0,0,-0.406400><13.302838,0.035000,0.406400> rotate<0,0.000000,0> translate<11.429984,0.000000,45.974000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.429997,0.000000,1.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.432497,0.000000,1.015997>}
box{<0,0,-0.406400><20.002500,0.035000,0.406400> rotate<0,0.000000,0> translate<11.429997,0.000000,1.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.429997,-1.535000,1.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.432497,-1.535000,1.015997>}
box{<0,0,-0.406400><20.002500,0.035000,0.406400> rotate<0,0.000000,0> translate<11.429997,-1.535000,1.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.740716,-1.535000,36.233100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,35.553219>}
box{<0,0,-0.406400><0.961499,0.035000,0.406400> rotate<0,44.996899,0> translate<11.740716,-1.535000,36.233100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779966,0.000000,42.105213>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779966,0.000000,42.105181>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<11.779966,0.000000,42.105181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,40.352597>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,42.105166>}
box{<0,0,-0.406400><1.752569,0.035000,0.406400> rotate<0,90.000000,0> translate<11.779981,0.000000,42.105166> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,40.640000>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<11.779981,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,41.452800>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<11.779981,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,42.105166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,42.105166>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<11.779981,0.000000,42.105166> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,42.105231>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,43.857797>}
box{<0,0,-0.406400><1.752566,0.035000,0.406400> rotate<0,90.000000,0> translate<11.779981,0.000000,43.857797> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,42.105231>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,42.105231>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<11.779981,0.000000,42.105231> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,42.265600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,42.265600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<11.779981,0.000000,42.265600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.779981,0.000000,43.078400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,43.078400>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<11.779981,0.000000,43.078400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,40.352600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.451356,0.000000,40.352600>}
box{<0,0,-0.406400><0.671344,0.035000,0.406400> rotate<0,0.000000,0> translate<11.780012,0.000000,40.352600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,42.105166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,40.352600>}
box{<0,0,-0.406400><1.752566,0.035000,0.406400> rotate<0,-90.000000,0> translate<11.780012,0.000000,40.352600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,43.857797>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,42.105231>}
box{<0,0,-0.406400><1.752566,0.035000,0.406400> rotate<0,-90.000000,0> translate<11.780012,0.000000,42.105231> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<11.780012,0.000000,43.857797>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.451356,0.000000,43.857797>}
box{<0,0,-0.406400><0.671344,0.035000,0.406400> rotate<0,0.000000,0> translate<11.780012,0.000000,43.857797> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.058216,0.000000,36.156897>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.457334,0.000000,36.556016>}
box{<0,0,-0.406400><0.564439,0.035000,0.406400> rotate<0,-44.997030,0> translate<12.058216,0.000000,36.156897> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.099819,-1.535000,29.530997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,29.851781>}
box{<0,0,-0.406400><0.453655,0.035000,0.406400> rotate<0,-44.997309,0> translate<12.099819,-1.535000,29.530997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.206094,0.000000,2.045000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.579516,0.000000,2.199675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<12.206094,0.000000,2.045000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.206094,-1.535000,2.045000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.579516,-1.535000,2.199675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<12.206094,-1.535000,2.045000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.350800,-1.535000,30.157919>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,29.989409>}
box{<0,0,-0.406400><0.182394,0.035000,0.406400> rotate<0,67.495217,0> translate<12.350800,-1.535000,30.157919> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.350800,-1.535000,30.802078>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.350800,-1.535000,30.157919>}
box{<0,0,-0.406400><0.644159,0.035000,0.406400> rotate<0,-90.000000,0> translate<12.350800,-1.535000,30.157919> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.350800,-1.535000,30.802078>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.597309,-1.535000,31.397200>}
box{<0,0,-0.406400><0.644156,0.035000,0.406400> rotate<0,-67.495395,0> translate<12.350800,-1.535000,30.802078> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,29.989409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,29.851781>}
box{<0,0,-0.406400><0.137628,0.035000,0.406400> rotate<0,-90.000000,0> translate<12.420600,-1.535000,29.851781> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,32.711803>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.656481,-1.535000,32.142334>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,67.495582,0> translate<12.420600,-1.535000,32.711803> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,35.553219>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.420600,-1.535000,32.711803>}
box{<0,0,-0.406400><2.841416,0.035000,0.406400> rotate<0,-90.000000,0> translate<12.420600,-1.535000,32.711803> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.451356,0.000000,40.352600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.652281,0.000000,40.151675>}
box{<0,0,-0.406400><0.284151,0.035000,0.406400> rotate<0,44.997030,0> translate<12.451356,0.000000,40.352600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.451356,0.000000,43.857797>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.652281,0.000000,44.058722>}
box{<0,0,-0.406400><0.284151,0.035000,0.406400> rotate<0,-44.997030,0> translate<12.451356,0.000000,43.857797> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.457334,0.000000,36.556016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.026803,0.000000,36.791897>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-22.498478,0> translate<12.457334,0.000000,36.556016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.579516,-1.535000,2.199675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.796497,-1.535000,2.416659>}
box{<0,0,-0.406400><0.306860,0.035000,0.406400> rotate<0,-44.997443,0> translate<12.579516,-1.535000,2.199675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.579516,0.000000,2.199675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.865322,0.000000,2.485481>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,-44.997030,0> translate<12.579516,0.000000,2.199675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.597309,-1.535000,31.397200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.999466,-1.535000,31.799353>}
box{<0,0,-0.406400><0.568733,0.035000,0.406400> rotate<0,-44.996808,0> translate<12.597309,-1.535000,31.397200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.652281,0.000000,40.151675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.025703,0.000000,39.997000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<12.652281,0.000000,40.151675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.652281,0.000000,44.058722>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.025703,0.000000,44.213397>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<12.652281,0.000000,44.058722> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.656481,-1.535000,32.142334>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.999466,-1.535000,31.799353>}
box{<0,0,-0.406400><0.485051,0.035000,0.406400> rotate<0,44.996769,0> translate<12.656481,-1.535000,32.142334> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.796497,-1.535000,2.416659>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.064481,-1.535000,2.148675>}
box{<0,0,-0.406400><0.378987,0.035000,0.406400> rotate<0,44.997030,0> translate<12.796497,-1.535000,2.416659> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.818241,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.873375,0.000000,2.438400>}
box{<0,0,-0.406400><13.055134,0.035000,0.406400> rotate<0,0.000000,0> translate<12.818241,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<12.865322,0.000000,2.485481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.019997,0.000000,2.858903>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<12.865322,0.000000,2.485481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.019997,0.000000,2.858903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.019997,0.000000,4.399000>}
box{<0,0,-0.406400><1.540097,0.035000,0.406400> rotate<0,90.000000,0> translate<13.019997,0.000000,4.399000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.019997,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,3.251200>}
box{<0,0,-0.406400><12.415603,0.035000,0.406400> rotate<0,0.000000,0> translate<13.019997,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.019997,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,4.064000>}
box{<0,0,-0.406400><12.415603,0.035000,0.406400> rotate<0,0.000000,0> translate<13.019997,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.019997,0.000000,4.399000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,4.399000>}
box{<0,0,-0.406400><12.415603,0.035000,0.406400> rotate<0,0.000000,0> translate<13.019997,0.000000,4.399000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.025703,0.000000,39.997000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.694294,0.000000,39.997000>}
box{<0,0,-0.406400><7.668591,0.035000,0.406400> rotate<0,0.000000,0> translate<13.025703,0.000000,39.997000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.025703,0.000000,44.213397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.694294,0.000000,44.213397>}
box{<0,0,-0.406400><7.668591,0.035000,0.406400> rotate<0,0.000000,0> translate<13.025703,0.000000,44.213397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.026803,0.000000,36.791897>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.945694,0.000000,36.791897>}
box{<0,0,-0.406400><7.918891,0.035000,0.406400> rotate<0,0.000000,0> translate<13.026803,0.000000,36.791897> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.064481,-1.535000,2.148675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.437903,-1.535000,1.994000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<13.064481,-1.535000,2.148675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<13.437903,-1.535000,1.994000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.142094,-1.535000,1.994000>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,0.000000,0> translate<13.437903,-1.535000,1.994000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.535575,-1.535000,37.820600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.847659,-1.535000,37.508516>}
box{<0,0,-0.406400><0.441354,0.035000,0.406400> rotate<0,44.997030,0> translate<14.535575,-1.535000,37.820600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.535575,-1.535000,37.820600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.164000,-1.535000,37.820600>}
box{<0,0,-0.406400><0.628425,0.035000,0.406400> rotate<0,0.000000,0> translate<14.535575,-1.535000,37.820600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.847659,-1.535000,37.508516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.847663,-1.535000,37.508516>}
box{<0,0,-0.406400><0.000003,0.035000,0.406400> rotate<0,0.000000,0> translate<14.847659,-1.535000,37.508516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.847663,-1.535000,37.508516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.283516,-1.535000,37.072662>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,44.997030,0> translate<14.847663,-1.535000,37.508516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<14.967378,-1.535000,37.388800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.271322,-1.535000,37.388800>}
box{<0,0,-0.406400><0.303944,0.035000,0.406400> rotate<0,0.000000,0> translate<14.967378,-1.535000,37.388800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.142094,-1.535000,1.994000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.240000,-1.535000,2.034556>}
box{<0,0,-0.406400><0.105974,0.035000,0.406400> rotate<0,-22.499591,0> translate<15.142094,-1.535000,1.994000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.164000,-1.535000,37.647903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.318675,-1.535000,37.274481>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,67.495729,0> translate<15.164000,-1.535000,37.647903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.164000,-1.535000,37.820600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.164000,-1.535000,37.647903>}
box{<0,0,-0.406400><0.172697,0.035000,0.406400> rotate<0,-90.000000,0> translate<15.164000,-1.535000,37.647903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.240000,-1.535000,2.034556>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.337903,-1.535000,1.994000>}
box{<0,0,-0.406400><0.105971,0.035000,0.406400> rotate<0,22.500237,0> translate<15.240000,-1.535000,2.034556> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.283516,-1.535000,37.072662>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,-1.535000,36.503194>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,67.495582,0> translate<15.283516,-1.535000,37.072662> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.318675,-1.535000,37.274481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.604481,-1.535000,36.988675>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,44.997030,0> translate<15.318675,-1.535000,37.274481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.337903,-1.535000,1.994000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.042094,-1.535000,1.994000>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,0.000000,0> translate<15.337903,-1.535000,1.994000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.489241,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.173081,-1.535000,36.576000>}
box{<0,0,-0.406400><3.683841,0.035000,0.406400> rotate<0,0.000000,0> translate<15.489241,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,0.000000,24.060575>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,0.000000,26.663216>}
box{<0,0,-0.406400><2.602641,0.035000,0.406400> rotate<0,90.000000,0> translate<15.519397,0.000000,26.663216> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,0.000000,24.060575>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.632334,0.000000,24.173516>}
box{<0,0,-0.406400><0.159720,0.035000,0.406400> rotate<0,-44.997823,0> translate<15.519397,0.000000,24.060575> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<16.140491,0.000000,24.384000>}
box{<0,0,-0.406400><0.621094,0.035000,0.406400> rotate<0,0.000000,0> translate<15.519397,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,0.000000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.510800,0.000000,25.196800>}
box{<0,0,-0.406400><6.991403,0.035000,0.406400> rotate<0,0.000000,0> translate<15.519397,0.000000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,0.000000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.629897,0.000000,26.009600>}
box{<0,0,-0.406400><7.110500,0.035000,0.406400> rotate<0,0.000000,0> translate<15.519397,0.000000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,0.000000,26.663216>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.881781,0.000000,27.025600>}
box{<0,0,-0.406400><0.512489,0.035000,0.406400> rotate<0,-44.997030,0> translate<15.519397,0.000000,26.663216> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,-1.535000,34.712713>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,-1.535000,36.503194>}
box{<0,0,-0.406400><1.790481,0.035000,0.406400> rotate<0,90.000000,0> translate<15.519397,-1.535000,36.503194> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,-1.535000,34.712713>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.693903,-1.535000,34.784997>}
box{<0,0,-0.406400><0.188885,0.035000,0.406400> rotate<0,-22.498941,0> translate<15.519397,-1.535000,34.712713> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.646491,-1.535000,34.950400>}
box{<0,0,-0.406400><2.127094,0.035000,0.406400> rotate<0,0.000000,0> translate<15.519397,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.519397,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.332019,-1.535000,35.763200>}
box{<0,0,-0.406400><2.812622,0.035000,0.406400> rotate<0,0.000000,0> translate<15.519397,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.604481,-1.535000,36.988675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.977903,-1.535000,36.834000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<15.604481,-1.535000,36.988675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.632334,0.000000,24.173516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<16.201803,0.000000,24.409397>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-22.498478,0> translate<15.632334,0.000000,24.173516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.678581,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.332816,0.000000,26.822400>}
box{<0,0,-0.406400><7.654234,0.035000,0.406400> rotate<0,0.000000,0> translate<15.678581,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.693903,-1.535000,34.784997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.406094,-1.535000,34.784997>}
box{<0,0,-0.406400><1.712191,0.035000,0.406400> rotate<0,0.000000,0> translate<15.693903,-1.535000,34.784997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.881781,0.000000,27.025600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.803194,0.000000,27.025600>}
box{<0,0,-0.406400><7.921413,0.035000,0.406400> rotate<0,0.000000,0> translate<15.881781,0.000000,27.025600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<15.977903,-1.535000,36.834000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.682094,-1.535000,36.834000>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,0.000000,0> translate<15.977903,-1.535000,36.834000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<16.201803,0.000000,24.409397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.830713,0.000000,24.409397>}
box{<0,0,-0.406400><6.628909,0.035000,0.406400> rotate<0,0.000000,0> translate<16.201803,0.000000,24.409397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.042094,-1.535000,1.994000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.415516,-1.535000,2.148675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<17.042094,-1.535000,1.994000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.406094,-1.535000,34.784997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.552806,-1.535000,34.724225>}
box{<0,0,-0.406400><0.158801,0.035000,0.406400> rotate<0,22.499038,0> translate<17.406094,-1.535000,34.784997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.415516,-1.535000,2.148675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.527441,-1.535000,2.260600>}
box{<0,0,-0.406400><0.158286,0.035000,0.406400> rotate<0,-44.997030,0> translate<17.415516,-1.535000,2.148675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.527441,-1.535000,2.260600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.722556,-1.535000,2.260600>}
box{<0,0,-0.406400><3.195116,0.035000,0.406400> rotate<0,0.000000,0> translate<17.527441,-1.535000,2.260600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.552806,-1.535000,34.724225>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.736481,-1.535000,35.167662>}
box{<0,0,-0.406400><0.479972,0.035000,0.406400> rotate<0,-67.495857,0> translate<17.552806,-1.535000,34.724225> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.682094,-1.535000,36.834000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.779997,-1.535000,36.874553>}
box{<0,0,-0.406400><0.105970,0.035000,0.406400> rotate<0,-22.498676,0> translate<17.682094,-1.535000,36.834000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.736481,-1.535000,35.167662>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.172334,-1.535000,35.603516>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,-44.997030,0> translate<17.736481,-1.535000,35.167662> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.779997,-1.535000,36.874553>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.877903,-1.535000,36.834000>}
box{<0,0,-0.406400><0.105973,0.035000,0.406400> rotate<0,22.498030,0> translate<17.779997,-1.535000,36.874553> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<17.877903,-1.535000,36.834000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.582094,-1.535000,36.834000>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,0.000000,0> translate<17.877903,-1.535000,36.834000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.059397,-1.535000,27.311781>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.059397,-1.535000,29.289600>}
box{<0,0,-0.406400><1.977819,0.035000,0.406400> rotate<0,90.000000,0> translate<18.059397,-1.535000,29.289600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.059397,-1.535000,27.311781>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.414997,-1.535000,26.956178>}
box{<0,0,-0.406400><0.502897,0.035000,0.406400> rotate<0,44.997282,0> translate<18.059397,-1.535000,27.311781> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.059397,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.450600,-1.535000,27.635200>}
box{<0,0,-0.406400><0.391203,0.035000,0.406400> rotate<0,0.000000,0> translate<18.059397,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.059397,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.450600,-1.535000,28.448000>}
box{<0,0,-0.406400><0.391203,0.035000,0.406400> rotate<0,0.000000,0> translate<18.059397,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.059397,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.450600,-1.535000,29.260800>}
box{<0,0,-0.406400><0.391203,0.035000,0.406400> rotate<0,0.000000,0> translate<18.059397,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.059397,-1.535000,29.289600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.099981,-1.535000,29.289600>}
box{<0,0,-0.406400><0.040584,0.035000,0.406400> rotate<0,0.000000,0> translate<18.059397,-1.535000,29.289600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.099981,-1.535000,29.289600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.099981,-1.535000,30.649966>}
box{<0,0,-0.406400><1.360366,0.035000,0.406400> rotate<0,90.000000,0> translate<18.099981,-1.535000,30.649966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.099981,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.100013,-1.535000,30.073600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<18.099981,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.099981,-1.535000,30.649966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.100013,-1.535000,30.649966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<18.099981,-1.535000,30.649966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.100013,-1.535000,29.289600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.450600,-1.535000,29.289600>}
box{<0,0,-0.406400><0.350587,0.035000,0.406400> rotate<0,0.000000,0> translate<18.100013,-1.535000,29.289600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.100013,-1.535000,30.649966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.100013,-1.535000,29.289600>}
box{<0,0,-0.406400><1.360366,0.035000,0.406400> rotate<0,-90.000000,0> translate<18.100013,-1.535000,29.289600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.172334,-1.535000,35.603516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.124834,-1.535000,36.556016>}
box{<0,0,-0.406400><1.347038,0.035000,0.406400> rotate<0,-44.997030,0> translate<18.172334,-1.535000,35.603516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.414997,-1.535000,26.956178>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.450600,-1.535000,26.991781>}
box{<0,0,-0.406400><0.050350,0.035000,0.406400> rotate<0,-44.997030,0> translate<18.414997,-1.535000,26.956178> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.450600,-1.535000,29.289600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<18.450600,-1.535000,26.991781>}
box{<0,0,-0.406400><2.297819,0.035000,0.406400> rotate<0,-90.000000,0> translate<18.450600,-1.535000,26.991781> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.124834,-1.535000,36.556016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.694303,-1.535000,36.791897>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-22.498478,0> translate<19.124834,-1.535000,36.556016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.582094,-1.535000,36.834000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.955516,-1.535000,36.988675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<19.582094,-1.535000,36.834000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.694303,-1.535000,36.791897>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.485694,-1.535000,36.791897>}
box{<0,0,-0.406400><3.791391,0.035000,0.406400> rotate<0,0.000000,0> translate<19.694303,-1.535000,36.791897> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<19.955516,-1.535000,36.988675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.067441,-1.535000,37.100600>}
box{<0,0,-0.406400><0.158286,0.035000,0.406400> rotate<0,-44.997030,0> translate<19.955516,-1.535000,36.988675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.067441,-1.535000,37.100600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.528194,-1.535000,37.100600>}
box{<0,0,-0.406400><7.460753,0.035000,0.406400> rotate<0,0.000000,0> translate<20.067441,-1.535000,37.100600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.694294,0.000000,39.997000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.067716,0.000000,40.151675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<20.694294,0.000000,39.997000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.694294,0.000000,44.213397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.067716,0.000000,44.058722>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<20.694294,0.000000,44.213397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.722556,-1.535000,2.260600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.784481,-1.535000,2.198675>}
box{<0,0,-0.406400><0.087575,0.035000,0.406400> rotate<0,44.997030,0> translate<20.722556,-1.535000,2.260600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.784481,-1.535000,2.198675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.157903,-1.535000,2.044000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<20.784481,-1.535000,2.198675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<20.945694,0.000000,36.791897>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.515163,0.000000,36.556016>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,22.498478,0> translate<20.945694,0.000000,36.791897> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.067716,0.000000,40.151675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.353522,0.000000,40.437481>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,-44.997030,0> translate<21.067716,0.000000,40.151675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.067716,0.000000,44.058722>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.353522,0.000000,43.772916>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,44.997030,0> translate<21.067716,0.000000,44.058722> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.157903,-1.535000,2.044000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.862094,-1.535000,2.044000>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,0.000000,0> translate<21.157903,-1.535000,2.044000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.235238,0.000000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.584000,0.000000,43.891200>}
box{<0,0,-0.406400><1.348762,0.035000,0.406400> rotate<0,0.000000,0> translate<21.235238,0.000000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.353522,0.000000,40.437481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.508197,0.000000,40.810903>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<21.353522,0.000000,40.437481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.353522,0.000000,43.772916>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.508197,0.000000,43.399494>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,67.495729,0> translate<21.353522,0.000000,43.772916> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.437406,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,40.640000>}
box{<0,0,-0.406400><2.413194,0.035000,0.406400> rotate<0,0.000000,0> translate<21.437406,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.466919,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,36.576000>}
box{<0,0,-0.406400><0.351681,0.035000,0.406400> rotate<0,0.000000,0> translate<21.466919,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.508197,0.000000,40.810903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.508197,0.000000,43.399494>}
box{<0,0,-0.406400><2.588591,0.035000,0.406400> rotate<0,90.000000,0> translate<21.508197,0.000000,43.399494> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.508197,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.728600,0.000000,41.452800>}
box{<0,0,-0.406400><1.220403,0.035000,0.406400> rotate<0,0.000000,0> translate<21.508197,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.508197,0.000000,42.265600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.584000,0.000000,42.265600>}
box{<0,0,-0.406400><1.075803,0.035000,0.406400> rotate<0,0.000000,0> translate<21.508197,0.000000,42.265600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.508197,0.000000,43.078400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.584000,0.000000,43.078400>}
box{<0,0,-0.406400><1.075803,0.035000,0.406400> rotate<0,0.000000,0> translate<21.508197,0.000000,43.078400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.515163,0.000000,36.556016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,36.252575>}
box{<0,0,-0.406400><0.429128,0.035000,0.406400> rotate<0,44.997325,0> translate<21.515163,0.000000,36.556016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,36.906181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,36.252575>}
box{<0,0,-0.406400><0.653606,0.035000,0.406400> rotate<0,-90.000000,0> translate<21.818600,0.000000,36.252575> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,36.906181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088566,0.000000,36.906181>}
box{<0,0,-0.406400><1.269966,0.035000,0.406400> rotate<0,0.000000,0> translate<21.818600,0.000000,36.906181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,36.906213>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088566,0.000000,36.906213>}
box{<0,0,-0.406400><1.269966,0.035000,0.406400> rotate<0,0.000000,0> translate<21.818600,0.000000,36.906213> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,38.088844>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,36.906213>}
box{<0,0,-0.406400><1.182631,0.035000,0.406400> rotate<0,-90.000000,0> translate<21.818600,0.000000,36.906213> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.818600,0.000000,38.088844>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.843978,0.000000,38.216431>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<21.818600,0.000000,38.088844> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.843978,0.000000,38.216431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.893759,0.000000,38.336616>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<21.843978,0.000000,38.216431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.893759,0.000000,38.336616>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.966034,0.000000,38.444778>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<21.893759,0.000000,38.336616> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<21.966034,0.000000,38.444778>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.058019,0.000000,38.536763>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<21.966034,0.000000,38.444778> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.058019,0.000000,38.536763>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.166181,0.000000,38.609037>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<22.058019,0.000000,38.536763> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.166181,0.000000,38.609037>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.286366,0.000000,38.658819>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<22.166181,0.000000,38.609037> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.286366,0.000000,38.658819>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.413953,0.000000,38.684197>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<22.286366,0.000000,38.658819> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.413953,0.000000,38.684197>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,38.684197>}
box{<0,0,-0.406400><0.674628,0.035000,0.406400> rotate<0,0.000000,0> translate<22.413953,0.000000,38.684197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.510800,0.000000,25.077919>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.757309,0.000000,24.482797>}
box{<0,0,-0.406400><0.644156,0.035000,0.406400> rotate<0,67.495395,0> translate<22.510800,0.000000,25.077919> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.510800,0.000000,25.722078>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.510800,0.000000,25.077919>}
box{<0,0,-0.406400><0.644159,0.035000,0.406400> rotate<0,-90.000000,0> translate<22.510800,0.000000,25.077919> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.510800,0.000000,25.722078>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.757309,0.000000,26.317200>}
box{<0,0,-0.406400><0.644156,0.035000,0.406400> rotate<0,-67.495395,0> translate<22.510800,0.000000,25.722078> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.584000,0.000000,41.801903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.738675,0.000000,41.428481>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,67.495729,0> translate<22.584000,0.000000,41.801903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.584000,0.000000,44.406094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.584000,0.000000,41.801903>}
box{<0,0,-0.406400><2.604191,0.035000,0.406400> rotate<0,-90.000000,0> translate<22.584000,0.000000,41.801903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.584000,0.000000,44.406094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.738675,0.000000,44.779516>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<22.584000,0.000000,44.406094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.738675,0.000000,41.428481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.024481,0.000000,41.142675>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,44.997030,0> translate<22.738675,0.000000,41.428481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.738675,0.000000,44.779516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.024481,0.000000,45.065322>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,-44.997030,0> translate<22.738675,0.000000,44.779516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.757309,0.000000,24.482797>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.830713,0.000000,24.409397>}
box{<0,0,-0.406400><0.103805,0.035000,0.406400> rotate<0,44.995811,0> translate<22.757309,0.000000,24.482797> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.757309,0.000000,26.317200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.212797,0.000000,26.772687>}
box{<0,0,-0.406400><0.644157,0.035000,0.406400> rotate<0,-44.997030,0> translate<22.757309,0.000000,26.317200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.862094,-1.535000,2.044000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.235516,-1.535000,2.198675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<22.862094,-1.535000,2.044000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.896428,0.000000,35.128200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,35.128200>}
box{<0,0,-0.406400><0.192153,0.035000,0.406400> rotate<0,0.000000,0> translate<22.896428,0.000000,35.128200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.896428,0.000000,35.128200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.099397,0.000000,34.638194>}
box{<0,0,-0.406400><0.530380,0.035000,0.406400> rotate<0,67.495394,0> translate<22.896428,0.000000,35.128200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<22.970078,0.000000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,34.950400>}
box{<0,0,-0.406400><0.880522,0.035000,0.406400> rotate<0,0.000000,0> translate<22.970078,0.000000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.024481,0.000000,41.142675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397903,0.000000,40.988000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<23.024481,0.000000,41.142675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.024481,0.000000,45.065322>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397903,0.000000,45.219997>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<23.024481,0.000000,45.065322> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088566,0.000000,36.906213>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088566,0.000000,36.906181>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<23.088566,0.000000,36.906181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,35.128200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,36.906166>}
box{<0,0,-0.406400><1.777966,0.035000,0.406400> rotate<0,90.000000,0> translate<23.088581,0.000000,36.906166> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,35.763200>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.088581,0.000000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,36.576000>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.088581,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,36.906166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,36.906166>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.088581,0.000000,36.906166> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,36.906231>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,38.684197>}
box{<0,0,-0.406400><1.777966,0.035000,0.406400> rotate<0,90.000000,0> translate<23.088581,0.000000,38.684197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,36.906231>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,36.906231>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.088581,0.000000,36.906231> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,37.388800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,37.388800>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.088581,0.000000,37.388800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088581,0.000000,38.201600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,38.201600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.088581,0.000000,38.201600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,35.128200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.763244,0.000000,35.128200>}
box{<0,0,-0.406400><0.674631,0.035000,0.406400> rotate<0,0.000000,0> translate<23.088612,0.000000,35.128200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,36.906166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,35.128200>}
box{<0,0,-0.406400><1.777966,0.035000,0.406400> rotate<0,-90.000000,0> translate<23.088612,0.000000,35.128200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,38.684194>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,36.906231>}
box{<0,0,-0.406400><1.777962,0.035000,0.406400> rotate<0,-90.000000,0> translate<23.088612,0.000000,36.906231> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.088612,0.000000,38.684194>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.763244,0.000000,38.684197>}
box{<0,0,-0.406400><0.674631,0.035000,0.406400> rotate<0,-0.000265,0> translate<23.088612,0.000000,38.684194> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.099397,0.000000,34.262250>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.099397,0.000000,34.638194>}
box{<0,0,-0.406400><0.375944,0.035000,0.406400> rotate<0,90.000000,0> translate<23.099397,0.000000,34.638194> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.099397,0.000000,34.262250>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.219997,0.000000,33.971094>}
box{<0,0,-0.406400><0.315145,0.035000,0.406400> rotate<0,67.495691,0> translate<23.099397,0.000000,34.262250> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.151031,0.000000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,34.137600>}
box{<0,0,-0.406400><0.699569,0.035000,0.406400> rotate<0,0.000000,0> translate<23.151031,0.000000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.212797,0.000000,26.772687>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.807919,0.000000,27.019197>}
box{<0,0,-0.406400><0.644156,0.035000,0.406400> rotate<0,-22.498665,0> translate<23.212797,0.000000,26.772687> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.219997,0.000000,33.031175>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.219997,0.000000,33.971094>}
box{<0,0,-0.406400><0.939919,0.035000,0.406400> rotate<0,90.000000,0> translate<23.219997,0.000000,33.971094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.219997,0.000000,33.031175>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,33.661781>}
box{<0,0,-0.406400><0.891810,0.035000,0.406400> rotate<0,-44.997172,0> translate<23.219997,0.000000,33.031175> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.219997,0.000000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.513622,0.000000,33.324800>}
box{<0,0,-0.406400><0.293625,0.035000,0.406400> rotate<0,0.000000,0> translate<23.219997,0.000000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.235516,-1.535000,2.198675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.436441,-1.535000,2.399600>}
box{<0,0,-0.406400><0.284151,0.035000,0.406400> rotate<0,-44.997030,0> translate<23.235516,-1.535000,2.198675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397903,0.000000,40.988000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,40.988000>}
box{<0,0,-0.406400><0.452697,0.035000,0.406400> rotate<0,0.000000,0> translate<23.397903,0.000000,40.988000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.397903,0.000000,45.219997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.041884,0.000000,45.219997>}
box{<0,0,-0.406400><0.643981,0.035000,0.406400> rotate<0,0.000000,0> translate<23.397903,0.000000,45.219997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.436441,-1.535000,2.399600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.709981,-1.535000,2.399600>}
box{<0,0,-0.406400><0.273541,0.035000,0.406400> rotate<0,0.000000,0> translate<23.436441,-1.535000,2.399600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.485694,-1.535000,36.791897>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.055163,-1.535000,36.556016>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,22.498478,0> translate<23.485694,-1.535000,36.791897> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.709981,-1.535000,2.399600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.709981,-1.535000,3.809966>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,90.000000,0> translate<23.709981,-1.535000,3.809966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.709981,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710013,-1.535000,2.438400>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.709981,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.709981,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710013,-1.535000,3.251200>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.709981,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.709981,-1.535000,3.809966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710013,-1.535000,3.809966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.709981,-1.535000,3.809966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710013,-1.535000,2.399600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.425044,-1.535000,2.399600>}
box{<0,0,-0.406400><0.715031,0.035000,0.406400> rotate<0,0.000000,0> translate<23.710013,-1.535000,2.399600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710013,-1.535000,3.809966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710013,-1.535000,2.399600>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,-90.000000,0> translate<23.710013,-1.535000,2.399600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710031,-1.535000,3.809981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710031,-1.535000,3.810013>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<23.710031,-1.535000,3.810013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710031,-1.535000,3.809981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,3.809981>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,0.000000,0> translate<23.710031,-1.535000,3.809981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.710031,-1.535000,3.810013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,3.810013>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,0.000000,0> translate<23.710031,-1.535000,3.810013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.763244,0.000000,35.128200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,35.145578>}
box{<0,0,-0.406400><0.089068,0.035000,0.406400> rotate<0,-11.250448,0> translate<23.763244,0.000000,35.128200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.763244,0.000000,38.684197>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,38.666819>}
box{<0,0,-0.406400><0.089068,0.035000,0.406400> rotate<0,11.250448,0> translate<23.763244,0.000000,38.684197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.803194,0.000000,27.025600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.372663,0.000000,27.261481>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-22.498478,0> translate<23.803194,0.000000,27.025600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.807919,0.000000,27.019197>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.452078,0.000000,27.019197>}
box{<0,0,-0.406400><0.644159,0.035000,0.406400> rotate<0,0.000000,0> translate<23.807919,0.000000,27.019197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,35.145578>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,33.661781>}
box{<0,0,-0.406400><1.483797,0.035000,0.406400> rotate<0,-90.000000,0> translate<23.850600,0.000000,33.661781> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,40.988000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<23.850600,0.000000,38.666819>}
box{<0,0,-0.406400><2.321181,0.035000,0.406400> rotate<0,-90.000000,0> translate<23.850600,0.000000,38.666819> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.006919,-1.535000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.565316,-1.535000,36.576000>}
box{<0,0,-0.406400><5.558397,0.035000,0.406400> rotate<0,0.000000,0> translate<24.006919,-1.535000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.041884,0.000000,45.219997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.086481,0.000000,45.327663>}
box{<0,0,-0.406400><0.116537,0.035000,0.406400> rotate<0,-67.495403,0> translate<24.041884,0.000000,45.219997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.055163,-1.535000,36.556016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.491016,-1.535000,36.120162>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,44.997030,0> translate<24.055163,-1.535000,36.556016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.086481,0.000000,45.327663>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.522334,0.000000,45.763516>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,-44.997030,0> translate<24.086481,0.000000,45.327663> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.372663,0.000000,27.261481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.817663,0.000000,31.706481>}
box{<0,0,-0.406400><6.286179,0.035000,0.406400> rotate<0,-44.997030,0> translate<24.372663,0.000000,27.261481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.425044,-1.535000,2.399600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.552631,-1.535000,2.424978>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<24.425044,-1.535000,2.399600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.452078,0.000000,27.019197>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.047200,0.000000,26.772687>}
box{<0,0,-0.406400><0.644156,0.035000,0.406400> rotate<0,22.498665,0> translate<24.452078,0.000000,27.019197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.491016,-1.535000,36.120162>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.443516,-1.535000,35.167662>}
box{<0,0,-0.406400><1.347038,0.035000,0.406400> rotate<0,44.997030,0> translate<24.491016,-1.535000,36.120162> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.522334,0.000000,45.763516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.522338,0.000000,45.763516>}
box{<0,0,-0.406400><0.000003,0.035000,0.406400> rotate<0,0.000000,0> translate<24.522334,0.000000,45.763516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.522338,0.000000,45.763516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.732822,0.000000,45.974000>}
box{<0,0,-0.406400><0.297670,0.035000,0.406400> rotate<0,-44.997030,0> translate<24.522338,0.000000,45.763516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.552631,-1.535000,2.424978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.672816,-1.535000,2.474759>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<24.552631,-1.535000,2.424978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.585034,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.873375,-1.535000,2.438400>}
box{<0,0,-0.406400><1.288341,0.035000,0.406400> rotate<0,0.000000,0> translate<24.585034,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.672816,-1.535000,2.474759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.780978,-1.535000,2.547034>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<24.672816,-1.535000,2.474759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.746381,0.000000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,0.000000,27.635200>}
box{<0,0,-0.406400><4.391619,0.035000,0.406400> rotate<0,0.000000,0> translate<24.746381,0.000000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.780978,-1.535000,2.547034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.872962,-1.535000,2.639019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<24.780978,-1.535000,2.547034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.847978,-1.535000,35.763200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.495800,-1.535000,35.763200>}
box{<0,0,-0.406400><4.647822,0.035000,0.406400> rotate<0,0.000000,0> translate<24.847978,-1.535000,35.763200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.872962,-1.535000,2.639019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.945238,-1.535000,2.747181>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<24.872962,-1.535000,2.639019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.927184,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.327878,0.000000,26.822400>}
box{<0,0,-0.406400><4.400694,0.035000,0.406400> rotate<0,0.000000,0> translate<24.927184,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.945238,-1.535000,2.747181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.995019,-1.535000,2.867366>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<24.945238,-1.535000,2.747181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.950575,0.000000,23.595600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.642663,0.000000,22.903516>}
box{<0,0,-0.406400><0.978757,0.035000,0.406400> rotate<0,44.996901,0> translate<24.950575,0.000000,23.595600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.950575,0.000000,23.595600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.845719,0.000000,23.595600>}
box{<0,0,-0.406400><4.895144,0.035000,0.406400> rotate<0,0.000000,0> translate<24.950575,0.000000,23.595600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.974978,0.000000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.870116,0.000000,23.571200>}
box{<0,0,-0.406400><4.895138,0.035000,0.406400> rotate<0,0.000000,0> translate<24.974978,0.000000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<24.995019,-1.535000,2.867366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,2.994953>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<24.995019,-1.535000,2.867366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,2.994953>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,3.809981>}
box{<0,0,-0.406400><0.815028,0.035000,0.406400> rotate<0,90.000000,0> translate<25.020397,-1.535000,3.809981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,3.251200>}
box{<0,0,-0.406400><0.415203,0.035000,0.406400> rotate<0,0.000000,0> translate<25.020397,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,3.810013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,4.399000>}
box{<0,0,-0.406400><0.588987,0.035000,0.406400> rotate<0,90.000000,0> translate<25.020397,-1.535000,4.399000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,4.064000>}
box{<0,0,-0.406400><0.415203,0.035000,0.406400> rotate<0,0.000000,0> translate<25.020397,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.020397,-1.535000,4.399000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,4.399000>}
box{<0,0,-0.406400><0.415203,0.035000,0.406400> rotate<0,0.000000,0> translate<25.020397,-1.535000,4.399000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.047200,0.000000,26.772687>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.125488,0.000000,26.694397>}
box{<0,0,-0.406400><0.110717,0.035000,0.406400> rotate<0,44.998174,0> translate<25.047200,0.000000,26.772687> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.125488,0.000000,26.694397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.380900,0.000000,26.694397>}
box{<0,0,-0.406400><4.255412,0.035000,0.406400> rotate<0,0.000000,0> translate<25.125488,0.000000,26.694397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,2.995953>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.460978,0.000000,2.868366>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<25.435600,0.000000,2.995953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,2.995953>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.460978,-1.535000,2.868366>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<25.435600,-1.535000,2.995953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,2.995953>}
box{<0,0,-0.406400><0.719028,0.035000,0.406400> rotate<0,-90.000000,0> translate<25.435600,0.000000,2.995953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,2.995953>}
box{<0,0,-0.406400><0.719028,0.035000,0.406400> rotate<0,-90.000000,0> translate<25.435600,-1.535000,2.995953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,0.000000,3.714981>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,0.000000,0> translate<25.435600,0.000000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,-1.535000,3.714981>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,0.000000,0> translate<25.435600,-1.535000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,0.000000,3.715013>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,0.000000,0> translate<25.435600,0.000000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,-1.535000,3.715013>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,0.000000,0> translate<25.435600,-1.535000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,4.399000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,0.000000,3.715013>}
box{<0,0,-0.406400><0.683987,0.035000,0.406400> rotate<0,-90.000000,0> translate<25.435600,0.000000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,4.399000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.435600,-1.535000,3.715013>}
box{<0,0,-0.406400><0.683987,0.035000,0.406400> rotate<0,-90.000000,0> translate<25.435600,-1.535000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.443516,-1.535000,35.167662>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,34.598194>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,67.495582,0> translate<25.443516,-1.535000,35.167662> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.460978,0.000000,2.868366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.510759,0.000000,2.748181>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<25.460978,0.000000,2.868366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.460978,-1.535000,2.868366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.510759,-1.535000,2.748181>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<25.460978,-1.535000,2.868366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.510759,0.000000,2.748181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.583034,0.000000,2.640019>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<25.510759,0.000000,2.748181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.510759,-1.535000,2.748181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.583034,-1.535000,2.640019>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<25.510759,-1.535000,2.748181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.533509,-1.535000,34.950400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.589963,-1.535000,34.950400>}
box{<0,0,-0.406400><4.056453,0.035000,0.406400> rotate<0,0.000000,0> translate<25.533509,-1.535000,34.950400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.559181,0.000000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.286625,0.000000,28.448000>}
box{<0,0,-0.406400><3.727444,0.035000,0.406400> rotate<0,0.000000,0> translate<25.559181,0.000000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.583034,0.000000,2.640019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.675019,0.000000,2.548034>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<25.583034,0.000000,2.640019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.583034,-1.535000,2.640019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.675019,-1.535000,2.548034>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<25.583034,-1.535000,2.640019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.642663,0.000000,22.903516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.078516,0.000000,22.467662>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,44.997030,0> translate<25.642663,0.000000,22.903516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.675019,0.000000,2.548034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.783181,0.000000,2.475759>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<25.675019,0.000000,2.548034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.675019,-1.535000,2.548034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.783181,-1.535000,2.475759>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<25.675019,-1.535000,2.548034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,29.175397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,34.598194>}
box{<0,0,-0.406400><5.422797,0.035000,0.406400> rotate<0,90.000000,0> translate<25.679397,-1.535000,34.598194> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,29.175397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,29.175397>}
box{<0,0,-0.406400><0.870584,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,29.175397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,29.260800>}
box{<0,0,-0.406400><3.914203,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,30.073600>}
box{<0,0,-0.406400><3.914203,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,30.886400>}
box{<0,0,-0.406400><0.850203,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,31.699200>}
box{<0,0,-0.406400><0.850203,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.174000,-1.535000,32.512000>}
box{<0,0,-0.406400><0.494603,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,33.324800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.174000,-1.535000,33.324800>}
box{<0,0,-0.406400><0.494603,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,33.324800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.679397,-1.535000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.194922,-1.535000,34.137600>}
box{<0,0,-0.406400><0.515525,0.035000,0.406400> rotate<0,0.000000,0> translate<25.679397,-1.535000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.783181,0.000000,2.475759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.903366,0.000000,2.425978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<25.783181,0.000000,2.475759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.783181,-1.535000,2.475759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.903366,-1.535000,2.425978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<25.783181,-1.535000,2.475759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.787778,0.000000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.447553,0.000000,22.758400>}
box{<0,0,-0.406400><5.659775,0.035000,0.406400> rotate<0,0.000000,0> translate<25.787778,0.000000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.903366,0.000000,2.425978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.030953,0.000000,2.400600>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<25.903366,0.000000,2.425978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<25.903366,-1.535000,2.425978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.030953,-1.535000,2.400600>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<25.903366,-1.535000,2.425978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.030953,0.000000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,0.000000,2.400600>}
box{<0,0,-0.406400><0.719028,0.035000,0.406400> rotate<0,0.000000,0> translate<26.030953,0.000000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.030953,-1.535000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,-1.535000,2.400600>}
box{<0,0,-0.406400><0.719028,0.035000,0.406400> rotate<0,0.000000,0> translate<26.030953,-1.535000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.078516,0.000000,22.467662>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.314397,0.000000,21.898194>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,67.495582,0> translate<26.078516,0.000000,22.467662> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.174000,-1.535000,32.382903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.328675,-1.535000,32.009481>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,67.495729,0> translate<26.174000,-1.535000,32.382903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.174000,-1.535000,34.087094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.174000,-1.535000,32.382903>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.174000,-1.535000,32.382903> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.174000,-1.535000,34.087094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.328675,-1.535000,34.460516>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<26.174000,-1.535000,34.087094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.294763,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.945600>}
box{<0,0,-0.406400><2.774838,0.035000,0.406400> rotate<0,0.000000,0> translate<26.294763,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.314397,0.000000,20.961781>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.314397,0.000000,21.898194>}
box{<0,0,-0.406400><0.936412,0.035000,0.406400> rotate<0,90.000000,0> translate<26.314397,0.000000,21.898194> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.314397,0.000000,20.961781>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.356781,0.000000,20.919397>}
box{<0,0,-0.406400><0.059941,0.035000,0.406400> rotate<0,44.997030,0> translate<26.314397,0.000000,20.961781> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.314397,0.000000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.132800>}
box{<0,0,-0.406400><2.755203,0.035000,0.406400> rotate<0,0.000000,0> translate<26.314397,0.000000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.328675,-1.535000,32.009481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,31.808556>}
box{<0,0,-0.406400><0.284151,0.035000,0.406400> rotate<0,44.997030,0> translate<26.328675,-1.535000,32.009481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.328675,-1.535000,34.460516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.614481,-1.535000,34.746322>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,-44.997030,0> translate<26.328675,-1.535000,34.460516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.356781,0.000000,20.919397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,20.919397>}
box{<0,0,-0.406400><2.712819,0.035000,0.406400> rotate<0,0.000000,0> translate<26.356781,0.000000,20.919397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.371981,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.872119,0.000000,29.260800>}
box{<0,0,-0.406400><3.500138,0.035000,0.406400> rotate<0,0.000000,0> translate<26.371981,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,30.819953>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.554978,-1.535000,30.692366>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<26.529600,-1.535000,30.819953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,31.534981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,30.819953>}
box{<0,0,-0.406400><0.715028,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.529600,-1.535000,30.819953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,31.534981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939966,-1.535000,31.534981>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<26.529600,-1.535000,31.534981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,31.535013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939966,-1.535000,31.535013>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<26.529600,-1.535000,31.535013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,31.808556>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.529600,-1.535000,31.535013>}
box{<0,0,-0.406400><0.273544,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.529600,-1.535000,31.535013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,25.915031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,26.654600>}
box{<0,0,-0.406400><0.739569,0.035000,0.406400> rotate<0,90.000000,0> translate<26.549981,-1.535000,26.654600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,25.915031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,25.915031>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.549981,-1.535000,25.915031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,26.009600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.549981,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,26.654600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,27.914966>}
box{<0,0,-0.406400><1.260366,0.035000,0.406400> rotate<0,90.000000,0> translate<26.549981,-1.535000,27.914966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,26.822400>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.549981,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,27.635200>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.549981,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,27.914966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,27.914966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.549981,-1.535000,27.914966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,27.915031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,29.175397>}
box{<0,0,-0.406400><1.260366,0.035000,0.406400> rotate<0,90.000000,0> translate<26.549981,-1.535000,29.175397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,27.915031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,27.915031>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.549981,-1.535000,27.915031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.549981,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,28.448000>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.549981,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,27.914966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,25.915031>}
box{<0,0,-0.406400><1.999934,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.550013,-1.535000,25.915031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,29.175397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,27.915031>}
box{<0,0,-0.406400><1.260366,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.550013,-1.535000,27.915031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550013,-1.535000,29.175397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.615044,-1.535000,29.175397>}
box{<0,0,-0.406400><1.065031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.550013,-1.535000,29.175397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,25.914981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,25.915012>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<26.550031,-1.535000,25.915012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,25.914981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210394,-1.535000,25.914981>}
box{<0,0,-0.406400><1.660363,0.035000,0.406400> rotate<0,0.000000,0> translate<26.550031,-1.535000,25.914981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,25.915012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,25.915012>}
box{<0,0,-0.406400><1.660366,0.035000,0.406400> rotate<0,0.000000,0> translate<26.550031,-1.535000,25.915012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,27.914981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,27.915012>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<26.550031,-1.535000,27.915012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,27.914981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210394,-1.535000,27.914981>}
box{<0,0,-0.406400><1.660363,0.035000,0.406400> rotate<0,0.000000,0> translate<26.550031,-1.535000,27.914981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.550031,-1.535000,27.915012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,27.915012>}
box{<0,0,-0.406400><1.660366,0.035000,0.406400> rotate<0,0.000000,0> translate<26.550031,-1.535000,27.915012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.554978,-1.535000,30.692366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.604759,-1.535000,30.572181>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<26.554978,-1.535000,30.692366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.604759,-1.535000,30.572181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.677034,-1.535000,30.464019>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<26.604759,-1.535000,30.572181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.614481,-1.535000,34.746322>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.987903,-1.535000,34.900997>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<26.614481,-1.535000,34.746322> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.677034,-1.535000,30.464019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.769019,-1.535000,30.372034>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<26.677034,-1.535000,30.464019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,0.000000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,0.000000,3.714981>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.749966,0.000000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,-1.535000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749966,-1.535000,3.714981>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.749966,-1.535000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,0.000000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,0.000000,3.714966>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,90.000000,0> translate<26.749981,0.000000,3.714966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,-1.535000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,-1.535000,3.714966>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,90.000000,0> translate<26.749981,-1.535000,3.714966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,0.000000,2.438400>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.749981,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,-1.535000,2.438400>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.749981,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,0.000000,3.251200>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.749981,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,-1.535000,3.251200>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.749981,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,0.000000,3.714966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,0.000000,3.714966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.749981,0.000000,3.714966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.749981,-1.535000,3.714966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,-1.535000,3.714966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.749981,-1.535000,3.714966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,0.000000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.469044,0.000000,2.400600>}
box{<0,0,-0.406400><0.719031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.750013,0.000000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,-1.535000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.469044,-1.535000,2.400600>}
box{<0,0,-0.406400><0.719031,0.035000,0.406400> rotate<0,0.000000,0> translate<26.750013,-1.535000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,0.000000,3.714966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,0.000000,2.400600>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.750013,0.000000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,-1.535000,3.714966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750013,-1.535000,2.400600>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,-90.000000,0> translate<26.750013,-1.535000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,0.000000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,0.000000,3.715013>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<26.750031,0.000000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,-1.535000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,-1.535000,3.715013>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<26.750031,-1.535000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,0.000000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064394,0.000000,3.714981>}
box{<0,0,-0.406400><1.314362,0.035000,0.406400> rotate<0,0.000000,0> translate<26.750031,0.000000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,-1.535000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064394,-1.535000,3.714981>}
box{<0,0,-0.406400><1.314362,0.035000,0.406400> rotate<0,0.000000,0> translate<26.750031,-1.535000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,0.000000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,3.715013>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,0.000000,0> translate<26.750031,0.000000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.750031,-1.535000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,3.715013>}
box{<0,0,-0.406400><1.314366,0.035000,0.406400> rotate<0,0.000000,0> translate<26.750031,-1.535000,3.715013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.769019,-1.535000,30.372034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.877181,-1.535000,30.299759>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<26.769019,-1.535000,30.372034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.877181,-1.535000,30.299759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.997366,-1.535000,30.249978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<26.877181,-1.535000,30.299759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.987903,-1.535000,34.900997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.892094,-1.535000,34.900997>}
box{<0,0,-0.406400><1.904191,0.035000,0.406400> rotate<0,0.000000,0> translate<26.987903,-1.535000,34.900997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<26.997366,-1.535000,30.249978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.124953,-1.535000,30.224600>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<26.997366,-1.535000,30.249978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.124953,-1.535000,30.224600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939981,-1.535000,30.224600>}
box{<0,0,-0.406400><0.815028,0.035000,0.406400> rotate<0,0.000000,0> translate<27.124953,-1.535000,30.224600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.184781,0.000000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,30.073600>}
box{<0,0,-0.406400><5.555819,0.035000,0.406400> rotate<0,0.000000,0> translate<27.184781,0.000000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.469044,0.000000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.596631,0.000000,2.425978>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<27.469044,0.000000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.469044,-1.535000,2.400600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.596631,-1.535000,2.425978>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<27.469044,-1.535000,2.400600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.528194,-1.535000,37.100600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.097663,-1.535000,37.336481>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-22.498478,0> translate<27.528194,-1.535000,37.100600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.596631,0.000000,2.425978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.716816,0.000000,2.475759>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<27.596631,0.000000,2.425978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.596631,-1.535000,2.425978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.716816,-1.535000,2.475759>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<27.596631,-1.535000,2.425978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.615044,-1.535000,29.175397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.742631,-1.535000,29.150019>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<27.615044,-1.535000,29.175397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.626619,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.252397,0.000000,2.438400>}
box{<0,0,-0.406400><5.625778,0.035000,0.406400> rotate<0,0.000000,0> translate<27.626619,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.626619,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.252397,-1.535000,2.438400>}
box{<0,0,-0.406400><5.625778,0.035000,0.406400> rotate<0,0.000000,0> translate<27.626619,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.716816,0.000000,2.475759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.824978,0.000000,2.548034>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<27.716816,0.000000,2.475759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.716816,-1.535000,2.475759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.824978,-1.535000,2.548034>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<27.716816,-1.535000,2.475759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.742631,-1.535000,29.150019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.862816,-1.535000,29.100238>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<27.742631,-1.535000,29.150019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.824978,0.000000,2.548034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,0.000000,2.640019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<27.824978,0.000000,2.548034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.824978,-1.535000,2.548034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,-1.535000,2.640019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<27.824978,-1.535000,2.548034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.862816,-1.535000,29.100238>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.970978,-1.535000,29.027963>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<27.862816,-1.535000,29.100238> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.889388,0.000000,4.817550>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.911322,0.000000,4.839481>}
box{<0,0,-0.406400><0.031018,0.035000,0.406400> rotate<0,-44.992949,0> translate<27.889388,0.000000,4.817550> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.889388,-1.535000,4.817550>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.911322,-1.535000,4.839481>}
box{<0,0,-0.406400><0.031018,0.035000,0.406400> rotate<0,-44.992949,0> translate<27.889388,-1.535000,4.817550> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.889388,0.000000,4.817550>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,0.000000,4.789978>}
box{<0,0,-0.406400><0.038995,0.035000,0.406400> rotate<0,44.993784,0> translate<27.889388,0.000000,4.817550> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.889388,-1.535000,4.817550>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,-1.535000,4.789978>}
box{<0,0,-0.406400><0.038995,0.035000,0.406400> rotate<0,44.993784,0> translate<27.889388,-1.535000,4.817550> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.911322,0.000000,4.839481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,0.000000,5.212903>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<27.911322,0.000000,4.839481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.911322,-1.535000,4.839481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,-1.535000,5.212903>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<27.911322,-1.535000,4.839481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,0.000000,2.640019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,0.000000,2.748181>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<27.916963,0.000000,2.640019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,-1.535000,2.640019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,-1.535000,2.748181>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<27.916963,-1.535000,2.640019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,0.000000,4.789978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,0.000000,4.681816>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<27.916963,0.000000,4.789978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.916963,-1.535000,4.789978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,-1.535000,4.681816>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<27.916963,-1.535000,4.789978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.926778,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.054213,0.000000,4.876800>}
box{<0,0,-0.406400><2.127434,0.035000,0.406400> rotate<0,0.000000,0> translate<27.926778,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.926778,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.054213,-1.535000,4.876800>}
box{<0,0,-0.406400><2.127434,0.035000,0.406400> rotate<0,0.000000,0> translate<27.926778,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939966,-1.535000,31.535013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939966,-1.535000,31.534981>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<27.939966,-1.535000,31.534981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939981,-1.535000,30.224600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939981,-1.535000,31.534966>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,90.000000,0> translate<27.939981,-1.535000,31.534966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939981,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.940013,-1.535000,30.886400>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<27.939981,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.939981,-1.535000,31.534966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.940013,-1.535000,31.534966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<27.939981,-1.535000,31.534966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.940013,-1.535000,30.224600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.755044,-1.535000,30.224600>}
box{<0,0,-0.406400><0.815031,0.035000,0.406400> rotate<0,0.000000,0> translate<27.940013,-1.535000,30.224600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.940013,-1.535000,31.534966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.940013,-1.535000,30.224600>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,-90.000000,0> translate<27.940013,-1.535000,30.224600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.970978,-1.535000,29.027963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.062963,-1.535000,28.935978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<27.970978,-1.535000,29.027963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,0.000000,2.748181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,0.000000,2.868366>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<27.989238,0.000000,2.748181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,-1.535000,2.748181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,-1.535000,2.868366>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<27.989238,-1.535000,2.748181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,0.000000,4.681816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,0.000000,4.561631>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<27.989238,0.000000,4.681816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.989238,-1.535000,4.681816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,-1.535000,4.561631>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<27.989238,-1.535000,4.681816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<27.997581,0.000000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,30.886400>}
box{<0,0,-0.406400><4.743019,0.035000,0.406400> rotate<0,0.000000,0> translate<27.997581,0.000000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,0.000000,2.868366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,2.995953>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<28.039019,0.000000,2.868366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,-1.535000,2.868366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,2.995953>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<28.039019,-1.535000,2.868366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,0.000000,4.561631>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,4.434044>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<28.039019,0.000000,4.561631> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.039019,-1.535000,4.561631>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,4.434044>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<28.039019,-1.535000,4.561631> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.062963,-1.535000,28.935978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.135238,-1.535000,28.827816>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<28.062963,-1.535000,28.935978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064394,0.000000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,2.995953>}
box{<0,0,-0.406400><0.719028,0.035000,0.406400> rotate<0,89.993811,0> translate<28.064394,0.000000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064394,-1.535000,3.714981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,2.995953>}
box{<0,0,-0.406400><0.719028,0.035000,0.406400> rotate<0,89.993811,0> translate<28.064394,-1.535000,3.714981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.735750,0.000000,3.251200>}
box{<0,0,-0.406400><4.671353,0.035000,0.406400> rotate<0,0.000000,0> translate<28.064397,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.735750,-1.535000,3.251200>}
box{<0,0,-0.406400><4.671353,0.035000,0.406400> rotate<0,0.000000,0> translate<28.064397,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,4.434044>}
box{<0,0,-0.406400><0.719031,0.035000,0.406400> rotate<0,90.000000,0> translate<28.064397,0.000000,4.434044> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,3.715013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,4.434044>}
box{<0,0,-0.406400><0.719031,0.035000,0.406400> rotate<0,90.000000,0> translate<28.064397,-1.535000,4.434044> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.656556,0.000000,4.064000>}
box{<0,0,-0.406400><4.592159,0.035000,0.406400> rotate<0,0.000000,0> translate<28.064397,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.064397,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.656556,-1.535000,4.064000>}
box{<0,0,-0.406400><4.592159,0.035000,0.406400> rotate<0,0.000000,0> translate<28.064397,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,-1.535000,5.212903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,-1.535000,6.608744>}
box{<0,0,-0.406400><1.395841,0.035000,0.406400> rotate<0,90.000000,0> translate<28.065997,-1.535000,6.608744> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,0.000000,5.212903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,0.000000,7.878744>}
box{<0,0,-0.406400><2.665841,0.035000,0.406400> rotate<0,90.000000,0> translate<28.065997,0.000000,7.878744> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.985138,-1.535000,5.689600>}
box{<0,0,-0.406400><0.919141,0.035000,0.406400> rotate<0,0.000000,0> translate<28.065997,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.103978,0.000000,5.689600>}
box{<0,0,-0.406400><1.037981,0.035000,0.406400> rotate<0,0.000000,0> translate<28.065997,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.172338,-1.535000,6.502400>}
box{<0,0,-0.406400><0.106341,0.035000,0.406400> rotate<0,0.000000,0> translate<28.065997,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.956000,0.000000,6.502400>}
box{<0,0,-0.406400><0.890003,0.035000,0.406400> rotate<0,0.000000,0> translate<28.065997,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,-1.535000,6.608744>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.616722,-1.535000,5.058016>}
box{<0,0,-0.406400><2.193059,0.035000,0.406400> rotate<0,44.997088,0> translate<28.065997,-1.535000,6.608744> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.629538,0.000000,7.315200>}
box{<0,0,-0.406400><0.563541,0.035000,0.406400> rotate<0,0.000000,0> translate<28.065997,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.065997,0.000000,7.878744>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.956000,0.000000,6.988738>}
box{<0,0,-0.406400><1.258657,0.035000,0.406400> rotate<0,44.997131,0> translate<28.065997,0.000000,7.878744> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.076978,-1.535000,26.914997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.135238,-1.535000,26.827816>}
box{<0,0,-0.406400><0.104856,0.035000,0.406400> rotate<0,56.243232,0> translate<28.076978,-1.535000,26.914997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.076978,-1.535000,26.914997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.135238,-1.535000,27.002181>}
box{<0,0,-0.406400><0.104858,0.035000,0.406400> rotate<0,-56.244181,0> translate<28.076978,-1.535000,26.914997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.097663,-1.535000,37.336481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.688691,-1.535000,37.927512>}
box{<0,0,-0.406400><0.835842,0.035000,0.406400> rotate<0,-44.997182,0> translate<28.097663,-1.535000,37.336481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.135238,-1.535000,26.827816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.185019,-1.535000,26.707631>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<28.135238,-1.535000,26.827816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.135238,-1.535000,27.002181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.185019,-1.535000,27.122366>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<28.135238,-1.535000,27.002181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.135238,-1.535000,28.827816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.185019,-1.535000,28.707631>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<28.135238,-1.535000,28.827816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.137481,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.327878,-1.535000,26.822400>}
box{<0,0,-0.406400><1.190397,0.035000,0.406400> rotate<0,0.000000,0> translate<28.137481,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.149978,-1.535000,37.388800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.159541,-1.535000,37.388800>}
box{<0,0,-0.406400><1.009563,0.035000,0.406400> rotate<0,0.000000,0> translate<28.149978,-1.535000,37.388800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.185019,-1.535000,26.707631>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,26.580044>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<28.185019,-1.535000,26.707631> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.185019,-1.535000,27.122366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,27.249953>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<28.185019,-1.535000,27.122366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.185019,-1.535000,28.707631>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,28.580044>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<28.185019,-1.535000,28.707631> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210394,-1.535000,25.291441>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210394,-1.535000,25.914981>}
box{<0,0,-0.406400><0.623541,0.035000,0.406400> rotate<0,90.000000,0> translate<28.210394,-1.535000,25.914981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210394,-1.535000,25.291441>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.411322,-1.535000,25.090516>}
box{<0,0,-0.406400><0.284153,0.035000,0.406400> rotate<0,44.996585,0> translate<28.210394,-1.535000,25.291441> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210394,-1.535000,27.914981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,27.249953>}
box{<0,0,-0.406400><0.665028,0.035000,0.406400> rotate<0,89.993791,0> translate<28.210394,-1.535000,27.914981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,25.915012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,26.580044>}
box{<0,0,-0.406400><0.665031,0.035000,0.406400> rotate<0,90.000000,0> translate<28.210397,-1.535000,26.580044> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.328709,-1.535000,26.009600>}
box{<0,0,-0.406400><1.118313,0.035000,0.406400> rotate<0,0.000000,0> translate<28.210397,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,27.635200>}
box{<0,0,-0.406400><0.927603,0.035000,0.406400> rotate<0,0.000000,0> translate<28.210397,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,27.915012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,28.580044>}
box{<0,0,-0.406400><0.665031,0.035000,0.406400> rotate<0,90.000000,0> translate<28.210397,-1.535000,28.580044> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.210397,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.286625,-1.535000,28.448000>}
box{<0,0,-0.406400><1.076228,0.035000,0.406400> rotate<0,0.000000,0> translate<28.210397,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.305038,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,25.196800>}
box{<0,0,-0.406400><0.832963,0.035000,0.406400> rotate<0,0.000000,0> translate<28.305038,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.411322,-1.535000,25.090516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,24.717094>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,67.495729,0> translate<28.411322,-1.535000,25.090516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,16.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,16.717094>}
box{<0,0,-0.406400><0.214212,0.035000,0.406400> rotate<0,67.495657,0> translate<28.484022,-1.535000,16.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,16.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,17.112903>}
box{<0,0,-0.406400><0.214209,0.035000,0.406400> rotate<0,-67.495337,0> translate<28.484022,-1.535000,16.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,18.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,18.717094>}
box{<0,0,-0.406400><0.214212,0.035000,0.406400> rotate<0,67.495657,0> translate<28.484022,-1.535000,18.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,18.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,19.112903>}
box{<0,0,-0.406400><0.214209,0.035000,0.406400> rotate<0,-67.495337,0> translate<28.484022,-1.535000,18.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,20.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,20.717094>}
box{<0,0,-0.406400><0.214212,0.035000,0.406400> rotate<0,67.495657,0> translate<28.484022,-1.535000,20.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,20.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,21.112903>}
box{<0,0,-0.406400><0.214209,0.035000,0.406400> rotate<0,-67.495337,0> translate<28.484022,-1.535000,20.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,22.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,22.717094>}
box{<0,0,-0.406400><0.214212,0.035000,0.406400> rotate<0,67.495657,0> translate<28.484022,-1.535000,22.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.484022,-1.535000,22.915000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,23.112903>}
box{<0,0,-0.406400><0.214209,0.035000,0.406400> rotate<0,-67.495337,0> translate<28.484022,-1.535000,22.915000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.547728,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.387619,-1.535000,17.068800>}
box{<0,0,-0.406400><2.839891,0.035000,0.406400> rotate<0,0.000000,0> translate<28.547728,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.548888,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,22.758400>}
box{<0,0,-0.406400><2.921712,0.035000,0.406400> rotate<0,0.000000,0> translate<28.548888,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,15.519397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,16.717094>}
box{<0,0,-0.406400><1.197697,0.035000,0.406400> rotate<0,90.000000,0> translate<28.565997,-1.535000,16.717094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,15.519397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.838216,-1.535000,15.519397>}
box{<0,0,-0.406400><1.272219,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,15.519397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.574819,-1.535000,16.256000>}
box{<0,0,-0.406400><2.008822,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,17.112903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,18.717094>}
box{<0,0,-0.406400><1.604191,0.035000,0.406400> rotate<0,90.000000,0> translate<28.565997,-1.535000,18.717094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,17.881600>}
box{<0,0,-0.406400><2.904603,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,18.694400>}
box{<0,0,-0.406400><2.904603,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,19.112903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,20.717094>}
box{<0,0,-0.406400><1.604191,0.035000,0.406400> rotate<0,90.000000,0> translate<28.565997,-1.535000,20.717094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,19.507200>}
box{<0,0,-0.406400><2.904603,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,20.320000>}
box{<0,0,-0.406400><2.904603,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,21.112903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,22.717094>}
box{<0,0,-0.406400><1.604191,0.035000,0.406400> rotate<0,90.000000,0> translate<28.565997,-1.535000,22.717094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,21.132800>}
box{<0,0,-0.406400><2.904603,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,21.945600>}
box{<0,0,-0.406400><2.904603,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,23.112903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,24.717094>}
box{<0,0,-0.406400><1.604191,0.035000,0.406400> rotate<0,90.000000,0> translate<28.565997,-1.535000,24.717094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.870116,-1.535000,23.571200>}
box{<0,0,-0.406400><1.304119,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.565997,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.285794,-1.535000,24.384000>}
box{<0,0,-0.406400><0.719797,0.035000,0.406400> rotate<0,0.000000,0> translate<28.565997,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.688691,-1.535000,37.927512>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.857200,-1.535000,37.997309>}
box{<0,0,-0.406400><0.182392,0.035000,0.406400> rotate<0,-22.497937,0> translate<28.688691,-1.535000,37.927512> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.755044,-1.535000,30.224600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.882631,-1.535000,30.249978>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<28.755044,-1.535000,30.224600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.810381,0.000000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,31.699200>}
box{<0,0,-0.406400><3.930219,0.035000,0.406400> rotate<0,0.000000,0> translate<28.810381,0.000000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.817663,0.000000,31.706481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.253516,0.000000,32.142334>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,-44.997030,0> translate<28.817663,0.000000,31.706481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.857200,-1.535000,37.997309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.158453,-1.535000,38.298566>}
box{<0,0,-0.406400><0.426038,0.035000,0.406400> rotate<0,-44.997327,0> translate<28.857200,-1.535000,37.997309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.882631,-1.535000,30.249978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.002816,-1.535000,30.299759>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<28.882631,-1.535000,30.249978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.892094,-1.535000,34.900997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.173591,-1.535000,34.784397>}
box{<0,0,-0.406400><0.304690,0.035000,0.406400> rotate<0,22.498546,0> translate<28.892094,-1.535000,34.900997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.956000,0.000000,6.046856>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.188016,0.000000,5.486722>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,67.495513,0> translate<28.956000,0.000000,6.046856> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.956000,0.000000,6.988738>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<28.956000,0.000000,6.046856>}
box{<0,0,-0.406400><0.941881,0.035000,0.406400> rotate<0,-90.000000,0> translate<28.956000,0.000000,6.046856> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.002816,-1.535000,30.299759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.110978,-1.535000,30.372034>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<29.002816,-1.535000,30.299759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.061488,-1.535000,38.201600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,38.201600>}
box{<0,0,-0.406400><0.076512,0.035000,0.406400> rotate<0,0.000000,0> translate<29.061488,-1.535000,38.201600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.269981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,20.919397>}
box{<0,0,-0.406400><0.350584,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.069600,0.000000,20.919397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.269981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479966,0.000000,21.269981>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<29.069600,0.000000,21.269981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.270012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479966,0.000000,21.270012>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<29.069600,0.000000,21.270012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.985044>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.270012>}
box{<0,0,-0.406400><0.715031,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.069600,0.000000,21.270012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.069600,0.000000,21.985044>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.094978,0.000000,22.112631>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<29.069600,0.000000,21.985044> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.094978,0.000000,22.112631>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.144759,0.000000,22.232816>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<29.094978,0.000000,22.112631> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.110978,-1.535000,30.372034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.202963,-1.535000,30.464019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<29.110978,-1.535000,30.372034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,24.740806>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,23.993963>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,67.495525,0> translate<29.138000,-1.535000,24.740806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,25.549191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,24.740806>}
box{<0,0,-0.406400><0.808384,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.138000,-1.535000,24.740806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,25.549191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,26.296034>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,-67.495525,0> translate<29.138000,-1.535000,25.549191> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,0.000000,27.280806>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.380900,0.000000,26.694397>}
box{<0,0,-0.406400><0.634725,0.035000,0.406400> rotate<0,67.495438,0> translate<29.138000,0.000000,27.280806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,27.280806>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,26.533963>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,67.495525,0> translate<29.138000,-1.535000,27.280806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,0.000000,28.089191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,0.000000,27.280806>}
box{<0,0,-0.406400><0.808384,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.138000,0.000000,27.280806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,28.089191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,27.280806>}
box{<0,0,-0.406400><0.808384,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.138000,-1.535000,27.280806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,0.000000,28.089191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,0.000000,28.836034>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,-67.495525,0> translate<29.138000,0.000000,28.089191> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,28.089191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,28.836034>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,-67.495525,0> translate<29.138000,-1.535000,28.089191> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,37.440806>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,36.693963>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,67.495525,0> translate<29.138000,-1.535000,37.440806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,38.249191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,37.440806>}
box{<0,0,-0.406400><0.808384,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.138000,-1.535000,37.440806> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.138000,-1.535000,38.249191>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.158453,-1.535000,38.298566>}
box{<0,0,-0.406400><0.053444,0.035000,0.406400> rotate<0,-67.494228,0> translate<29.138000,-1.535000,38.249191> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.144759,0.000000,22.232816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.217034,0.000000,22.340978>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<29.144759,0.000000,22.232816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.173591,-1.535000,34.784397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.534556,-1.535000,34.784397>}
box{<0,0,-0.406400><0.360966,0.035000,0.406400> rotate<0,0.000000,0> translate<29.173591,-1.535000,34.784397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.188016,0.000000,5.486722>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.616722,0.000000,5.058016>}
box{<0,0,-0.406400><0.606282,0.035000,0.406400> rotate<0,44.997030,0> translate<29.188016,0.000000,5.486722> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.202963,-1.535000,30.464019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.275238,-1.535000,30.572181>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<29.202963,-1.535000,30.464019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.217034,0.000000,22.340978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.309019,0.000000,22.432963>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<29.217034,0.000000,22.340978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.253516,0.000000,32.142334>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.489397,0.000000,32.711803>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,-67.495582,0> translate<29.253516,0.000000,32.142334> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.275238,-1.535000,30.572181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.325019,-1.535000,30.692366>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<29.275238,-1.535000,30.572181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.309019,0.000000,22.432963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.417181,0.000000,22.505237>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<29.309019,0.000000,22.432963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.325019,-1.535000,30.692366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.333931,-1.535000,30.737175>}
box{<0,0,-0.406400><0.045687,0.035000,0.406400> rotate<0,-78.745589,0> translate<29.325019,-1.535000,30.692366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.333931,-1.535000,30.737175>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.481675,-1.535000,30.380481>}
box{<0,0,-0.406400><0.386081,0.035000,0.406400> rotate<0,67.496044,0> translate<29.333931,-1.535000,30.737175> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.406634,0.000000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.606816,0.000000,32.512000>}
box{<0,0,-0.406400><3.200181,0.035000,0.406400> rotate<0,0.000000,0> translate<29.406634,0.000000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.417181,0.000000,22.505237>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.537366,0.000000,22.555019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<29.417181,0.000000,22.505237> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,23.993963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.018963,-1.535000,23.422353>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,44.997030,0> translate<29.447353,-1.535000,23.993963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,26.296034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.566319,-1.535000,26.415000>}
box{<0,0,-0.406400><0.168243,0.035000,0.406400> rotate<0,-44.997030,0> translate<29.447353,-1.535000,26.296034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,26.533963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.566319,-1.535000,26.415000>}
box{<0,0,-0.406400><0.168241,0.035000,0.406400> rotate<0,44.996278,0> translate<29.447353,-1.535000,26.533963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,28.836034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,28.982278>}
box{<0,0,-0.406400><0.206822,0.035000,0.406400> rotate<0,-44.996418,0> translate<29.447353,-1.535000,28.836034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,0.000000,28.836034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.018963,0.000000,29.407644>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,-44.997030,0> translate<29.447353,0.000000,28.836034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.447353,-1.535000,36.693963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.719409,-1.535000,36.421909>}
box{<0,0,-0.406400><0.384743,0.035000,0.406400> rotate<0,44.996701,0> translate<29.447353,-1.535000,36.693963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.481675,-1.535000,30.380481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,30.268556>}
box{<0,0,-0.406400><0.158286,0.035000,0.406400> rotate<0,44.997030,0> translate<29.481675,-1.535000,30.380481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.489397,0.000000,32.711803>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.489397,0.000000,32.740600>}
box{<0,0,-0.406400><0.028797,0.035000,0.406400> rotate<0,90.000000,0> translate<29.489397,0.000000,32.740600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.489397,0.000000,32.740600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.378216,0.000000,32.740600>}
box{<0,0,-0.406400><2.888819,0.035000,0.406400> rotate<0,0.000000,0> translate<29.489397,0.000000,32.740600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.495800,-1.535000,35.237919>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.587134,-1.535000,35.017425>}
box{<0,0,-0.406400><0.238662,0.035000,0.406400> rotate<0,67.494908,0> translate<29.495800,-1.535000,35.237919> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.495800,-1.535000,35.882078>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.495800,-1.535000,35.237919>}
box{<0,0,-0.406400><0.644159,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.495800,-1.535000,35.237919> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.495800,-1.535000,35.882078>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.719409,-1.535000,36.421909>}
box{<0,0,-0.406400><0.584311,0.035000,0.406400> rotate<0,-67.495187,0> translate<29.495800,-1.535000,35.882078> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.534556,-1.535000,34.784397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,34.843441>}
box{<0,0,-0.406400><0.083500,0.035000,0.406400> rotate<0,-44.997030,0> translate<29.534556,-1.535000,34.784397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.537366,0.000000,22.555019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.664953,0.000000,22.580397>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<29.537366,0.000000,22.555019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.587134,-1.535000,35.017425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,34.864297>}
box{<0,0,-0.406400><0.153265,0.035000,0.406400> rotate<0,87.576420,0> translate<29.587134,-1.535000,35.017425> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,30.268556>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,28.982278>}
box{<0,0,-0.406400><1.286278,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.593600,-1.535000,28.982278> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,34.864297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.593600,-1.535000,34.843441>}
box{<0,0,-0.406400><0.020856,0.035000,0.406400> rotate<0,-90.000000,0> translate<29.593600,-1.535000,34.843441> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.616722,0.000000,5.058016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.176856,0.000000,4.826000>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,22.498547,0> translate<29.616722,0.000000,5.058016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.616722,-1.535000,5.058016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.176856,-1.535000,4.826000>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,22.498547,0> translate<29.616722,-1.535000,5.058016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.664953,0.000000,22.580397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479981,0.000000,22.580397>}
box{<0,0,-0.406400><0.815028,0.035000,0.406400> rotate<0,0.000000,0> translate<29.664953,0.000000,22.580397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.838216,-1.535000,15.519397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,17.151781>}
box{<0,0,-0.406400><2.308540,0.035000,0.406400> rotate<0,-44.997030,0> translate<29.838216,-1.535000,15.519397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<29.845719,0.000000,23.595600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.018963,0.000000,23.422353>}
box{<0,0,-0.406400><0.245006,0.035000,0.406400> rotate<0,44.997547,0> translate<29.845719,0.000000,23.595600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.018963,0.000000,23.422353>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.765806,0.000000,23.113000>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,22.498536,0> translate<30.018963,0.000000,23.422353> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.018963,-1.535000,23.422353>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.765806,-1.535000,23.113000>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,22.498536,0> translate<30.018963,-1.535000,23.422353> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.018963,0.000000,29.407644>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.765806,0.000000,29.716997>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,-22.498536,0> translate<30.018963,0.000000,29.407644> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.176856,0.000000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.783141,0.000000,4.826000>}
box{<0,0,-0.406400><0.606284,0.035000,0.406400> rotate<0,0.000000,0> translate<30.176856,0.000000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.176856,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.783141,-1.535000,4.826000>}
box{<0,0,-0.406400><0.606284,0.035000,0.406400> rotate<0,0.000000,0> translate<30.176856,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.442119,0.000000,13.259000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.482094,0.000000,13.259000>}
box{<0,0,-0.406400><1.039975,0.035000,0.406400> rotate<0,0.000000,0> translate<30.442119,0.000000,13.259000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.442119,0.000000,13.259000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.832228,0.000000,9.991494>}
box{<0,0,-0.406400><4.708443,0.035000,0.406400> rotate<0,43.942090,0> translate<30.442119,0.000000,13.259000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479966,0.000000,21.270012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479966,0.000000,21.269981>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<30.479966,0.000000,21.269981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479981,0.000000,21.270031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479981,0.000000,22.580397>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,90.000000,0> translate<30.479981,0.000000,22.580397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479981,0.000000,21.270031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480013,0.000000,21.270031>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<30.479981,0.000000,21.270031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.479981,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480013,0.000000,21.945600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<30.479981,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480013,0.000000,22.580397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480013,0.000000,21.270031>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,-90.000000,0> translate<30.480013,0.000000,21.270031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480013,0.000000,22.580397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.295044,0.000000,22.580397>}
box{<0,0,-0.406400><0.815031,0.035000,0.406400> rotate<0,0.000000,0> translate<30.480013,0.000000,22.580397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480031,0.000000,21.269981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480031,0.000000,21.270012>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<30.480031,0.000000,21.270012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480031,0.000000,21.269981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019966,0.000000,21.269981>}
box{<0,0,-0.406400><2.539934,0.035000,0.406400> rotate<0,0.000000,0> translate<30.480031,0.000000,21.269981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.480031,0.000000,21.270012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.890397,0.000000,21.270012>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<30.480031,0.000000,21.270012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.705859,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.102800,0.000000,13.004800>}
box{<0,0,-0.406400><4.396941,0.035000,0.406400> rotate<0,0.000000,0> translate<30.705859,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.765806,0.000000,23.113000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.010816,0.000000,23.113000>}
box{<0,0,-0.406400><0.245009,0.035000,0.406400> rotate<0,0.000000,0> translate<30.765806,0.000000,23.113000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.765806,-1.535000,23.113000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,23.113000>}
box{<0,0,-0.406400><0.704794,0.035000,0.406400> rotate<0,0.000000,0> translate<30.765806,-1.535000,23.113000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.765806,0.000000,29.716997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.574191,0.000000,29.716997>}
box{<0,0,-0.406400><0.808384,0.035000,0.406400> rotate<0,0.000000,0> translate<30.765806,0.000000,29.716997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.783141,0.000000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.343275,0.000000,5.058016>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,-22.498547,0> translate<30.783141,0.000000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.783141,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.343275,-1.535000,5.058016>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,-22.498547,0> translate<30.783141,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.905781,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.941059,0.000000,4.876800>}
box{<0,0,-0.406400><2.035278,0.035000,0.406400> rotate<0,0.000000,0> translate<30.905781,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<30.905781,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.941059,-1.535000,4.876800>}
box{<0,0,-0.406400><2.035278,0.035000,0.406400> rotate<0,0.000000,0> translate<30.905781,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.010816,0.000000,23.113000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.307334,0.000000,22.816481>}
box{<0,0,-0.406400><0.419341,0.035000,0.406400> rotate<0,44.997030,0> translate<31.010816,0.000000,23.113000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.295044,0.000000,22.580397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.422631,0.000000,22.555019>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<31.295044,0.000000,22.580397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.307334,0.000000,22.816481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.876803,0.000000,22.580600>}
box{<0,0,-0.406400><0.616388,0.035000,0.406400> rotate<0,22.498478,0> translate<31.307334,0.000000,22.816481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.343275,0.000000,5.058016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.771981,0.000000,5.486722>}
box{<0,0,-0.406400><0.606282,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.343275,0.000000,5.058016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.343275,-1.535000,5.058016>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.771981,-1.535000,5.486722>}
box{<0,0,-0.406400><0.606282,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.343275,-1.535000,5.058016> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.422631,0.000000,22.555019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.542816,0.000000,22.505237>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<31.422631,0.000000,22.555019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.432497,0.000000,1.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.249569,0.000000,1.048100>}
box{<0,0,-0.406400><0.817702,0.035000,0.406400> rotate<0,-2.249871,0> translate<31.432497,0.000000,1.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.432497,-1.535000,1.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.249569,-1.535000,1.048100>}
box{<0,0,-0.406400><0.817702,0.035000,0.406400> rotate<0,-2.249871,0> translate<31.432497,-1.535000,1.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,23.113000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.470600,-1.535000,17.151781>}
box{<0,0,-0.406400><5.961219,0.035000,0.406400> rotate<0,-90.000000,0> translate<31.470600,-1.535000,17.151781> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.482094,0.000000,13.259000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.855516,0.000000,13.413675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<31.482094,0.000000,13.259000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.542816,0.000000,22.505237>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.650978,0.000000,22.432963>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<31.542816,0.000000,22.505237> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.549156,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.440038,0.000000,12.192000>}
box{<0,0,-0.406400><3.890881,0.035000,0.406400> rotate<0,0.000000,0> translate<31.549156,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.566047,-1.535000,7.419206>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.661322,-1.535000,7.514481>}
box{<0,0,-0.406400><0.134739,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.566047,-1.535000,7.419206> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.566047,-1.535000,7.419206>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.771981,-1.535000,7.213275>}
box{<0,0,-0.406400><0.291233,0.035000,0.406400> rotate<0,44.996595,0> translate<31.566047,-1.535000,7.419206> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.574191,0.000000,29.716997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.321034,0.000000,29.407644>}
box{<0,0,-0.406400><0.808378,0.035000,0.406400> rotate<0,22.498536,0> translate<31.574191,0.000000,29.716997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.650978,0.000000,22.432963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.742963,0.000000,22.340978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<31.650978,0.000000,22.432963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.661322,-1.535000,7.514481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.815997,-1.535000,7.887903>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<31.661322,-1.535000,7.514481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.670056,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.163522,-1.535000,7.315200>}
box{<0,0,-0.406400><5.493466,0.035000,0.406400> rotate<0,0.000000,0> translate<31.670056,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.742963,0.000000,22.340978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.750000,0.000000,22.330447>}
box{<0,0,-0.406400><0.012666,0.035000,0.406400> rotate<0,56.243491,0> translate<31.742963,0.000000,22.340978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.750000,0.000000,22.330447>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.757034,0.000000,22.340978>}
box{<0,0,-0.406400><0.012665,0.035000,0.406400> rotate<0,-56.255245,0> translate<31.750000,0.000000,22.330447> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.757034,0.000000,22.340978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.849019,0.000000,22.432963>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.757034,0.000000,22.340978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.771981,0.000000,5.486722>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,0.000000,6.046856>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,-67.495513,0> translate<31.771981,0.000000,5.486722> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.771981,-1.535000,5.486722>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,-1.535000,6.046856>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,-67.495513,0> translate<31.771981,-1.535000,5.486722> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.771981,-1.535000,7.213275>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,-1.535000,6.653141>}
box{<0,0,-0.406400><0.606285,0.035000,0.406400> rotate<0,67.495513,0> translate<31.771981,-1.535000,7.213275> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.815997,-1.535000,7.887903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.815997,-1.535000,9.563100>}
box{<0,0,-0.406400><1.675197,0.035000,0.406400> rotate<0,90.000000,0> translate<31.815997,-1.535000,9.563100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.815997,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039597,-1.535000,8.128000>}
box{<0,0,-0.406400><0.223600,0.035000,0.406400> rotate<0,0.000000,0> translate<31.815997,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.815997,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039600,-1.535000,8.940800>}
box{<0,0,-0.406400><0.223603,0.035000,0.406400> rotate<0,0.000000,0> translate<31.815997,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.815997,-1.535000,9.563100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039600,-1.535000,9.563100>}
box{<0,0,-0.406400><0.223603,0.035000,0.406400> rotate<0,0.000000,0> translate<31.815997,-1.535000,9.563100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.849019,0.000000,22.432963>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.957181,0.000000,22.505237>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<31.849019,0.000000,22.432963> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.855516,0.000000,13.413675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.072784,0.000000,13.630944>}
box{<0,0,-0.406400><0.307264,0.035000,0.406400> rotate<0,-44.997030,0> translate<31.855516,0.000000,13.413675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.856016,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.997203,0.000000,5.689600>}
box{<0,0,-0.406400><2.141187,0.035000,0.406400> rotate<0,0.000000,0> translate<31.856016,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.856016,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.997203,-1.535000,5.689600>}
box{<0,0,-0.406400><2.141187,0.035000,0.406400> rotate<0,0.000000,0> translate<31.856016,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.876803,0.000000,22.580600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.648216,0.000000,22.580600>}
box{<0,0,-0.406400><1.771412,0.035000,0.406400> rotate<0,0.000000,0> translate<31.876803,0.000000,22.580600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.890397,0.000000,21.270012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019966,0.000000,21.270012>}
box{<0,0,-0.406400><1.129569,0.035000,0.406400> rotate<0,0.000000,0> translate<31.890397,0.000000,21.270012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<31.957181,0.000000,22.505237>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.077366,0.000000,22.555019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<31.957181,0.000000,22.505237> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,-1.535000,6.046856>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,-1.535000,6.653141>}
box{<0,0,-0.406400><0.606284,0.035000,0.406400> rotate<0,90.000000,0> translate<32.003997,-1.535000,6.653141> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,0.000000,6.046856>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,0.000000,7.449759>}
box{<0,0,-0.406400><1.402903,0.035000,0.406400> rotate<0,90.000000,0> translate<32.003997,0.000000,7.449759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.880328,0.000000,6.502400>}
box{<0,0,-0.406400><5.876331,0.035000,0.406400> rotate<0,0.000000,0> translate<32.003997,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.880328,-1.535000,6.502400>}
box{<0,0,-0.406400><5.876331,0.035000,0.406400> rotate<0,0.000000,0> translate<32.003997,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.142809,0.000000,7.315200>}
box{<0,0,-0.406400><0.138813,0.035000,0.406400> rotate<0,0.000000,0> translate<32.003997,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.003997,0.000000,7.449759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.121662,0.000000,7.336350>}
box{<0,0,-0.406400><0.163422,0.035000,0.406400> rotate<0,43.941868,0> translate<32.003997,0.000000,7.449759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039597,-1.535000,8.889981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039600,-1.535000,8.024953>}
box{<0,0,-0.406400><0.865028,0.035000,0.406400> rotate<0,89.993853,0> translate<32.039597,-1.535000,8.889981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039597,-1.535000,8.889981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449966,-1.535000,8.889981>}
box{<0,0,-0.406400><2.410369,0.035000,0.406400> rotate<0,0.000000,0> translate<32.039597,-1.535000,8.889981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039600,-1.535000,8.024953>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.064978,-1.535000,7.897366>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<32.039600,-1.535000,8.024953> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039600,-1.535000,8.890013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449966,-1.535000,8.890013>}
box{<0,0,-0.406400><2.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<32.039600,-1.535000,8.890013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039600,-1.535000,9.563100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.039600,-1.535000,8.890013>}
box{<0,0,-0.406400><0.673087,0.035000,0.406400> rotate<0,-90.000000,0> translate<32.039600,-1.535000,8.890013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.064978,-1.535000,7.897366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.114759,-1.535000,7.777181>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<32.064978,-1.535000,7.897366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.072784,0.000000,13.630944>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.154953,0.000000,13.614600>}
box{<0,0,-0.406400><0.083778,0.035000,0.406400> rotate<0,11.248835,0> translate<32.072784,0.000000,13.630944> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.077366,0.000000,22.555019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.204953,0.000000,22.580397>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<32.077366,0.000000,22.555019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.114759,-1.535000,7.777181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.187034,-1.535000,7.669019>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<32.114759,-1.535000,7.777181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.121662,0.000000,7.336350>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.329431,0.000000,7.128578>}
box{<0,0,-0.406400><0.293832,0.035000,0.406400> rotate<0,44.997461,0> translate<32.121662,0.000000,7.336350> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.154953,0.000000,13.614600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,13.614600>}
box{<0,0,-0.406400><0.865028,0.035000,0.406400> rotate<0,0.000000,0> translate<32.154953,0.000000,13.614600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.187034,-1.535000,7.669019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.279019,-1.535000,7.577034>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<32.187034,-1.535000,7.669019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.204953,0.000000,22.580397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,22.580397>}
box{<0,0,-0.406400><0.815028,0.035000,0.406400> rotate<0,0.000000,0> translate<32.204953,0.000000,22.580397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.249569,0.000000,1.048100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.863597,0.000000,1.303737>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,-8.999425,0> translate<32.249569,0.000000,1.048100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.249569,-1.535000,1.048100>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.863597,-1.535000,1.303737>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,-8.999425,0> translate<32.249569,-1.535000,1.048100> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.279019,-1.535000,7.577034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.387181,-1.535000,7.504759>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<32.279019,-1.535000,7.577034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.321034,0.000000,29.407644>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,28.988075>}
box{<0,0,-0.406400><0.593358,0.035000,0.406400> rotate<0,44.997244,0> translate<32.321034,0.000000,29.407644> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.329431,0.000000,7.128578>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.343103,0.000000,7.122916>}
box{<0,0,-0.406400><0.014798,0.035000,0.406400> rotate<0,22.496455,0> translate<32.329431,0.000000,7.128578> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.343103,0.000000,7.122916>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.353763,0.000000,7.112641>}
box{<0,0,-0.406400><0.014805,0.035000,0.406400> rotate<0,43.945213,0> translate<32.343103,0.000000,7.122916> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.353763,0.000000,7.112641>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.627412,0.000000,7.005153>}
box{<0,0,-0.406400><0.294003,0.035000,0.406400> rotate<0,21.443082,0> translate<32.353763,0.000000,7.112641> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.378216,0.000000,32.740600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,32.378216>}
box{<0,0,-0.406400><0.512489,0.035000,0.406400> rotate<0,44.997030,0> translate<32.378216,0.000000,32.740600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.387181,-1.535000,7.504759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.507366,-1.535000,7.454978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<32.387181,-1.535000,7.504759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.392453,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.648938,0.000000,11.379200>}
box{<0,0,-0.406400><4.256484,0.035000,0.406400> rotate<0,0.000000,0> translate<32.392453,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.467878,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,29.260800>}
box{<0,0,-0.406400><0.272722,0.035000,0.406400> rotate<0,0.000000,0> translate<32.467878,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.507366,-1.535000,7.454978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.634953,-1.535000,7.429600>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<32.507366,-1.535000,7.454978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.627412,0.000000,7.005153>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.898900,0.000000,6.892697>}
box{<0,0,-0.406400><0.293857,0.035000,0.406400> rotate<0,22.498956,0> translate<32.627412,0.000000,7.005153> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.634953,-1.535000,7.429600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,7.429600>}
box{<0,0,-0.406400><1.815028,0.035000,0.406400> rotate<0,0.000000,0> translate<32.634953,-1.535000,7.429600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,0.000000,3.719372>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,0.000000,3.468488>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,82.494876,0> translate<32.644500,0.000000,3.719372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,-1.535000,3.719372>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,-1.535000,3.468488>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,82.494876,0> translate<32.644500,-1.535000,3.719372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,0.000000,3.972425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,0.000000,3.719372>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,-90.000000,0> translate<32.644500,0.000000,3.719372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,-1.535000,3.972425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,-1.535000,3.719372>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,-90.000000,0> translate<32.644500,-1.535000,3.719372> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,0.000000,3.972425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,0.000000,4.223309>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-82.494876,0> translate<32.644500,0.000000,3.972425> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.644500,-1.535000,3.972425>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,-1.535000,4.223309>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-82.494876,0> translate<32.644500,-1.535000,3.972425> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,0.000000,3.468488>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,0.000000,3.224059>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,74.994491,0> translate<32.677528,0.000000,3.468488> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,-1.535000,3.468488>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,-1.535000,3.224059>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,74.994491,0> translate<32.677528,-1.535000,3.468488> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,0.000000,4.223309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,0.000000,4.467738>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-74.994491,0> translate<32.677528,0.000000,4.223309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.677528,-1.535000,4.223309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,-1.535000,4.467738>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-74.994491,0> translate<32.677528,-1.535000,4.223309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,32.378216>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.740600,0.000000,28.988075>}
box{<0,0,-0.406400><3.390141,0.035000,0.406400> rotate<0,-90.000000,0> translate<32.740600,0.000000,28.988075> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,0.000000,3.224059>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,0.000000,2.990272>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,67.495640,0> translate<32.743025,0.000000,3.224059> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,-1.535000,3.224059>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,-1.535000,2.990272>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,67.495640,0> translate<32.743025,-1.535000,3.224059> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,0.000000,4.467738>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,0.000000,4.701525>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-67.495640,0> translate<32.743025,0.000000,4.467738> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.743025,-1.535000,4.467738>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,-1.535000,4.701525>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-67.495640,0> translate<32.743025,-1.535000,4.467738> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,0.000000,2.990272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,0.000000,2.771125>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,59.995944,0> translate<32.839863,0.000000,2.990272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,-1.535000,2.990272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,-1.535000,2.771125>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,59.995944,0> translate<32.839863,-1.535000,2.990272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,0.000000,4.701525>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,0.000000,4.920672>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<32.839863,0.000000,4.701525> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.839863,-1.535000,4.701525>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,-1.535000,4.920672>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<32.839863,-1.535000,4.701525> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.898900,0.000000,6.892697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.913700,0.000000,6.892697>}
box{<0,0,-0.406400><0.014800,0.035000,0.406400> rotate<0,0.000000,0> translate<32.898900,0.000000,6.892697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.913700,0.000000,6.892697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.927478,0.000000,6.887284>}
box{<0,0,-0.406400><0.014803,0.035000,0.406400> rotate<0,21.445115,0> translate<32.913700,0.000000,6.892697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.927478,0.000000,6.887284>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.221372,0.000000,6.892697>}
box{<0,0,-0.406400><0.293944,0.035000,0.406400> rotate<0,-1.055000,0> translate<32.927478,0.000000,6.887284> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,0.000000,2.771125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,0.000000,2.570366>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<32.966388,0.000000,2.771125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,-1.535000,2.771125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,-1.535000,2.570366>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<32.966388,-1.535000,2.771125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,0.000000,4.920672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,0.000000,5.121431>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<32.966388,0.000000,4.920672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<32.966388,-1.535000,4.920672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,-1.535000,5.121431>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<32.966388,-1.535000,4.920672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019966,0.000000,21.270012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019966,0.000000,21.269981>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<33.019966,0.000000,21.269981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,13.614600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,14.924966>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,90.000000,0> translate<33.019981,0.000000,14.924966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,13.817600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<33.019981,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,14.630400>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<33.019981,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,14.924966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,14.924966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<33.019981,0.000000,14.924966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,21.270031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,22.580397>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,90.000000,0> translate<33.019981,0.000000,22.580397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,21.270031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,21.270031>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<33.019981,0.000000,21.270031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.019981,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,21.945600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<33.019981,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,13.614597>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.885044,0.000000,13.614600>}
box{<0,0,-0.406400><0.865031,0.035000,0.406400> rotate<0,-0.000207,0> translate<33.020012,0.000000,13.614597> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,14.924966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,13.614597>}
box{<0,0,-0.406400><1.310369,0.035000,0.406400> rotate<0,-90.000000,0> translate<33.020012,0.000000,13.614597> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,22.580397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,21.270031>}
box{<0,0,-0.406400><1.310366,0.035000,0.406400> rotate<0,-90.000000,0> translate<33.020012,0.000000,21.270031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020012,0.000000,22.580397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.648422,0.000000,22.580397>}
box{<0,0,-0.406400><0.628409,0.035000,0.406400> rotate<0,0.000000,0> translate<33.020012,0.000000,22.580397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,14.924981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,14.925013>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<33.020031,0.000000,14.925013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,14.924981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,14.924981>}
box{<0,0,-0.406400><1.460366,0.035000,0.406400> rotate<0,0.000000,0> translate<33.020031,0.000000,14.924981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,14.925013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,14.925013>}
box{<0,0,-0.406400><1.460366,0.035000,0.406400> rotate<0,0.000000,0> translate<33.020031,0.000000,14.925013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,21.269981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,21.270012>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<33.020031,0.000000,21.270012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,21.269981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,21.269981>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<33.020031,0.000000,21.269981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.020031,0.000000,21.270012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,21.270012>}
box{<0,0,-0.406400><1.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<33.020031,0.000000,21.270012> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,0.000000,2.570366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209888,0.000000,2.480909>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,44.998031,0> translate<33.120434,0.000000,2.570366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,-1.535000,2.570366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209888,-1.535000,2.480909>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,44.998031,0> translate<33.120434,-1.535000,2.570366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,0.000000,5.121431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209891,0.000000,5.210884>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.996029,0> translate<33.120434,0.000000,5.121431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.120434,-1.535000,5.121431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209891,-1.535000,5.210884>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.996029,0> translate<33.120434,-1.535000,5.121431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209888,0.000000,2.480909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,0.000000,3.845888>}
box{<0,0,-0.406400><1.930368,0.035000,0.406400> rotate<0,-44.997096,0> translate<33.209888,0.000000,2.480909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209888,-1.535000,2.480909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,-1.535000,3.845888>}
box{<0,0,-0.406400><1.930368,0.035000,0.406400> rotate<0,-44.997096,0> translate<33.209888,-1.535000,2.480909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209891,0.000000,5.210884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,0.000000,3.845909>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,44.997096,0> translate<33.209891,0.000000,5.210884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209891,-1.535000,5.210884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,-1.535000,3.845909>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,44.997096,0> translate<33.209891,-1.535000,5.210884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,0.000000,2.480888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,0.000000,2.391434>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,44.996029,0> translate<33.209909,0.000000,2.480888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,-1.535000,2.480888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,-1.535000,2.391434>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,44.996029,0> translate<33.209909,-1.535000,2.480888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,0.000000,2.480888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574888,0.000000,3.845863>}
box{<0,0,-0.406400><1.930368,0.035000,0.406400> rotate<0,-44.996965,0> translate<33.209909,0.000000,2.480888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,-1.535000,2.480888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574888,-1.535000,3.845863>}
box{<0,0,-0.406400><1.930368,0.035000,0.406400> rotate<0,-44.996965,0> translate<33.209909,-1.535000,2.480888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,0.000000,5.210906>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,0.000000,5.300363>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,-44.997030,0> translate<33.209909,0.000000,5.210906> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,-1.535000,5.210906>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,-1.535000,5.300363>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,-44.997030,0> translate<33.209909,-1.535000,5.210906> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,0.000000,5.210906>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574884,0.000000,3.845931>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997030,0> translate<33.209909,0.000000,5.210906> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.209909,-1.535000,5.210906>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574884,-1.535000,3.845931>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997030,0> translate<33.209909,-1.535000,5.210906> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.221372,0.000000,6.892697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.487603,0.000000,6.892697>}
box{<0,0,-0.406400><4.266231,0.035000,0.406400> rotate<0,0.000000,0> translate<33.221372,0.000000,6.892697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.235753,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.326019,0.000000,10.566400>}
box{<0,0,-0.406400><5.090266,0.035000,0.406400> rotate<0,0.000000,0> translate<33.235753,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,0.000000,2.391434>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,0.000000,2.237388>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,37.497308,0> translate<33.299366,0.000000,2.391434> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,-1.535000,2.391434>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,-1.535000,2.237388>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,37.497308,0> translate<33.299366,-1.535000,2.391434> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,0.000000,5.300363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,0.000000,5.454409>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<33.299366,0.000000,5.300363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.299366,-1.535000,5.300363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,-1.535000,5.454409>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<33.299366,-1.535000,5.300363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,0.000000,2.237388>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,0.000000,2.110863>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,29.998117,0> translate<33.500125,0.000000,2.237388> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,-1.535000,2.237388>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,-1.535000,2.110863>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,29.998117,0> translate<33.500125,-1.535000,2.237388> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,0.000000,5.454409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,0.000000,5.580934>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<33.500125,0.000000,5.454409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.500125,-1.535000,5.454409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,-1.535000,5.580934>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<33.500125,-1.535000,5.454409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.543975,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.544016,0.000000,4.876800>}
box{<0,0,-0.406400><0.000041,0.035000,0.406400> rotate<0,0.000000,0> translate<33.543975,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.543975,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.544016,-1.535000,4.876800>}
box{<0,0,-0.406400><0.000041,0.035000,0.406400> rotate<0,0.000000,0> translate<33.543975,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.648216,0.000000,22.580600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.648422,0.000000,22.580397>}
box{<0,0,-0.406400><0.000289,0.035000,0.406400> rotate<0,44.559695,0> translate<33.648216,0.000000,22.580600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,0.000000,2.110863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,0.000000,2.014025>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,22.498420,0> translate<33.719272,0.000000,2.110863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,-1.535000,2.110863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,-1.535000,2.014025>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,22.498420,0> translate<33.719272,-1.535000,2.110863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,0.000000,5.580934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,0.000000,5.677772>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<33.719272,0.000000,5.580934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.719272,-1.535000,5.580934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,-1.535000,5.677772>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<33.719272,-1.535000,5.580934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.832228,0.000000,9.991494>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.487603,0.000000,9.991494>}
box{<0,0,-0.406400><3.655375,0.035000,0.406400> rotate<0,0.000000,0> translate<33.832228,0.000000,9.991494> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.863597,0.000000,1.303737>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.417763,0.000000,1.808716>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,-17.998782,0> translate<33.863597,0.000000,1.303737> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.863597,-1.535000,1.303737>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.417763,-1.535000,1.808716>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,-17.998782,0> translate<33.863597,-1.535000,1.303737> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.885044,0.000000,13.614600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.012631,0.000000,13.639978>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<33.885044,0.000000,13.614600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,0.000000,2.014025>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,0.000000,1.948528>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,14.999569,0> translate<33.953059,0.000000,2.014025> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,-1.535000,2.014025>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,-1.535000,1.948528>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,14.999569,0> translate<33.953059,-1.535000,2.014025> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,0.000000,5.677772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,0.000000,5.743269>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<33.953059,0.000000,5.677772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.953059,-1.535000,5.677772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,-1.535000,5.743269>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<33.953059,-1.535000,5.677772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.980175,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.980225,0.000000,3.251200>}
box{<0,0,-0.406400><0.000050,0.035000,0.406400> rotate<0,0.000000,0> translate<33.980175,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.980175,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<33.980225,-1.535000,3.251200>}
box{<0,0,-0.406400><0.000050,0.035000,0.406400> rotate<0,0.000000,0> translate<33.980175,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.012631,0.000000,13.639978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.132816,0.000000,13.689759>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<34.012631,0.000000,13.639978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.131575,-1.535000,10.350397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,10.350397>}
box{<0,0,-0.406400><0.318406,0.035000,0.406400> rotate<0,0.000000,0> translate<34.131575,-1.535000,10.350397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.131575,-1.535000,10.350397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.592181,-1.535000,11.811000>}
box{<0,0,-0.406400><2.065607,0.035000,0.406400> rotate<0,-44.996969,0> translate<34.131575,-1.535000,10.350397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.132816,0.000000,13.689759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.240978,0.000000,13.762034>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<34.132816,0.000000,13.689759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,0.000000,1.948528>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,0.000000,1.915500>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,7.499184,0> translate<34.197488,0.000000,1.948528> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,-1.535000,1.948528>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,-1.535000,1.915500>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,7.499184,0> translate<34.197488,-1.535000,1.948528> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,0.000000,5.743269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,0.000000,5.776297>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<34.197488,0.000000,5.743269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.197488,-1.535000,5.743269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,-1.535000,5.776297>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<34.197488,-1.535000,5.743269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.240978,0.000000,13.762034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.332963,0.000000,13.854019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<34.240978,0.000000,13.762034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.296544,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.126853,0.000000,13.817600>}
box{<0,0,-0.406400><0.830309,0.035000,0.406400> rotate<0,0.000000,0> translate<34.296544,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.332963,0.000000,13.854019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.405237,0.000000,13.962181>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<34.332963,0.000000,13.854019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.347578,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.326019,-1.535000,10.566400>}
box{<0,0,-0.406400><3.978441,0.035000,0.406400> rotate<0,0.000000,0> translate<34.347578,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.356775,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.356816,0.000000,4.064000>}
box{<0,0,-0.406400><0.000041,0.035000,0.406400> rotate<0,0.000000,0> translate<34.356775,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.356775,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.356816,-1.535000,4.064000>}
box{<0,0,-0.406400><0.000041,0.035000,0.406400> rotate<0,0.000000,0> translate<34.356775,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.405237,0.000000,13.962181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.455019,0.000000,14.082366>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<34.405237,0.000000,13.962181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,20.796441>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,21.269981>}
box{<0,0,-0.406400><0.473541,0.035000,0.406400> rotate<0,90.000000,0> translate<34.430397,0.000000,21.269981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,20.796441>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.631322,0.000000,20.595516>}
box{<0,0,-0.406400><0.284151,0.035000,0.406400> rotate<0,44.997030,0> translate<34.430397,0.000000,20.796441> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.813519,0.000000,21.132800>}
box{<0,0,-0.406400><0.383122,0.035000,0.406400> rotate<0,0.000000,0> translate<34.430397,0.000000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,21.270012>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,21.422763>}
box{<0,0,-0.406400><0.152750,0.035000,0.406400> rotate<0,90.000000,0> translate<34.430397,0.000000,21.422763> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.430397,0.000000,21.422763>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.654481,0.000000,21.198675>}
box{<0,0,-0.406400><0.316905,0.035000,0.406400> rotate<0,44.997430,0> translate<34.430397,0.000000,21.422763> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,0.000000,1.915500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,0.000000,1.915500>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,0.000000,0> translate<34.448372,0.000000,1.915500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,-1.535000,1.915500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,-1.535000,1.915500>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,0.000000,0> translate<34.448372,-1.535000,1.915500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,0.000000,5.776297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,0.000000,5.776297>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,0.000000,0> translate<34.448372,0.000000,5.776297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.448372,-1.535000,5.776297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,-1.535000,5.776297>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,0.000000,0> translate<34.448372,-1.535000,5.776297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449966,-1.535000,8.890013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449966,-1.535000,8.889981>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-90.000000,0> translate<34.449966,-1.535000,8.889981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,7.429600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,8.889966>}
box{<0,0,-0.406400><1.460366,0.035000,0.406400> rotate<0,90.000000,0> translate<34.449981,-1.535000,8.889966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,8.128000>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<34.449981,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,8.889966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,8.889966>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<34.449981,-1.535000,8.889966> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,8.890031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,10.350397>}
box{<0,0,-0.406400><1.460366,0.035000,0.406400> rotate<0,90.000000,0> translate<34.449981,-1.535000,10.350397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,8.890031>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,8.890031>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<34.449981,-1.535000,8.890031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,8.940800>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<34.449981,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.449981,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,9.753600>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,0.000000,0> translate<34.449981,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,7.429600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.265044,-1.535000,7.429600>}
box{<0,0,-0.406400><1.815031,0.035000,0.406400> rotate<0,0.000000,0> translate<34.450012,-1.535000,7.429600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,8.889966>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,7.429600>}
box{<0,0,-0.406400><1.460366,0.035000,0.406400> rotate<0,-90.000000,0> translate<34.450012,-1.535000,7.429600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,10.350397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,8.890031>}
box{<0,0,-0.406400><1.460366,0.035000,0.406400> rotate<0,-90.000000,0> translate<34.450012,-1.535000,8.890031> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450012,-1.535000,10.350397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.265044,-1.535000,10.350397>}
box{<0,0,-0.406400><1.815031,0.035000,0.406400> rotate<0,0.000000,0> translate<34.450012,-1.535000,10.350397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450031,-1.535000,8.889981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450031,-1.535000,8.890013>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,90.000000,0> translate<34.450031,-1.535000,8.890013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450031,-1.535000,8.889981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860394,-1.535000,8.889981>}
box{<0,0,-0.406400><2.410362,0.035000,0.406400> rotate<0,0.000000,0> translate<34.450031,-1.535000,8.889981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.450031,-1.535000,8.890013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,8.890013>}
box{<0,0,-0.406400><2.410366,0.035000,0.406400> rotate<0,0.000000,0> translate<34.450031,-1.535000,8.890013> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.455019,0.000000,14.082366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,14.209953>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<34.455019,0.000000,14.082366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,14.209953>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,14.924981>}
box{<0,0,-0.406400><0.715028,0.035000,0.406400> rotate<0,90.000000,0> translate<34.480397,0.000000,14.924981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.541641,0.000000,14.630400>}
box{<0,0,-0.406400><1.061244,0.035000,0.406400> rotate<0,0.000000,0> translate<34.480397,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,14.925013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,15.398556>}
box{<0,0,-0.406400><0.473544,0.035000,0.406400> rotate<0,90.000000,0> translate<34.480397,0.000000,15.398556> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.480397,0.000000,15.398556>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.681322,0.000000,15.599481>}
box{<0,0,-0.406400><0.284151,0.035000,0.406400> rotate<0,-44.997030,0> translate<34.480397,0.000000,15.398556> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.525041,0.000000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,15.443200>}
box{<0,0,-0.406400><7.321459,0.035000,0.406400> rotate<0,0.000000,0> translate<34.525041,0.000000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,0.000000,3.845888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574888,0.000000,3.845863>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,44.997030,0> translate<34.574863,0.000000,3.845888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,-1.535000,3.845888>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574888,-1.535000,3.845863>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,44.997030,0> translate<34.574863,-1.535000,3.845888> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,0.000000,3.845909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574884,0.000000,3.845931>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-44.997030,0> translate<34.574863,0.000000,3.845909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574863,-1.535000,3.845909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574884,-1.535000,3.845931>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-44.997030,0> translate<34.574863,-1.535000,3.845909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,0.000000,3.845863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574931,0.000000,3.845884>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-44.997030,0> translate<34.574909,0.000000,3.845863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,-1.535000,3.845863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574931,-1.535000,3.845884>}
box{<0,0,-0.406400><0.000031,0.035000,0.406400> rotate<0,-44.997030,0> translate<34.574909,-1.535000,3.845863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,0.000000,3.845863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,0.000000,2.480891>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,44.996965,0> translate<34.574909,0.000000,3.845863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,-1.535000,3.845863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,-1.535000,2.480891>}
box{<0,0,-0.406400><1.930364,0.035000,0.406400> rotate<0,44.996965,0> translate<34.574909,-1.535000,3.845863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,0.000000,3.845934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574934,0.000000,3.845909>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,44.997030,0> translate<34.574909,0.000000,3.845934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,-1.535000,3.845934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574934,-1.535000,3.845909>}
box{<0,0,-0.406400><0.000035,0.035000,0.406400> rotate<0,44.997030,0> translate<34.574909,-1.535000,3.845934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,0.000000,3.845934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,0.000000,5.210903>}
box{<0,0,-0.406400><1.930362,0.035000,0.406400> rotate<0,-44.996899,0> translate<34.574909,0.000000,3.845934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574909,-1.535000,3.845934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,-1.535000,5.210903>}
box{<0,0,-0.406400><1.930362,0.035000,0.406400> rotate<0,-44.996899,0> translate<34.574909,-1.535000,3.845934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574931,0.000000,3.845884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939906,0.000000,2.480909>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997030,0> translate<34.574931,0.000000,3.845884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574931,-1.535000,3.845884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939906,-1.535000,2.480909>}
box{<0,0,-0.406400><1.930366,0.035000,0.406400> rotate<0,44.997030,0> translate<34.574931,-1.535000,3.845884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574934,0.000000,3.845909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939903,0.000000,5.210884>}
box{<0,0,-0.406400><1.930362,0.035000,0.406400> rotate<0,-44.997161,0> translate<34.574934,0.000000,3.845909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.574934,-1.535000,3.845909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939903,-1.535000,5.210884>}
box{<0,0,-0.406400><1.930362,0.035000,0.406400> rotate<0,-44.997161,0> translate<34.574934,-1.535000,3.845909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.631322,0.000000,20.595516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.785997,0.000000,20.222094>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,67.495729,0> translate<34.631322,0.000000,20.595516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.654481,0.000000,21.198675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.027903,0.000000,21.044000>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<34.654481,0.000000,21.198675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.681322,0.000000,15.599481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.835997,0.000000,15.972903>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<34.681322,0.000000,15.599481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,0.000000,1.915500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,0.000000,1.948528>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<34.701425,0.000000,1.915500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,-1.535000,1.915500>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,-1.535000,1.948528>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-7.499184,0> translate<34.701425,-1.535000,1.915500> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,0.000000,5.776297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,0.000000,5.743269>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,7.499184,0> translate<34.701425,0.000000,5.776297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.701425,-1.535000,5.776297>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,-1.535000,5.743269>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,7.499184,0> translate<34.701425,-1.535000,5.776297> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.745444,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.526306,0.000000,20.320000>}
box{<0,0,-0.406400><1.780863,0.035000,0.406400> rotate<0,0.000000,0> translate<34.745444,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.785997,0.000000,19.329397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.785997,0.000000,20.222094>}
box{<0,0,-0.406400><0.892697,0.035000,0.406400> rotate<0,90.000000,0> translate<34.785997,0.000000,20.222094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.785997,0.000000,19.329397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.326750,0.000000,19.329397>}
box{<0,0,-0.406400><0.540753,0.035000,0.406400> rotate<0,0.000000,0> translate<34.785997,0.000000,19.329397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.785997,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.400400,0.000000,19.507200>}
box{<0,0,-0.406400><0.614403,0.035000,0.406400> rotate<0,0.000000,0> translate<34.785997,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.792975,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.793025,0.000000,4.064000>}
box{<0,0,-0.406400><0.000050,0.035000,0.406400> rotate<0,0.000000,0> translate<34.792975,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.792975,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.793025,-1.535000,4.064000>}
box{<0,0,-0.406400><0.000050,0.035000,0.406400> rotate<0,0.000000,0> translate<34.792975,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.835997,0.000000,15.972903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.835997,0.000000,16.230600>}
box{<0,0,-0.406400><0.257697,0.035000,0.406400> rotate<0,90.000000,0> translate<34.835997,0.000000,16.230600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.835997,0.000000,16.230600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.207222,0.000000,16.230600>}
box{<0,0,-0.406400><2.371225,0.035000,0.406400> rotate<0,0.000000,0> translate<34.835997,0.000000,16.230600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,0.000000,1.948528>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,0.000000,2.014025>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<34.952309,0.000000,1.948528> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,-1.535000,1.948528>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,-1.535000,2.014025>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-14.999569,0> translate<34.952309,-1.535000,1.948528> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,0.000000,5.743269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,0.000000,5.677772>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,14.999569,0> translate<34.952309,0.000000,5.743269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<34.952309,-1.535000,5.743269>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,-1.535000,5.677772>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,14.999569,0> translate<34.952309,-1.535000,5.743269> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.027903,0.000000,21.044000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.732094,0.000000,21.044000>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,0.000000,0> translate<35.027903,0.000000,21.044000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.102800,0.000000,12.961259>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.408288,0.000000,12.223750>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,67.495471,0> translate<35.102800,0.000000,12.961259> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.102800,0.000000,13.759538>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.102800,0.000000,12.961259>}
box{<0,0,-0.406400><0.798278,0.035000,0.406400> rotate<0,-90.000000,0> translate<35.102800,0.000000,12.961259> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.102800,0.000000,13.759538>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.408288,0.000000,14.497047>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-67.495471,0> translate<35.102800,0.000000,13.759538> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.152597,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.094588,0.000000,5.689600>}
box{<0,0,-0.406400><4.941991,0.035000,0.406400> rotate<0,0.000000,0> translate<35.152597,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.152597,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.094588,-1.535000,5.689600>}
box{<0,0,-0.406400><4.941991,0.035000,0.406400> rotate<0,0.000000,0> translate<35.152597,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.160378,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.648938,-1.535000,11.379200>}
box{<0,0,-0.406400><1.488559,0.035000,0.406400> rotate<0,0.000000,0> translate<35.160378,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.169575,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.169616,0.000000,3.251200>}
box{<0,0,-0.406400><0.000041,0.035000,0.406400> rotate<0,0.000000,0> translate<35.169575,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.169575,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.169616,-1.535000,3.251200>}
box{<0,0,-0.406400><0.000041,0.035000,0.406400> rotate<0,0.000000,0> translate<35.169575,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,0.000000,2.014025>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,0.000000,2.110863>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<35.196738,0.000000,2.014025> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,-1.535000,2.014025>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,-1.535000,2.110863>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-22.498420,0> translate<35.196738,-1.535000,2.014025> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,0.000000,5.677772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,0.000000,5.580934>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,22.498420,0> translate<35.196738,0.000000,5.677772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.196738,-1.535000,5.677772>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,-1.535000,5.580934>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,22.498420,0> translate<35.196738,-1.535000,5.677772> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.326750,0.000000,19.329397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.408288,0.000000,19.526247>}
box{<0,0,-0.406400><0.213069,0.035000,0.406400> rotate<0,-67.495655,0> translate<35.326750,0.000000,19.329397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.408288,0.000000,12.223750>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,11.659288>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,44.997030,0> translate<35.408288,0.000000,12.223750> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.408288,0.000000,14.497047>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,15.061509>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,-44.997030,0> translate<35.408288,0.000000,14.497047> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.408288,0.000000,19.526247>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,20.090709>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,-44.997030,0> translate<35.408288,0.000000,19.526247> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.417763,0.000000,1.808716>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.873800,0.000000,2.550603>}
box{<0,0,-0.406400><1.634149,0.035000,0.406400> rotate<0,-26.998197,0> translate<35.417763,0.000000,1.808716> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.417763,-1.535000,1.808716>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.873800,-1.535000,2.550603>}
box{<0,0,-0.406400><1.634149,0.035000,0.406400> rotate<0,-26.998197,0> translate<35.417763,-1.535000,1.808716> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,0.000000,2.110863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,0.000000,2.237388>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<35.430525,0.000000,2.110863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,-1.535000,2.110863>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,-1.535000,2.237388>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-29.998117,0> translate<35.430525,-1.535000,2.110863> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,0.000000,5.580934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,0.000000,5.454409>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,29.998117,0> translate<35.430525,0.000000,5.580934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.430525,-1.535000,5.580934>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,-1.535000,5.454409>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,29.998117,0> translate<35.430525,-1.535000,5.580934> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.592181,-1.535000,11.811000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.821038,-1.535000,11.811000>}
box{<0,0,-0.406400><0.228856,0.035000,0.406400> rotate<0,0.000000,0> translate<35.592181,-1.535000,11.811000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.605778,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.605822,0.000000,4.876800>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<35.605778,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.605778,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.605822,-1.535000,4.876800>}
box{<0,0,-0.406400><0.000044,0.035000,0.406400> rotate<0,0.000000,0> translate<35.605778,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,0.000000,2.237388>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,0.000000,2.391434>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<35.649672,0.000000,2.237388> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,-1.535000,2.237388>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,-1.535000,2.391434>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-37.497308,0> translate<35.649672,-1.535000,2.237388> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,0.000000,5.454409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,0.000000,5.300363>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,37.497308,0> translate<35.649672,0.000000,5.454409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.649672,-1.535000,5.454409>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,-1.535000,5.300363>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,37.497308,0> translate<35.649672,-1.535000,5.454409> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.821038,-1.535000,11.811000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,-1.535000,11.659288>}
box{<0,0,-0.406400><0.214554,0.035000,0.406400> rotate<0,44.997030,0> translate<35.821038,-1.535000,11.811000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.839397,0.000000,27.531781>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.839397,0.000000,28.302644>}
box{<0,0,-0.406400><0.770862,0.035000,0.406400> rotate<0,90.000000,0> translate<35.839397,0.000000,28.302644> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.839397,0.000000,27.531781>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.355178,0.000000,27.015997>}
box{<0,0,-0.406400><0.729427,0.035000,0.406400> rotate<0,44.997204,0> translate<35.839397,0.000000,27.531781> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.839397,0.000000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,27.635200>}
box{<0,0,-0.406400><6.007103,0.035000,0.406400> rotate<0,0.000000,0> translate<35.839397,0.000000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.839397,0.000000,28.302644>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,28.169288>}
box{<0,0,-0.406400><0.188592,0.035000,0.406400> rotate<0,44.997701,0> translate<35.839397,0.000000,28.302644> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,0.000000,2.391434>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,0.000000,2.480891>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.998031,0> translate<35.850431,0.000000,2.391434> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,-1.535000,2.391434>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,-1.535000,2.480891>}
box{<0,0,-0.406400><0.126508,0.035000,0.406400> rotate<0,-44.998031,0> translate<35.850431,-1.535000,2.391434> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,0.000000,5.300363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,0.000000,5.210903>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.999032,0> translate<35.850431,0.000000,5.300363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.850431,-1.535000,5.300363>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939884,-1.535000,5.210903>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.999032,0> translate<35.850431,-1.535000,5.300363> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.897394,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.653591,0.000000,2.438400>}
box{<0,0,-0.406400><0.756197,0.035000,0.406400> rotate<0,0.000000,0> translate<35.897394,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.897394,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.653591,-1.535000,2.438400>}
box{<0,0,-0.406400><0.756197,0.035000,0.406400> rotate<0,0.000000,0> translate<35.897394,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939903,0.000000,5.210884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,0.000000,5.121431>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.995029,0> translate<35.939903,0.000000,5.210884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939903,-1.535000,5.210884>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,-1.535000,5.121431>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,44.995029,0> translate<35.939903,-1.535000,5.210884> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939906,0.000000,2.480909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,0.000000,2.570366>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,-44.997030,0> translate<35.939906,0.000000,2.480909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.939906,-1.535000,2.480909>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,-1.535000,2.570366>}
box{<0,0,-0.406400><0.126510,0.035000,0.406400> rotate<0,-44.997030,0> translate<35.939906,-1.535000,2.480909> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,11.659288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,11.353800>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,22.498589,0> translate<35.972750,0.000000,11.659288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,-1.535000,11.659288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,-1.535000,11.353800>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,22.498589,0> translate<35.972750,-1.535000,11.659288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,15.061509>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,15.366997>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<35.972750,0.000000,15.061509> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,20.090709>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,20.396197>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<35.972750,0.000000,20.090709> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<35.972750,0.000000,28.169288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,27.863800>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,22.498589,0> translate<35.972750,0.000000,28.169288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,0.000000,2.570366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,0.000000,2.771125>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<36.029363,0.000000,2.570366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,-1.535000,2.570366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,-1.535000,2.771125>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-52.496753,0> translate<36.029363,-1.535000,2.570366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,0.000000,5.121431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,0.000000,4.920672>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<36.029363,0.000000,5.121431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.029363,-1.535000,5.121431>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,-1.535000,4.920672>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,52.496753,0> translate<36.029363,-1.535000,5.121431> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,0.000000,2.771125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,0.000000,2.990272>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<36.183409,0.000000,2.771125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,-1.535000,2.771125>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,-1.535000,2.990272>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-59.995944,0> translate<36.183409,-1.535000,2.771125> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,0.000000,4.920672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,0.000000,4.701525>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,59.995944,0> translate<36.183409,0.000000,4.920672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.183409,-1.535000,4.920672>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,-1.535000,4.701525>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,59.995944,0> translate<36.183409,-1.535000,4.920672> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.208741,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.504053,0.000000,4.876800>}
box{<0,0,-0.406400><3.295312,0.035000,0.406400> rotate<0,0.000000,0> translate<36.208741,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.208741,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.504053,-1.535000,4.876800>}
box{<0,0,-0.406400><3.295312,0.035000,0.406400> rotate<0,0.000000,0> translate<36.208741,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.265044,-1.535000,7.429600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.392631,-1.535000,7.454978>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-11.248995,0> translate<36.265044,-1.535000,7.429600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.265044,-1.535000,10.350397>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.392631,-1.535000,10.325019>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,11.248995,0> translate<36.265044,-1.535000,10.350397> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,0.000000,2.990272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,0.000000,3.224059>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-67.495640,0> translate<36.309934,0.000000,2.990272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,-1.535000,2.990272>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,-1.535000,3.224059>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,-67.495640,0> translate<36.309934,-1.535000,2.990272> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,0.000000,4.701525>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,0.000000,4.467738>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,67.495640,0> translate<36.309934,0.000000,4.701525> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.309934,-1.535000,4.701525>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,-1.535000,4.467738>}
box{<0,0,-0.406400><0.253050,0.035000,0.406400> rotate<0,67.495640,0> translate<36.309934,-1.535000,4.701525> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.355178,0.000000,27.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.582094,0.000000,27.015997>}
box{<0,0,-0.406400><0.226916,0.035000,0.406400> rotate<0,0.000000,0> translate<36.355178,0.000000,27.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.392631,-1.535000,7.454978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.512816,-1.535000,7.504759>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-22.498211,0> translate<36.392631,-1.535000,7.454978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.392631,-1.535000,10.325019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.512816,-1.535000,10.275238>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,22.498211,0> translate<36.392631,-1.535000,10.325019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,0.000000,3.224059>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,0.000000,3.468488>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-74.994491,0> translate<36.406772,0.000000,3.224059> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,-1.535000,3.224059>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,-1.535000,3.468488>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,-74.994491,0> translate<36.406772,-1.535000,3.224059> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,0.000000,4.467738>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,0.000000,4.223309>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,74.994491,0> translate<36.406772,0.000000,4.467738> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.406772,-1.535000,4.467738>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,-1.535000,4.223309>}
box{<0,0,-0.406400><0.253051,0.035000,0.406400> rotate<0,74.994491,0> translate<36.406772,-1.535000,4.467738> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.414044,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.838088,0.000000,3.251200>}
box{<0,0,-0.406400><1.424044,0.035000,0.406400> rotate<0,0.000000,0> translate<36.414044,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.414044,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.838088,-1.535000,3.251200>}
box{<0,0,-0.406400><1.424044,0.035000,0.406400> rotate<0,0.000000,0> translate<36.414044,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,0.000000,3.468488>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,0.000000,3.719372>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-82.494876,0> translate<36.472269,0.000000,3.468488> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,-1.535000,3.468488>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,-1.535000,3.719372>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,-82.494876,0> translate<36.472269,-1.535000,3.468488> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,0.000000,4.223309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,0.000000,3.972425>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,82.494876,0> translate<36.472269,0.000000,4.223309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.472269,-1.535000,4.223309>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,-1.535000,3.972425>}
box{<0,0,-0.406400><0.253049,0.035000,0.406400> rotate<0,82.494876,0> translate<36.472269,-1.535000,4.223309> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.493244,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.748719,0.000000,4.064000>}
box{<0,0,-0.406400><2.255475,0.035000,0.406400> rotate<0,0.000000,0> translate<36.493244,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.493244,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.748719,-1.535000,4.064000>}
box{<0,0,-0.406400><2.255475,0.035000,0.406400> rotate<0,0.000000,0> translate<36.493244,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,0.000000,3.719372>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,0.000000,3.972425>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,90.000000,0> translate<36.505297,0.000000,3.972425> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,-1.535000,3.719372>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.505297,-1.535000,3.972425>}
box{<0,0,-0.406400><0.253053,0.035000,0.406400> rotate<0,90.000000,0> translate<36.505297,-1.535000,3.972425> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.512816,-1.535000,7.504759>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.620978,-1.535000,7.577034>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-33.748918,0> translate<36.512816,-1.535000,7.504759> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.512816,-1.535000,10.275238>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.620978,-1.535000,10.202962>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,33.748918,0> translate<36.512816,-1.535000,10.275238> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.582094,0.000000,27.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.830000,0.000000,26.913312>}
box{<0,0,-0.406400><0.268331,0.035000,0.406400> rotate<0,22.498169,0> translate<36.582094,0.000000,27.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.620978,-1.535000,7.577034>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.712963,-1.535000,7.669019>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-44.997030,0> translate<36.620978,-1.535000,7.577034> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.620978,-1.535000,10.202962>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.712963,-1.535000,10.110978>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,44.997030,0> translate<36.620978,-1.535000,10.202962> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,11.353800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,11.353800>}
box{<0,0,-0.406400><2.779478,0.035000,0.406400> rotate<0,0.000000,0> translate<36.710259,0.000000,11.353800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,-1.535000,11.353800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,-1.535000,11.353800>}
box{<0,0,-0.406400><2.779478,0.035000,0.406400> rotate<0,0.000000,0> translate<36.710259,-1.535000,11.353800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,15.366997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,15.366997>}
box{<0,0,-0.406400><2.779478,0.035000,0.406400> rotate<0,0.000000,0> translate<36.710259,0.000000,15.366997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,20.396197>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,20.396197>}
box{<0,0,-0.406400><2.779478,0.035000,0.406400> rotate<0,0.000000,0> translate<36.710259,0.000000,20.396197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.710259,0.000000,27.863800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,27.863800>}
box{<0,0,-0.406400><2.779478,0.035000,0.406400> rotate<0,0.000000,0> translate<36.710259,0.000000,27.863800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.712963,-1.535000,7.669019>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.785238,-1.535000,7.777181>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,-56.245142,0> translate<36.712963,-1.535000,7.669019> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.712963,-1.535000,10.110978>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.785238,-1.535000,10.002816>}
box{<0,0,-0.406400><0.130088,0.035000,0.406400> rotate<0,56.245142,0> translate<36.712963,-1.535000,10.110978> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.732094,0.000000,21.044000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.829997,0.000000,21.084556>}
box{<0,0,-0.406400><0.105971,0.035000,0.406400> rotate<0,-22.500237,0> translate<36.732094,0.000000,21.044000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.785238,-1.535000,7.777181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.835019,-1.535000,7.897366>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,-67.495850,0> translate<36.785238,-1.535000,7.777181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.785238,-1.535000,10.002816>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.835019,-1.535000,9.882631>}
box{<0,0,-0.406400><0.130086,0.035000,0.406400> rotate<0,67.495850,0> translate<36.785238,-1.535000,10.002816> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.829997,0.000000,21.084556>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.927903,0.000000,21.044000>}
box{<0,0,-0.406400><0.105974,0.035000,0.406400> rotate<0,22.499591,0> translate<36.829997,0.000000,21.084556> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.830000,0.000000,26.913312>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.077903,0.000000,27.015997>}
box{<0,0,-0.406400><0.268328,0.035000,0.406400> rotate<0,-22.498424,0> translate<36.830000,0.000000,26.913312> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.835019,-1.535000,7.897366>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,8.024953>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,-78.745065,0> translate<36.835019,-1.535000,7.897366> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.835019,-1.535000,9.882631>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,9.755044>}
box{<0,0,-0.406400><0.130087,0.035000,0.406400> rotate<0,78.745065,0> translate<36.835019,-1.535000,9.882631> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860394,-1.535000,8.889981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,8.024953>}
box{<0,0,-0.406400><0.865028,0.035000,0.406400> rotate<0,89.993853,0> translate<36.860394,-1.535000,8.889981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.885097,-1.535000,8.128000>}
box{<0,0,-0.406400><0.024700,0.035000,0.406400> rotate<0,0.000000,0> translate<36.860397,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,8.890013>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,9.755044>}
box{<0,0,-0.406400><0.865031,0.035000,0.406400> rotate<0,90.000000,0> translate<36.860397,-1.535000,9.755044> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.903319,-1.535000,8.940800>}
box{<0,0,-0.406400><0.042922,0.035000,0.406400> rotate<0,0.000000,0> translate<36.860397,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.860397,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.249709,-1.535000,9.753600>}
box{<0,0,-0.406400><0.389313,0.035000,0.406400> rotate<0,0.000000,0> translate<36.860397,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.873800,0.000000,2.550603>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.195850,0.000000,3.511131>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,-35.997697,0> translate<36.873800,0.000000,2.550603> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.873800,-1.535000,2.550603>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.195850,-1.535000,3.511131>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,-35.997697,0> translate<36.873800,-1.535000,2.550603> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.885097,-1.535000,7.987381>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.233119,-1.535000,7.147181>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,67.495566,0> translate<36.885097,-1.535000,7.987381> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.885097,-1.535000,8.896809>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.885097,-1.535000,7.987381>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,-90.000000,0> translate<36.885097,-1.535000,7.987381> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.885097,-1.535000,8.896809>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.233119,-1.535000,9.737009>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-67.495566,0> translate<36.885097,-1.535000,8.896809> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<36.927903,0.000000,21.044000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.632094,0.000000,21.044000>}
box{<0,0,-0.406400><1.704191,0.035000,0.406400> rotate<0,0.000000,0> translate<36.927903,0.000000,21.044000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.077903,0.000000,27.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.682094,0.000000,27.015997>}
box{<0,0,-0.406400><1.604191,0.035000,0.406400> rotate<0,0.000000,0> translate<37.077903,0.000000,27.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.207222,0.000000,16.230600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.216525,0.000000,16.226881>}
box{<0,0,-0.406400><0.010019,0.035000,0.406400> rotate<0,21.786697,0> translate<37.207222,0.000000,16.230600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.216525,0.000000,16.226881>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.515037,0.000000,16.230600>}
box{<0,0,-0.406400><0.298536,0.035000,0.406400> rotate<0,-0.713684,0> translate<37.216525,0.000000,16.226881> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.233119,-1.535000,7.147181>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,-1.535000,6.504119>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,44.997030,0> translate<37.233119,-1.535000,7.147181> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.233119,-1.535000,9.737009>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,-1.535000,10.380072>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,-44.997030,0> translate<37.233119,-1.535000,9.737009> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.487603,0.000000,6.892697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,0.000000,6.504119>}
box{<0,0,-0.406400><0.549532,0.035000,0.406400> rotate<0,44.997030,0> translate<37.487603,0.000000,6.892697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.487603,0.000000,9.991494>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,0.000000,10.380072>}
box{<0,0,-0.406400><0.549532,0.035000,0.406400> rotate<0,-44.997030,0> translate<37.487603,0.000000,9.991494> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.515037,0.000000,16.230600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.813594,0.000000,16.230600>}
box{<0,0,-0.406400><0.298556,0.035000,0.406400> rotate<0,0.000000,0> translate<37.515037,0.000000,16.230600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.813594,0.000000,16.230600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.822850,0.000000,16.234434>}
box{<0,0,-0.406400><0.010019,0.035000,0.406400> rotate<0,-22.500157,0> translate<37.813594,0.000000,16.230600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.822850,0.000000,16.234434>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.832869,0.000000,16.234559>}
box{<0,0,-0.406400><0.010020,0.035000,0.406400> rotate<0,-0.714773,0> translate<37.822850,0.000000,16.234434> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.832869,0.000000,16.234559>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.107222,0.000000,16.352225>}
box{<0,0,-0.406400><0.298521,0.035000,0.406400> rotate<0,-23.212180,0> translate<37.832869,0.000000,16.234559> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,0.000000,6.504119>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,0.000000,6.156097>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,22.498494,0> translate<37.876181,0.000000,6.504119> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,-1.535000,6.504119>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,-1.535000,6.156097>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,22.498494,0> translate<37.876181,-1.535000,6.504119> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,0.000000,10.380072>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,0.000000,10.728094>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-22.498494,0> translate<37.876181,0.000000,10.380072> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.876181,-1.535000,10.380072>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,-1.535000,10.728094>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-22.498494,0> translate<37.876181,-1.535000,10.380072> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<37.882859,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,16.256000>}
box{<0,0,-0.406400><3.963641,0.035000,0.406400> rotate<0,0.000000,0> translate<37.882859,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.107222,0.000000,16.352225>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.181519,0.000000,16.383000>}
box{<0,0,-0.406400><0.080418,0.035000,0.406400> rotate<0,-22.498664,0> translate<38.107222,0.000000,16.352225> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.181519,0.000000,16.383000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,16.383000>}
box{<0,0,-0.406400><1.308219,0.035000,0.406400> rotate<0,0.000000,0> translate<38.181519,0.000000,16.383000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.195850,0.000000,3.511131>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.351366,0.000000,4.666647>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,-44.997030,0> translate<38.195850,0.000000,3.511131> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.195850,-1.535000,3.511131>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.351366,-1.535000,4.666647>}
box{<0,0,-0.406400><1.634146,0.035000,0.406400> rotate<0,-44.997030,0> translate<38.195850,-1.535000,3.511131> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.632094,0.000000,21.044000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.005516,0.000000,21.198675>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-22.498331,0> translate<38.632094,0.000000,21.044000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.682094,0.000000,27.015997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.055516,0.000000,26.861322>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,22.498331,0> translate<38.682094,0.000000,27.015997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,0.000000,6.156097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,0.000000,6.156097>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,0.000000,0> translate<38.716381,0.000000,6.156097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,-1.535000,6.156097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,-1.535000,6.156097>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,0.000000,0> translate<38.716381,-1.535000,6.156097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,0.000000,10.728094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,0.000000,10.728094>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,0.000000,0> translate<38.716381,0.000000,10.728094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.716381,-1.535000,10.728094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,-1.535000,10.728094>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,0.000000,0> translate<38.716381,-1.535000,10.728094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<38.846475,0.000000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,21.132800>}
box{<0,0,-0.406400><3.000025,0.035000,0.406400> rotate<0,0.000000,0> translate<38.846475,0.000000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.005516,0.000000,21.198675>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.291322,0.000000,21.484481>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,-44.997030,0> translate<39.005516,0.000000,21.198675> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.055516,0.000000,26.861322>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.341322,0.000000,26.575516>}
box{<0,0,-0.406400><0.404191,0.035000,0.406400> rotate<0,44.997030,0> translate<39.055516,0.000000,26.861322> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.094438,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,26.822400>}
box{<0,0,-0.406400><2.752062,0.035000,0.406400> rotate<0,0.000000,0> translate<39.094438,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.291322,0.000000,21.484481>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.445997,0.000000,21.857903>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,-67.495729,0> translate<39.291322,0.000000,21.484481> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.341322,0.000000,26.575516>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.495997,0.000000,26.202094>}
box{<0,0,-0.406400><0.404188,0.035000,0.406400> rotate<0,67.495729,0> translate<39.341322,0.000000,26.575516> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.351366,0.000000,4.666647>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.311894,0.000000,5.988697>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,-53.996363,0> translate<39.351366,0.000000,4.666647> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.351366,-1.535000,4.666647>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.311894,-1.535000,5.988697>}
box{<0,0,-0.406400><1.634145,0.035000,0.406400> rotate<0,-53.996363,0> translate<39.351366,-1.535000,4.666647> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.429397,0.000000,23.902166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.429397,0.000000,24.437116>}
box{<0,0,-0.406400><0.534950,0.035000,0.406400> rotate<0,90.000000,0> translate<39.429397,0.000000,24.437116> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.429397,0.000000,23.902166>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.445997,0.000000,23.862094>}
box{<0,0,-0.406400><0.043374,0.035000,0.406400> rotate<0,67.493488,0> translate<39.429397,0.000000,23.902166> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.429397,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,24.384000>}
box{<0,0,-0.406400><2.417103,0.035000,0.406400> rotate<0,0.000000,0> translate<39.429397,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.429397,0.000000,24.437116>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.495997,0.000000,24.597903>}
box{<0,0,-0.406400><0.174035,0.035000,0.406400> rotate<0,-67.495656,0> translate<39.429397,0.000000,24.437116> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.445997,0.000000,21.857903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.445997,0.000000,23.862094>}
box{<0,0,-0.406400><2.004191,0.035000,0.406400> rotate<0,90.000000,0> translate<39.445997,0.000000,23.862094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.445997,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,21.945600>}
box{<0,0,-0.406400><2.400503,0.035000,0.406400> rotate<0,0.000000,0> translate<39.445997,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.445997,0.000000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,22.758400>}
box{<0,0,-0.406400><2.400503,0.035000,0.406400> rotate<0,0.000000,0> translate<39.445997,0.000000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.445997,0.000000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,23.571200>}
box{<0,0,-0.406400><2.400503,0.035000,0.406400> rotate<0,0.000000,0> translate<39.445997,0.000000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,11.353800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,11.659288>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<39.489738,0.000000,11.353800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,-1.535000,11.353800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,-1.535000,11.659288>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<39.489738,-1.535000,11.353800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,15.366997>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,15.061509>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,22.498589,0> translate<39.489738,0.000000,15.366997> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,16.383000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,16.688488>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<39.489738,0.000000,16.383000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,20.396197>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,20.090709>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,22.498589,0> translate<39.489738,0.000000,20.396197> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.489738,0.000000,27.863800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,28.169288>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-22.498589,0> translate<39.489738,0.000000,27.863800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.495997,0.000000,24.597903>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.495997,0.000000,26.202094>}
box{<0,0,-0.406400><1.604191,0.035000,0.406400> rotate<0,90.000000,0> translate<39.495997,0.000000,26.202094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.495997,0.000000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,25.196800>}
box{<0,0,-0.406400><2.350503,0.035000,0.406400> rotate<0,0.000000,0> translate<39.495997,0.000000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.495997,0.000000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,26.009600>}
box{<0,0,-0.406400><2.350503,0.035000,0.406400> rotate<0,0.000000,0> translate<39.495997,0.000000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.551056,0.000000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.844506,0.000000,11.379200>}
box{<0,0,-0.406400><2.293450,0.035000,0.406400> rotate<0,0.000000,0> translate<39.551056,0.000000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.551056,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.844506,-1.535000,11.379200>}
box{<0,0,-0.406400><2.293450,0.035000,0.406400> rotate<0,0.000000,0> translate<39.551056,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,0.000000,6.156097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,0.000000,6.504119>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-22.498494,0> translate<39.625809,0.000000,6.156097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,-1.535000,6.156097>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,-1.535000,6.504119>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,-22.498494,0> translate<39.625809,-1.535000,6.156097> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,0.000000,10.728094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,0.000000,10.380072>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,22.498494,0> translate<39.625809,0.000000,10.728094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.625809,-1.535000,10.728094>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,-1.535000,10.380072>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,22.498494,0> translate<39.625809,-1.535000,10.728094> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<39.673694,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,20.320000>}
box{<0,0,-0.406400><2.172806,0.035000,0.406400> rotate<0,0.000000,0> translate<39.673694,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.016175,0.000000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.807028,0.000000,10.566400>}
box{<0,0,-0.406400><1.790853,0.035000,0.406400> rotate<0,0.000000,0> translate<40.016175,0.000000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.016175,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.807028,-1.535000,10.566400>}
box{<0,0,-0.406400><1.790853,0.035000,0.406400> rotate<0,0.000000,0> translate<40.016175,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,-1.535000,11.659288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.407500,-1.535000,11.839544>}
box{<0,0,-0.406400><0.254919,0.035000,0.406400> rotate<0,-44.997527,0> translate<40.227247,-1.535000,11.659288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,11.659288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,12.223750>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,-44.997030,0> translate<40.227247,0.000000,11.659288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,15.061509>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,14.497047>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,44.997030,0> translate<40.227247,0.000000,15.061509> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,16.688488>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,17.252950>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,-44.997030,0> translate<40.227247,0.000000,16.688488> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,20.090709>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,19.526247>}
box{<0,0,-0.406400><0.798271,0.035000,0.406400> rotate<0,44.997030,0> translate<40.227247,0.000000,20.090709> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.227247,0.000000,28.169288>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.407500,0.000000,28.349544>}
box{<0,0,-0.406400><0.254919,0.035000,0.406400> rotate<0,-44.997527,0> translate<40.227247,0.000000,28.169288> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.311894,-1.535000,5.988697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.687238,-1.535000,6.725347>}
box{<0,0,-0.406400><0.826762,0.035000,0.406400> rotate<0,-62.995729,0> translate<40.311894,-1.535000,5.988697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.311894,0.000000,5.988697>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.687238,0.000000,6.725350>}
box{<0,0,-0.406400><0.826765,0.035000,0.406400> rotate<0,-62.995828,0> translate<40.311894,0.000000,5.988697> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.407500,-1.535000,11.839544>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.908062,-1.535000,12.046881>}
box{<0,0,-0.406400><0.541804,0.035000,0.406400> rotate<0,-22.498293,0> translate<40.407500,-1.535000,11.839544> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.407500,0.000000,28.349544>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.908062,0.000000,28.556881>}
box{<0,0,-0.406400><0.541804,0.035000,0.406400> rotate<0,-22.498293,0> translate<40.407500,0.000000,28.349544> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.461859,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.573641,0.000000,6.502400>}
box{<0,0,-0.406400><0.111781,0.035000,0.406400> rotate<0,0.000000,0> translate<40.461859,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.461859,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.573641,-1.535000,6.502400>}
box{<0,0,-0.406400><0.111781,0.035000,0.406400> rotate<0,0.000000,0> translate<40.461859,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,-1.535000,6.504119>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.687238,-1.535000,6.725347>}
box{<0,0,-0.406400><0.312864,0.035000,0.406400> rotate<0,-44.997030,0> translate<40.466009,-1.535000,6.504119> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,0.000000,6.504119>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.687238,0.000000,6.725350>}
box{<0,0,-0.406400><0.312866,0.035000,0.406400> rotate<0,-44.997435,0> translate<40.466009,0.000000,6.504119> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,0.000000,10.380072>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.109072,0.000000,9.737009>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,44.997030,0> translate<40.466009,0.000000,10.380072> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.466009,-1.535000,10.380072>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.109072,-1.535000,9.737009>}
box{<0,0,-0.406400><0.909428,0.035000,0.406400> rotate<0,44.997030,0> translate<40.466009,-1.535000,10.380072> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.607559,0.000000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,17.068800>}
box{<0,0,-0.406400><1.238941,0.035000,0.406400> rotate<0,0.000000,0> translate<40.607559,0.000000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.645197,0.000000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,28.448000>}
box{<0,0,-0.406400><1.201303,0.035000,0.406400> rotate<0,0.000000,0> translate<40.645197,0.000000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.658356,0.000000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,14.630400>}
box{<0,0,-0.406400><1.188144,0.035000,0.406400> rotate<0,0.000000,0> translate<40.658356,0.000000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.759959,0.000000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,12.192000>}
box{<0,0,-0.406400><1.086541,0.035000,0.406400> rotate<0,0.000000,0> translate<40.759959,0.000000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,12.223750>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,12.961259>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-67.495471,0> translate<40.791709,0.000000,12.223750> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,14.497047>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,13.759538>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,67.495471,0> translate<40.791709,0.000000,14.497047> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,17.252950>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,17.990459>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,-67.495471,0> translate<40.791709,0.000000,17.252950> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.791709,0.000000,19.526247>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,18.788737>}
box{<0,0,-0.406400><0.798275,0.035000,0.406400> rotate<0,67.495471,0> translate<40.791709,0.000000,19.526247> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.799600,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,19.507200>}
box{<0,0,-0.406400><1.046900,0.035000,0.406400> rotate<0,0.000000,0> translate<40.799600,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.908062,-1.535000,12.046881>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.835163,-1.535000,12.973981>}
box{<0,0,-0.406400><1.311117,0.035000,0.406400> rotate<0,-44.997030,0> translate<40.908062,-1.535000,12.046881> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<40.908062,0.000000,28.556881>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.343916,0.000000,28.992734>}
box{<0,0,-0.406400><0.616389,0.035000,0.406400> rotate<0,-44.997030,0> translate<40.908062,0.000000,28.556881> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.052103,0.000000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,17.881600>}
box{<0,0,-0.406400><0.794397,0.035000,0.406400> rotate<0,0.000000,0> translate<41.052103,0.000000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.053181,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,-1.535000,12.192000>}
box{<0,0,-0.406400><0.793319,0.035000,0.406400> rotate<0,0.000000,0> translate<41.053181,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.073147,0.000000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,13.817600>}
box{<0,0,-0.406400><0.773353,0.035000,0.406400> rotate<0,0.000000,0> translate<41.073147,0.000000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.092481,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.678294,0.000000,9.753600>}
box{<0,0,-0.406400><0.585813,0.035000,0.406400> rotate<0,0.000000,0> translate<41.092481,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.092481,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.678294,-1.535000,9.753600>}
box{<0,0,-0.406400><0.585813,0.035000,0.406400> rotate<0,0.000000,0> translate<41.092481,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,12.961259>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,13.759538>}
box{<0,0,-0.406400><0.798278,0.035000,0.406400> rotate<0,90.000000,0> translate<41.097197,0.000000,13.759538> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,13.004800>}
box{<0,0,-0.406400><0.749303,0.035000,0.406400> rotate<0,0.000000,0> translate<41.097197,0.000000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,17.990459>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,18.788737>}
box{<0,0,-0.406400><0.798278,0.035000,0.406400> rotate<0,90.000000,0> translate<41.097197,0.000000,18.788737> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.097197,0.000000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,18.694400>}
box{<0,0,-0.406400><0.749303,0.035000,0.406400> rotate<0,0.000000,0> translate<41.097197,0.000000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.109072,0.000000,9.737009>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,0.000000,8.896809>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,67.495566,0> translate<41.109072,0.000000,9.737009> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.109072,-1.535000,9.737009>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,-1.535000,8.896809>}
box{<0,0,-0.406400><0.909426,0.035000,0.406400> rotate<0,67.495566,0> translate<41.109072,-1.535000,9.737009> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.343916,0.000000,28.992734>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,29.495322>}
box{<0,0,-0.406400><0.710764,0.035000,0.406400> rotate<0,-44.997208,0> translate<41.343916,0.000000,28.992734> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.438875,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.539884,0.000000,8.940800>}
box{<0,0,-0.406400><0.101009,0.035000,0.406400> rotate<0,0.000000,0> translate<41.438875,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.438875,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.539884,-1.535000,8.940800>}
box{<0,0,-0.406400><0.101009,0.035000,0.406400> rotate<0,0.000000,0> translate<41.438875,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,0.000000,8.686000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,0.000000,8.896809>}
box{<0,0,-0.406400><0.210809,0.035000,0.406400> rotate<0,90.000000,0> translate<41.457094,0.000000,8.896809> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,-1.535000,8.686000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,-1.535000,8.896809>}
box{<0,0,-0.406400><0.210809,0.035000,0.406400> rotate<0,90.000000,0> translate<41.457094,-1.535000,8.896809> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,0.000000,8.686000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.558759,0.000000,8.998900>}
box{<0,0,-0.406400><0.329002,0.035000,0.406400> rotate<0,-71.995538,0> translate<41.457094,0.000000,8.686000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.457094,-1.535000,8.686000>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.558759,-1.535000,8.998900>}
box{<0,0,-0.406400><0.329002,0.035000,0.406400> rotate<0,-71.995538,0> translate<41.457094,-1.535000,8.686000> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.558759,0.000000,8.998900>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814397,0.000000,10.612928>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,-80.994635,0> translate<41.558759,0.000000,8.998900> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.558759,-1.535000,8.998900>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814397,-1.535000,10.612928>}
box{<0,0,-0.406400><1.634147,0.035000,0.406400> rotate<0,-80.994635,0> translate<41.558759,-1.535000,8.998900> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.611978,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,29.260800>}
box{<0,0,-0.406400><0.234522,0.035000,0.406400> rotate<0,0.000000,0> translate<41.611978,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814397,0.000000,10.612928>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814400,0.000000,10.612928>}
box{<0,0,-0.406400><0.000003,0.035000,0.406400> rotate<0,0.000000,0> translate<41.814397,0.000000,10.612928> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814397,-1.535000,10.612928>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814400,-1.535000,10.612928>}
box{<0,0,-0.406400><0.000003,0.035000,0.406400> rotate<0,0.000000,0> translate<41.814397,-1.535000,10.612928> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814400,0.000000,10.612928>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,11.429984>}
box{<0,0,-0.406400><0.817687,0.035000,0.406400> rotate<0,-87.744365,0> translate<41.814400,0.000000,10.612928> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.814400,-1.535000,10.612928>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,-1.535000,11.429984>}
box{<0,0,-0.406400><0.817687,0.035000,0.406400> rotate<0,-87.744365,0> translate<41.814400,-1.535000,10.612928> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.835163,-1.535000,12.973981>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,-1.535000,12.985322>}
box{<0,0,-0.406400><0.016036,0.035000,0.406400> rotate<0,-45.004925,0> translate<41.835163,-1.535000,12.973981> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,-1.535000,12.985322>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,-1.535000,11.429984>}
box{<0,0,-0.406400><1.555338,0.035000,0.406400> rotate<0,-90.000000,0> translate<41.846500,-1.535000,11.429984> }
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,29.495322>}
cylinder{<0,0,0><0,0.035000,0>0.406400 translate<41.846500,0.000000,11.429984>}
box{<0,0,-0.406400><18.065338,0.035000,0.406400> rotate<0,-90.000000,0> translate<41.846500,0.000000,11.429984> }
texture{col_pol}
}
#end
union{
cylinder{<7.620000,0.038000,31.115000><7.620000,-1.538000,31.115000>0.406400}
cylinder{<7.620000,0.038000,20.955000><7.620000,-1.538000,20.955000>0.406400}
cylinder{<34.574900,0.038000,3.845900><34.574900,-1.538000,3.845900>0.650000}
cylinder{<39.171097,0.038000,8.442097><39.171097,-1.538000,8.442097>0.650000}
cylinder{<21.550000,0.038000,33.115000><21.550000,-1.538000,33.115000>0.400000}
cylinder{<16.550000,0.038000,33.115000><16.550000,-1.538000,33.115000>0.400000}
cylinder{<26.750000,0.038000,3.715000><26.750000,-1.538000,3.715000>0.400000}
cylinder{<11.350000,0.038000,3.715000><11.350000,-1.538000,3.715000>0.400000}
cylinder{<2.413000,0.038000,23.495000><2.413000,-1.538000,23.495000>0.457200}
cylinder{<5.207000,0.038000,28.575000><5.207000,-1.538000,28.575000>0.457200}
cylinder{<3.385900,0.038000,8.201097><3.385900,-1.538000,8.201097>0.650000}
cylinder{<7.982097,0.038000,3.604900><7.982097,-1.538000,3.604900>0.650000}
cylinder{<16.860000,0.038000,42.105200><16.860000,-1.538000,42.105200>0.400000}
cylinder{<11.780000,0.038000,42.105200><11.780000,-1.538000,42.105200>0.400000}
cylinder{<14.320000,0.038000,42.105200><14.320000,-1.538000,42.105200>0.400000}
cylinder{<19.400000,0.038000,42.105200><19.400000,-1.538000,42.105200>0.400000}
cylinder{<31.170000,0.038000,42.925000><31.170000,-1.538000,42.925000>0.550000}
cylinder{<31.170000,0.038000,37.845000><31.170000,-1.538000,37.845000>0.550000}
cylinder{<31.170000,0.038000,27.685000><31.170000,-1.538000,27.685000>0.550000}
cylinder{<31.170000,0.038000,25.145000><31.170000,-1.538000,25.145000>0.550000}
cylinder{<3.283950,0.038000,39.478947><3.283950,-1.538000,39.478947>0.508000}
cylinder{<5.080000,0.038000,41.275000><5.080000,-1.538000,41.275000>0.508000}
cylinder{<6.876053,0.038000,43.071050><6.876053,-1.538000,43.071050>0.508000}
cylinder{<5.080000,0.038000,12.090400><5.080000,-1.538000,12.090400>0.660400}
cylinder{<5.080000,0.038000,17.119600><5.080000,-1.538000,17.119600>0.660400}
cylinder{<38.100000,0.038000,13.360400><38.100000,-1.538000,13.360400>0.660400}
cylinder{<38.100000,0.038000,18.389600><38.100000,-1.538000,18.389600>0.660400}
cylinder{<38.100000,0.038000,29.870400><38.100000,-1.538000,29.870400>0.660400}
cylinder{<38.100000,0.038000,34.899600><38.100000,-1.538000,34.899600>0.660400}
//Furos(rápido)/Vias
cylinder{<24.130000,0.038000,25.400000><24.130000,-1.538000,25.400000>0.400000 }
cylinder{<27.940000,0.038000,39.370000><27.940000,-1.538000,39.370000>0.400000 }
cylinder{<31.115000,0.038000,35.560000><31.115000,-1.538000,35.560000>0.400000 }
cylinder{<20.320000,0.038000,36.830000><20.320000,-1.538000,36.830000>0.400000 }
cylinder{<18.415000,0.038000,26.987500><18.415000,-1.538000,26.987500>0.400000 }
cylinder{<27.940000,0.038000,29.527500><27.940000,-1.538000,29.527500>0.400000 }
cylinder{<29.210000,0.038000,22.860000><29.210000,-1.538000,22.860000>0.400000 }
cylinder{<11.430000,0.038000,36.195000><11.430000,-1.538000,36.195000>0.400000 }
cylinder{<35.560000,0.038000,11.112500><35.560000,-1.538000,11.112500>0.300000 }
cylinder{<13.970000,0.038000,30.480000><13.970000,-1.538000,30.480000>0.400000 }
cylinder{<38.100000,0.038000,41.910000><38.100000,-1.538000,41.910000>0.400000 }
cylinder{<15.875000,0.038000,22.225000><15.875000,-1.538000,22.225000>0.400000 }
cylinder{<30.480000,0.038000,6.350000><30.480000,-1.538000,6.350000>0.300000 }
cylinder{<20.320000,0.038000,17.780000><20.320000,-1.538000,17.780000>0.300000 }
cylinder{<22.860000,0.038000,20.955000><22.860000,-1.538000,20.955000>0.400000 }
//Furos(rápido)/Placas
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.857500,0.000000,32.492763>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.090528,0.000000,33.259731>}
box{<0,0,-0.076200><1.084660,0.036000,0.076200> rotate<0,44.996913,0> translate<2.090528,0.000000,33.259731> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.090528,0.000000,33.259731>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.090528,0.000000,34.026700>}
box{<0,0,-0.076200><0.766969,0.036000,0.076200> rotate<0,90.000000,0> translate<2.090528,0.000000,34.026700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.090528,0.000000,34.026700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.857500,0.000000,34.026700>}
box{<0,0,-0.076200><0.766972,0.036000,0.076200> rotate<0,0.000000,0> translate<2.090528,0.000000,34.026700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.857500,0.000000,34.026700>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.624469,0.000000,33.259731>}
box{<0,0,-0.076200><1.084658,0.036000,0.076200> rotate<0,44.997030,0> translate<2.857500,0.000000,34.026700> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.282272,0.000000,33.067988>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.049241,0.000000,33.834959>}
box{<0,0,-0.076200><1.084660,0.036000,0.076200> rotate<0,-44.997147,0> translate<2.282272,0.000000,33.067988> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.015144,0.000000,33.650406>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.248172,0.000000,34.417375>}
box{<0,0,-0.076200><1.084660,0.036000,0.076200> rotate<0,44.996913,0> translate<3.248172,0.000000,34.417375> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.248172,0.000000,34.417375>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.823400,0.000000,34.992603>}
box{<0,0,-0.076200><0.813495,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.248172,0.000000,34.417375> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.823400,0.000000,34.992603>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.206884,0.000000,34.992603>}
box{<0,0,-0.076200><0.383484,0.036000,0.076200> rotate<0,0.000000,0> translate<3.823400,0.000000,34.992603> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.206884,0.000000,34.992603>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.782113,0.000000,34.417375>}
box{<0,0,-0.076200><0.813495,0.036000,0.076200> rotate<0,44.997030,0> translate<4.206884,0.000000,34.992603> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.789303,0.000000,36.725472>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.939756,0.000000,35.575019>}
box{<0,0,-0.076200><1.626986,0.036000,0.076200> rotate<0,44.997030,0> translate<4.789303,0.000000,36.725472> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.939756,0.000000,35.575019>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.364528,0.000000,34.999791>}
box{<0,0,-0.076200><0.813495,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.364528,0.000000,34.999791> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.364528,0.000000,34.999791>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.981044,0.000000,34.999791>}
box{<0,0,-0.076200><0.383484,0.036000,0.076200> rotate<0,0.000000,0> translate<4.981044,0.000000,34.999791> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.981044,0.000000,34.999791>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.597559,0.000000,35.383275>}
box{<0,0,-0.076200><0.542329,0.036000,0.076200> rotate<0,44.997030,0> translate<4.597559,0.000000,35.383275> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.597559,0.000000,35.383275>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.597556,0.000000,35.766759>}
box{<0,0,-0.076200><0.383484,0.036000,0.076200> rotate<0,89.993593,0> translate<4.597556,0.000000,35.766759> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.597556,0.000000,35.766759>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.172788,0.000000,36.341988>}
box{<0,0,-0.076200><0.813498,0.036000,0.076200> rotate<0,-44.996875,0> translate<4.597556,0.000000,35.766759> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.179975,0.000000,37.116147>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.097400,0.000000,36.732663>}
box{<0,0,-0.076200><1.955397,0.036000,0.076200> rotate<0,11.309168,0> translate<5.179975,0.000000,37.116147> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.946947,0.000000,37.883116>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.330431,0.000000,35.965694>}
box{<0,0,-0.076200><1.955394,0.036000,0.076200> rotate<0,78.684874,0> translate<5.946947,0.000000,37.883116> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.679816,0.000000,37.315078>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.063300,0.000000,37.698563>}
box{<0,0,-0.076200><0.542329,0.036000,0.076200> rotate<0,-44.997030,0> translate<7.679816,0.000000,37.315078> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.063300,0.000000,37.698563>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.063303,0.000000,38.082047>}
box{<0,0,-0.076200><0.383484,0.036000,0.076200> rotate<0,-89.993593,0> translate<8.063300,0.000000,37.698563> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.063303,0.000000,38.082047>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.679816,0.000000,38.465534>}
box{<0,0,-0.076200><0.542333,0.036000,0.076200> rotate<0,44.997030,0> translate<7.679816,0.000000,38.465534> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.679816,0.000000,38.465534>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.296331,0.000000,38.465534>}
box{<0,0,-0.076200><0.383484,0.036000,0.076200> rotate<0,0.000000,0> translate<7.296331,0.000000,38.465534> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.296331,0.000000,38.465534>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.912844,0.000000,38.082047>}
box{<0,0,-0.076200><0.542333,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.912844,0.000000,38.082047> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.912844,0.000000,38.082047>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.912847,0.000000,37.698563>}
box{<0,0,-0.076200><0.383484,0.036000,0.076200> rotate<0,89.993593,0> translate<6.912844,0.000000,38.082047> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.912847,0.000000,37.698563>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.296331,0.000000,37.315078>}
box{<0,0,-0.076200><0.542329,0.036000,0.076200> rotate<0,44.997030,0> translate<6.912847,0.000000,37.698563> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.296331,0.000000,37.315078>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.679816,0.000000,37.315078>}
box{<0,0,-0.076200><0.383484,0.036000,0.076200> rotate<0,0.000000,0> translate<7.296331,0.000000,37.315078> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.645719,0.000000,38.280981>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.878747,0.000000,39.047950>}
box{<0,0,-0.076200><1.084660,0.036000,0.076200> rotate<0,44.996913,0> translate<7.878747,0.000000,39.047950> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.262234,0.000000,38.664462>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.262231,0.000000,39.431434>}
box{<0,0,-0.076200><0.766972,0.036000,0.076200> rotate<0,89.993827,0> translate<8.262231,0.000000,39.431434> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.262231,0.000000,39.431434>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.453975,0.000000,39.623178>}
box{<0,0,-0.076200><0.271167,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.262231,0.000000,39.431434> }
//1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.606000,-1.536000,26.695800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.606000,-1.536000,28.118200>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,90.000000,0> translate<7.606000,-1.536000,28.118200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.876000,-1.536000,26.695800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.876000,-1.536000,28.118200>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,90.000000,0> translate<8.876000,-1.536000,28.118200> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-270.000000,0> translate<8.241000,-1.536000,28.270600>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-270.000000,0> translate<8.241000,-1.536000,26.543400>}
//2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,15.163800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.655000,0.000000,16.586200>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,90.000000,0> translate<33.655000,0.000000,16.586200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,15.163800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,16.586200>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,90.000000,0> translate<32.385000,0.000000,16.586200> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-270.000000,0> translate<33.020000,0.000000,16.738600>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-270.000000,0> translate<33.020000,0.000000,15.011400>}
//3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.528800,-1.536000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.951200,-1.536000,4.445000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<14.528800,-1.536000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.528800,-1.536000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.951200,-1.536000,3.175000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<14.528800,-1.536000,3.175000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<16.103600,-1.536000,3.810000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<14.376400,-1.536000,3.810000>}
//4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,16.586200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,15.163800>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.845000,0.000000,15.163800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,16.586200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,15.163800>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.115000,0.000000,15.163800> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-90.000000,0> translate<30.480000,0.000000,15.011400>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-90.000000,0> translate<30.480000,0.000000,16.738600>}
//5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.541200,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.118800,0.000000,23.495000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<36.118800,0.000000,23.495000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.541200,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.118800,0.000000,22.225000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<36.118800,0.000000,22.225000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<35.966400,0.000000,22.860000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<37.693600,0.000000,22.860000>}
//6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.508000,-1.536000,31.844800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.508000,-1.536000,33.267200>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,90.000000,0> translate<30.508000,-1.536000,33.267200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.778000,-1.536000,31.844800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.778000,-1.536000,33.267200>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,90.000000,0> translate<31.778000,-1.536000,33.267200> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-270.000000,0> translate<31.143000,-1.536000,33.419600>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-270.000000,0> translate<31.143000,-1.536000,31.692400>}
//7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.773700,-1.536000,23.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.351300,-1.536000,23.175000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<7.351300,-1.536000,23.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.773700,-1.536000,24.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.351300,-1.536000,24.445000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<7.351300,-1.536000,24.445000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<7.198900,-1.536000,23.810000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<8.926100,-1.536000,23.810000>}
//8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.491200,-1.536000,38.015000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.068800,-1.536000,38.015000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<17.068800,-1.536000,38.015000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.491200,-1.536000,39.285000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.068800,-1.536000,39.285000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<17.068800,-1.536000,39.285000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<16.916400,-1.536000,38.650000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<18.643600,-1.536000,38.650000>}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.280000,-1.536000,32.766000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<27.280000,-1.536000,32.004000>}
box{<0,0,-0.050800><0.762000,0.036000,0.050800> rotate<0,-90.000000,0> translate<27.280000,-1.536000,32.004000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.600000,-1.536000,32.741000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<28.600000,-1.536000,32.004000>}
box{<0,0,-0.050800><0.737000,0.036000,0.050800> rotate<0,-90.000000,0> translate<28.600000,-1.536000,32.004000> }
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-270.000000,0> translate<27.938850,-1.536000,33.102150>}
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-270.000000,0> translate<27.938850,-1.536000,31.654350>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.479000,-1.536000,3.150000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.241000,-1.536000,3.150000>}
box{<0,0,-0.050800><0.762000,0.036000,0.050800> rotate<0,0.000000,0> translate<22.479000,-1.536000,3.150000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<22.504000,-1.536000,4.470000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<23.241000,-1.536000,4.470000>}
box{<0,0,-0.050800><0.737000,0.036000,0.050800> rotate<0,0.000000,0> translate<22.504000,-1.536000,4.470000> }
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-0.000000,0> translate<22.142850,-1.536000,3.808850>}
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-0.000000,0> translate<23.590650,-1.536000,3.808850>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.350000,-1.536000,5.590000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,5.590000>}
box{<0,0,-0.101600><5.700000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.350000,-1.536000,5.590000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,5.590000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,7.790000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.050000,-1.536000,7.790000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,7.790000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,9.990000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.050000,-1.536000,9.990000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,9.990000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,12.190000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,90.000000,0> translate<35.050000,-1.536000,12.190000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<35.050000,-1.536000,12.190000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.350000,-1.536000,12.190000>}
box{<0,0,-0.101600><5.700000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.350000,-1.536000,12.190000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,11.290000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,9.990000>}
box{<0,0,-0.101600><1.300000,0.036000,0.101600> rotate<0,-90.000000,0> translate<28.450000,-1.536000,9.990000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,9.990000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,7.790000>}
box{<0,0,-0.101600><2.200000,0.036000,0.101600> rotate<0,-90.000000,0> translate<28.450000,-1.536000,7.790000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,7.790000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,6.490000>}
box{<0,0,-0.101600><1.300000,0.036000,0.101600> rotate<0,-90.000000,0> translate<28.450000,-1.536000,6.490000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,6.490000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.350000,-1.536000,5.590000>}
box{<0,0,-0.101600><1.272792,0.036000,0.101600> rotate<0,44.997030,0> translate<28.450000,-1.536000,6.490000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.350000,-1.536000,12.190000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.450000,-1.536000,11.290000>}
box{<0,0,-0.101600><1.272792,0.036000,0.101600> rotate<0,-44.997030,0> translate<28.450000,-1.536000,11.290000> }
object{ARC(3.091731,0.203200,197.894848,343.076243,0.036000) translate<31.742163,-1.536000,8.890000>}
object{ARC(3.091622,0.203200,342.590698,377.409302,0.036000) translate<31.750000,-1.536000,8.915000>}
object{ARC(3.091731,0.203200,17.894848,163.076243,0.036000) translate<31.757838,-1.536000,8.890000>}
object{ARC(3.091622,0.203200,162.590698,197.409302,0.036000) translate<31.750000,-1.536000,8.865000>}
//C5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.360000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<32.360000,0.000000,20.701000>}
box{<0,0,-0.050800><0.762000,0.036000,0.050800> rotate<0,90.000000,0> translate<32.360000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.680000,0.000000,19.964000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<33.680000,0.000000,20.701000>}
box{<0,0,-0.050800><0.737000,0.036000,0.050800> rotate<0,90.000000,0> translate<33.680000,0.000000,20.701000> }
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-90.000000,0> translate<33.018850,0.000000,19.602850>}
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-90.000000,0> translate<33.018850,0.000000,21.050650>}
//C6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.820000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<29.820000,0.000000,20.701000>}
box{<0,0,-0.050800><0.762000,0.036000,0.050800> rotate<0,90.000000,0> translate<29.820000,0.000000,20.701000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.140000,0.000000,19.964000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<31.140000,0.000000,20.701000>}
box{<0,0,-0.050800><0.737000,0.036000,0.050800> rotate<0,90.000000,0> translate<31.140000,0.000000,20.701000> }
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-90.000000,0> translate<30.478850,0.000000,19.602850>}
box{<-0.375050,0,-0.725050><0.375050,0.036000,0.725050> rotate<0,-90.000000,0> translate<30.478850,0.000000,21.050650>}
//F1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,21.971000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,21.971000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<7.620000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<7.620000,0.000000,30.099000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<7.620000,0.000000,30.099000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.890000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,27.559000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.636000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,27.559000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,27.559000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<6.350000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,24.511000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,44.997030,0> translate<8.636000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.636000,0.000000,27.305000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.636000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,24.511000>}
box{<0,0,-0.076200><0.359210,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.350000,0.000000,24.511000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,27.305000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.604000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,24.511000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,24.511000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,24.511000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,24.511000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<8.636000,0.000000,27.559000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<6.604000,0.000000,27.559000>}
box{<0,0,-0.025400><2.032000,0.036000,0.025400> rotate<0,0.000000,0> translate<6.604000,0.000000,27.559000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<8.636000,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<6.604000,0.000000,28.829000>}
box{<0,0,-0.025400><2.032000,0.036000,0.025400> rotate<0,0.000000,0> translate<6.604000,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<8.636000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<6.604000,0.000000,23.241000>}
box{<0,0,-0.025400><2.032000,0.036000,0.025400> rotate<0,0.000000,0> translate<6.604000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<8.636000,0.000000,24.511000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<6.604000,0.000000,24.511000>}
box{<0,0,-0.025400><2.032000,0.036000,0.025400> rotate<0,0.000000,0> translate<6.604000,0.000000,24.511000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,22.225000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.112000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,22.479000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.112000,0.000000,22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,22.479000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,44.997030,0> translate<6.350000,0.000000,23.241000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.479000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.128000,0.000000,22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.241000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,22.479000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.128000,0.000000,22.479000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,28.829000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,29.591000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,44.997030,0> translate<8.128000,0.000000,29.591000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,29.845000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.128000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,29.845000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.112000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,29.591000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.112000,0.000000,29.591000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,28.829000>}
box{<0,0,-0.076200><1.077631,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.350000,0.000000,28.829000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<7.620000,0.000000,24.765000>}
box{<0,0,-0.025400><2.540000,0.036000,0.025400> rotate<0,-90.000000,0> translate<7.620000,0.000000,24.765000> }
box{<-0.177800,0,-0.304800><0.177800,0.036000,0.304800> rotate<0,-270.000000,0> translate<7.620000,0.000000,22.047200>}
box{<-0.177800,0,-0.304800><0.177800,0.036000,0.304800> rotate<0,-270.000000,0> translate<7.620000,0.000000,30.022800>}
//GPIO silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.514241,0.000000,5.260116>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<37.756881,0.000000,9.502756>}
box{<0,0,-0.063500><6.000000,0.036000,0.063500> rotate<0,-44.997030,0> translate<33.514241,0.000000,5.260116> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<37.756881,0.000000,9.502756>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.640766,0.000000,8.618872>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,44.997030,0> translate<37.756881,0.000000,9.502756> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.640766,0.000000,8.618872>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.347872,0.000000,7.911766>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,44.997030,0> translate<38.640766,0.000000,8.618872> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.347872,0.000000,7.911766>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.231756,0.000000,7.027881>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,44.997030,0> translate<39.347872,0.000000,7.911766> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.231756,0.000000,7.027881>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.989116,0.000000,2.785241>}
box{<0,0,-0.063500><6.000000,0.036000,0.063500> rotate<0,-44.997030,0> translate<35.989116,0.000000,2.785241> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.989116,0.000000,2.785241>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.105231,0.000000,3.669125>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,44.997030,0> translate<35.105231,0.000000,3.669125> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.105231,0.000000,3.669125>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.398125,0.000000,4.376231>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,44.997030,0> translate<34.398125,0.000000,4.376231> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.398125,0.000000,4.376231>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.514241,0.000000,5.260116>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,44.997030,0> translate<33.514241,0.000000,5.260116> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.019625,0.000000,8.583516>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.312516,0.000000,9.290625>}
box{<0,0,-0.063500><1.000004,0.036000,0.063500> rotate<0,44.997030,0> translate<39.312516,0.000000,9.290625> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.312516,0.000000,9.290625>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.640766,0.000000,8.618872>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,-44.997163,0> translate<38.640766,0.000000,8.618872> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.640766,0.000000,8.618872>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.347872,0.000000,7.911766>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,44.997030,0> translate<38.640766,0.000000,8.618872> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.347872,0.000000,7.911766>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.019625,0.000000,8.583516>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,-44.996897,0> translate<39.347872,0.000000,7.911766> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<39.312516,0.000000,9.290625>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.640766,0.000000,8.618872>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,-44.997163,0> translate<38.640766,0.000000,8.618872> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.079928,0.000000,3.350928>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.726372,0.000000,3.704481>}
box{<0,0,-0.063500><0.500002,0.036000,0.063500> rotate<0,44.996777,0> translate<33.726372,0.000000,3.704481> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.726372,0.000000,3.704481>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.398125,0.000000,4.376231>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,-44.996897,0> translate<33.726372,0.000000,3.704481> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.398125,0.000000,4.376231>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.105231,0.000000,3.669125>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,44.997030,0> translate<34.398125,0.000000,4.376231> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.105231,0.000000,3.669125>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.433481,0.000000,2.997372>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,-44.997163,0> translate<34.433481,0.000000,2.997372> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.433481,0.000000,2.997372>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<34.079928,0.000000,3.350928>}
box{<0,0,-0.063500><0.500002,0.036000,0.063500> rotate<0,44.997283,0> translate<34.079928,0.000000,3.350928> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.317363,0.000000,5.578313>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<37.438684,0.000000,7.699634>}
box{<0,0,-0.063500><3.000002,0.036000,0.063500> rotate<0,-44.997030,0> translate<35.317363,0.000000,5.578313> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<37.438684,0.000000,7.699634>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.428634,0.000000,6.709684>}
box{<0,0,-0.063500><1.400001,0.036000,0.063500> rotate<0,44.997030,0> translate<37.438684,0.000000,7.699634> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.428634,0.000000,6.709684>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<36.307313,0.000000,4.588363>}
box{<0,0,-0.063500><3.000002,0.036000,0.063500> rotate<0,-44.997030,0> translate<36.307313,0.000000,4.588363> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<36.307313,0.000000,4.588363>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.317363,0.000000,5.578313>}
box{<0,0,-0.063500><1.400001,0.036000,0.063500> rotate<0,44.997030,0> translate<35.317363,0.000000,5.578313> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.620306,0.000000,5.012628>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.337466,0.000000,5.295469>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,44.997030,0> translate<33.337466,0.000000,5.295469> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<33.337466,0.000000,5.295469>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<37.721528,0.000000,9.679531>}
box{<0,0,-0.063500><6.200001,0.036000,0.063500> rotate<0,-44.997030,0> translate<33.337466,0.000000,5.295469> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<37.721528,0.000000,9.679531>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<38.004369,0.000000,9.396691>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,44.997030,0> translate<37.721528,0.000000,9.679531> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<35.741628,0.000000,2.891306>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<36.024469,0.000000,2.608466>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,44.997030,0> translate<35.741628,0.000000,2.891306> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<36.024469,0.000000,2.608466>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.408531,0.000000,6.992528>}
box{<0,0,-0.063500><6.200001,0.036000,0.063500> rotate<0,-44.997030,0> translate<36.024469,0.000000,2.608466> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.408531,0.000000,6.992528>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<40.125691,0.000000,7.275369>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,44.997030,0> translate<40.125691,0.000000,7.275369> }
//HKLP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.150000,0.000000,35.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.150000,0.000000,1.415000>}
box{<0,0,-0.063500><34.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.150000,0.000000,1.415000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.150000,0.000000,1.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.950000,0.000000,1.415000>}
box{<0,0,-0.063500><20.200000,0.036000,0.063500> rotate<0,0.000000,0> translate<8.950000,0.000000,1.415000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.950000,0.000000,1.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.950000,0.000000,35.415000>}
box{<0,0,-0.063500><34.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<8.950000,0.000000,35.415000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.950000,0.000000,35.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.150000,0.000000,35.415000>}
box{<0,0,-0.063500><20.200000,0.036000,0.063500> rotate<0,0.000000,0> translate<8.950000,0.000000,35.415000> }
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.676600,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.676600,0.000000,38.354000>}
box{<0,0,-0.101600><3.302000,0.036000,0.101600> rotate<0,-90.000000,0> translate<28.676600,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.676600,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.123400,0.000000,38.354000>}
box{<0,0,-0.101600><6.553200,0.036000,0.101600> rotate<0,0.000000,0> translate<22.123400,0.000000,38.354000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.123400,0.000000,38.354000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.123400,0.000000,41.656000>}
box{<0,0,-0.101600><3.302000,0.036000,0.101600> rotate<0,90.000000,0> translate<22.123400,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<22.123400,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<28.676600,0.000000,41.656000>}
box{<0,0,-0.101600><6.553200,0.036000,0.101600> rotate<0,0.000000,0> translate<22.123400,0.000000,41.656000> }
box{<-1.600200,0,-0.927100><1.600200,0.036000,0.927100> rotate<0,-0.000000,0> translate<25.400000,0.000000,42.735500>}
box{<-0.431800,0,-0.927100><0.431800,0.036000,0.927100> rotate<0,-0.000000,0> translate<25.400000,0.000000,37.274500>}
box{<-0.431800,0,-0.927100><0.431800,0.036000,0.927100> rotate<0,-0.000000,0> translate<23.088600,0.000000,37.274500>}
box{<-0.431800,0,-0.927100><0.431800,0.036000,0.927100> rotate<0,-0.000000,0> translate<27.711400,0.000000,37.274500>}
box{<-1.600200,0,-0.927100><1.600200,0.036000,0.927100> rotate<0,-0.000000,0> translate<25.400000,0.000000,42.735500>}
box{<-0.431800,0,-0.927100><0.431800,0.036000,0.927100> rotate<0,-0.000000,0> translate<25.400000,0.000000,37.274500>}
box{<-0.431800,0,-0.927100><0.431800,0.036000,0.927100> rotate<0,-0.000000,0> translate<23.088600,0.000000,37.274500>}
box{<-0.431800,0,-0.927100><0.431800,0.036000,0.927100> rotate<0,-0.000000,0> translate<27.711400,0.000000,37.274500>}
//LED1 silk screen
object{ARC(0.350000,0.101600,90.000000,270.000000,0.036000) translate<37.830000,0.000000,25.400000>}
object{ARC(0.350000,0.101600,270.000000,450.000000,0.036000) translate<35.830000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.355000,0.000000,24.825000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.305000,0.000000,24.825000>}
box{<0,0,-0.050800><1.050000,0.036000,0.050800> rotate<0,0.000000,0> translate<36.305000,0.000000,24.825000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<36.330000,0.000000,25.975000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<37.755000,0.000000,25.975000>}
box{<0,0,-0.050800><1.425000,0.036000,0.050800> rotate<0,0.000000,0> translate<36.330000,0.000000,25.975000> }
difference{
cylinder{<37.680000,0,25.850000><37.680000,0.036000,25.850000>0.153800 translate<0,0.000000,0>}
cylinder{<37.680000,-0.1,25.850000><37.680000,0.135000,25.850000>0.052200 translate<0,0.000000,0>}}
box{<-0.162500,0,-0.250000><0.162500,0.036000,0.250000> rotate<0,-270.000000,0> translate<37.580000,0.000000,24.937500>}
box{<-0.075000,0,-0.125000><0.075000,0.036000,0.125000> rotate<0,-270.000000,0> translate<37.455000,0.000000,25.650000>}
box{<-0.075000,0,-0.125000><0.075000,0.036000,0.125000> rotate<0,-270.000000,0> translate<37.455000,0.000000,25.150000>}
box{<-0.200000,0,-0.087500><0.200000,0.036000,0.087500> rotate<0,-270.000000,0> translate<37.417500,0.000000,25.400000>}
box{<-0.162500,0,-0.250000><0.162500,0.036000,0.250000> rotate<0,-270.000000,0> translate<36.080000,0.000000,24.937500>}
box{<-0.162500,0,-0.250000><0.162500,0.036000,0.250000> rotate<0,-270.000000,0> translate<36.080000,0.000000,25.862500>}
box{<-0.075000,0,-0.125000><0.075000,0.036000,0.125000> rotate<0,-270.000000,0> translate<36.205000,0.000000,25.150000>}
box{<-0.075000,0,-0.125000><0.075000,0.036000,0.125000> rotate<0,-270.000000,0> translate<36.205000,0.000000,25.650000>}
box{<-0.200000,0,-0.087500><0.200000,0.036000,0.087500> rotate<0,-270.000000,0> translate<36.242500,0.000000,25.400000>}
box{<-0.100000,0,-0.100000><0.100000,0.036000,0.100000> rotate<0,-270.000000,0> translate<36.930000,0.000000,25.400000>}
box{<-0.150000,0,-0.150000><0.150000,0.036000,0.150000> rotate<0,-270.000000,0> translate<37.480000,0.000000,25.850000>}
box{<-0.112500,0,-0.037500><0.112500,0.036000,0.037500> rotate<0,-270.000000,0> translate<37.792500,0.000000,25.912500>}
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.627600,-1.536000,32.410400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.627600,-1.536000,31.089600>}
box{<0,0,-0.063500><1.320800,0.036000,0.063500> rotate<0,-90.000000,0> translate<17.627600,-1.536000,31.089600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.627600,-1.536000,31.089600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.472400,-1.536000,31.089600>}
box{<0,0,-0.063500><2.844800,0.036000,0.063500> rotate<0,0.000000,0> translate<17.627600,-1.536000,31.089600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.472400,-1.536000,31.089600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.472400,-1.536000,32.410400>}
box{<0,0,-0.063500><1.320800,0.036000,0.063500> rotate<0,90.000000,0> translate<20.472400,-1.536000,32.410400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<20.472400,-1.536000,32.410400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<17.627600,-1.536000,32.410400>}
box{<0,0,-0.063500><2.844800,0.036000,0.063500> rotate<0,0.000000,0> translate<17.627600,-1.536000,32.410400> }
box{<-0.228600,0,-0.292100><0.228600,0.036000,0.292100> rotate<0,-180.000000,0> translate<19.050000,-1.536000,32.753300>}
box{<-0.228600,0,-0.292100><0.228600,0.036000,0.292100> rotate<0,-180.000000,0> translate<18.110200,-1.536000,30.746700>}
box{<-0.228600,0,-0.292100><0.228600,0.036000,0.292100> rotate<0,-180.000000,0> translate<19.989800,-1.536000,30.746700>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.286000,0.000000,29.718000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.334000,0.000000,29.718000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.286000,0.000000,29.718000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,23.368000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.270000,0.000000,23.368000>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<1.270000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.286000,0.000000,22.352000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.334000,0.000000,22.352000>}
box{<0,0,-0.076200><3.048000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.286000,0.000000,22.352000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<2.159000,0.000000,24.892000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<2.159000,0.000000,28.067000>}
box{<0,0,-0.025400><3.175000,0.036000,0.025400> rotate<0,90.000000,0> translate<2.159000,0.000000,28.067000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.461000,0.000000,24.003000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.461000,0.000000,27.178000>}
box{<0,0,-0.025400><3.175000,0.036000,0.025400> rotate<0,90.000000,0> translate<5.461000,0.000000,27.178000> }
object{ARC(1.016000,0.152400,270.000000,360.000000,0.036000) translate<5.334000,0.000000,23.368000>}
object{ARC(1.016000,0.152400,90.000000,180.000000,0.036000) translate<2.286000,0.000000,28.702000>}
object{ARC(1.016000,0.152400,180.000000,270.000000,0.036000) translate<2.286000,0.000000,23.368000>}
object{ARC(1.016000,0.152400,0.000000,90.000000,0.036000) translate<5.334000,0.000000,28.702000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.207000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<5.207000,0.000000,27.178000>}
box{<0,0,-0.025400><1.143000,0.036000,0.025400> rotate<0,90.000000,0> translate<5.207000,0.000000,27.178000> }
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<2.413000,0.000000,24.892000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<2.413000,0.000000,26.035000>}
box{<0,0,-0.025400><1.143000,0.036000,0.025400> rotate<0,90.000000,0> translate<2.413000,0.000000,26.035000> }
//RESET silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.800116,0.000000,9.261756>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.042756,0.000000,5.019116>}
box{<0,0,-0.063500><6.000000,0.036000,0.063500> rotate<0,44.997030,0> translate<4.800116,0.000000,9.261756> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.042756,0.000000,5.019116>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.158872,0.000000,4.135231>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,-44.997030,0> translate<8.158872,0.000000,4.135231> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.158872,0.000000,4.135231>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.451766,0.000000,3.428125>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,-44.997030,0> translate<7.451766,0.000000,3.428125> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.451766,0.000000,3.428125>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.567881,0.000000,2.544241>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,-44.997030,0> translate<6.567881,0.000000,2.544241> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.567881,0.000000,2.544241>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.325241,0.000000,6.786881>}
box{<0,0,-0.063500><6.000000,0.036000,0.063500> rotate<0,44.997030,0> translate<2.325241,0.000000,6.786881> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.325241,0.000000,6.786881>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.209125,0.000000,7.670766>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,-44.997030,0> translate<2.325241,0.000000,6.786881> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.209125,0.000000,7.670766>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.916231,0.000000,8.377872>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,-44.997030,0> translate<3.209125,0.000000,7.670766> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.916231,0.000000,8.377872>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.800116,0.000000,9.261756>}
box{<0,0,-0.063500><1.250001,0.036000,0.063500> rotate<0,-44.997030,0> translate<3.916231,0.000000,8.377872> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.123516,0.000000,2.756372>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.830625,0.000000,3.463481>}
box{<0,0,-0.063500><1.000004,0.036000,0.063500> rotate<0,-44.997030,0> translate<8.123516,0.000000,2.756372> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.830625,0.000000,3.463481>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.158872,0.000000,4.135231>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,44.996897,0> translate<8.158872,0.000000,4.135231> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.158872,0.000000,4.135231>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.451766,0.000000,3.428125>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,-44.997030,0> translate<7.451766,0.000000,3.428125> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.451766,0.000000,3.428125>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.123516,0.000000,2.756372>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,44.997163,0> translate<7.451766,0.000000,3.428125> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.830625,0.000000,3.463481>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.158872,0.000000,4.135231>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,44.996897,0> translate<8.158872,0.000000,4.135231> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.890928,0.000000,8.696069>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.244481,0.000000,9.049625>}
box{<0,0,-0.063500><0.500002,0.036000,0.063500> rotate<0,-44.997283,0> translate<2.890928,0.000000,8.696069> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.244481,0.000000,9.049625>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.916231,0.000000,8.377872>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,44.997163,0> translate<3.244481,0.000000,9.049625> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.916231,0.000000,8.377872>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.209125,0.000000,7.670766>}
box{<0,0,-0.063500><0.999999,0.036000,0.063500> rotate<0,-44.997030,0> translate<3.209125,0.000000,7.670766> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<3.209125,0.000000,7.670766>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.537372,0.000000,8.342516>}
box{<0,0,-0.063500><0.950000,0.036000,0.063500> rotate<0,44.996897,0> translate<2.537372,0.000000,8.342516> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.537372,0.000000,8.342516>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.890928,0.000000,8.696069>}
box{<0,0,-0.063500><0.500002,0.036000,0.063500> rotate<0,-44.996777,0> translate<2.537372,0.000000,8.342516> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.118313,0.000000,7.458634>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.239634,0.000000,5.337313>}
box{<0,0,-0.063500><3.000002,0.036000,0.063500> rotate<0,44.997030,0> translate<5.118313,0.000000,7.458634> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.239634,0.000000,5.337313>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.249684,0.000000,4.347363>}
box{<0,0,-0.063500><1.400001,0.036000,0.063500> rotate<0,-44.997030,0> translate<6.249684,0.000000,4.347363> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.249684,0.000000,4.347363>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.128363,0.000000,6.468684>}
box{<0,0,-0.063500><3.000002,0.036000,0.063500> rotate<0,44.997030,0> translate<4.128363,0.000000,6.468684> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.128363,0.000000,6.468684>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.118313,0.000000,7.458634>}
box{<0,0,-0.063500><1.400001,0.036000,0.063500> rotate<0,-44.997030,0> translate<4.128363,0.000000,6.468684> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.552628,0.000000,9.155691>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.835469,0.000000,9.438531>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,-44.997030,0> translate<4.552628,0.000000,9.155691> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<4.835469,0.000000,9.438531>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.219531,0.000000,5.054469>}
box{<0,0,-0.063500><6.200001,0.036000,0.063500> rotate<0,44.997030,0> translate<4.835469,0.000000,9.438531> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.219531,0.000000,5.054469>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<8.936691,0.000000,4.771628>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,-44.997030,0> translate<8.936691,0.000000,4.771628> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.431306,0.000000,7.034369>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.148466,0.000000,6.751528>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,-44.997030,0> translate<2.148466,0.000000,6.751528> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<2.148466,0.000000,6.751528>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.532528,0.000000,2.367466>}
box{<0,0,-0.063500><6.200001,0.036000,0.063500> rotate<0,44.997030,0> translate<2.148466,0.000000,6.751528> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.532528,0.000000,2.367466>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.815369,0.000000,2.650306>}
box{<0,0,-0.063500><0.399997,0.036000,0.063500> rotate<0,-44.997030,0> translate<6.532528,0.000000,2.367466> }
//U$1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.609800,0.000000,39.412800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.570200,0.000000,39.412800>}
box{<0,0,-0.063500><12.039600,0.036000,0.063500> rotate<0,0.000000,0> translate<9.570200,0.000000,39.412800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.570200,0.000000,39.412800>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.570200,0.000000,45.483400>}
box{<0,0,-0.063500><6.070600,0.036000,0.063500> rotate<0,90.000000,0> translate<9.570200,0.000000,45.483400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.570200,0.000000,45.483400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.609800,0.000000,45.483400>}
box{<0,0,-0.063500><12.039600,0.036000,0.063500> rotate<0,0.000000,0> translate<9.570200,0.000000,45.483400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.609800,0.000000,45.483400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<21.609800,0.000000,39.412800>}
box{<0,0,-0.063500><6.070600,0.036000,0.063500> rotate<0,-90.000000,0> translate<21.609800,0.000000,39.412800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.666200,0.000000,45.458000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.666200,0.000000,44.924600>}
box{<0,0,-0.063500><0.533400,0.036000,0.063500> rotate<0,-90.000000,0> translate<15.666200,0.000000,44.924600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.666200,0.000000,44.924600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.513800,0.000000,44.924600>}
box{<0,0,-0.063500><0.152400,0.036000,0.063500> rotate<0,0.000000,0> translate<15.513800,0.000000,44.924600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.513800,0.000000,44.924600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<15.513800,0.000000,45.381800>}
box{<0,0,-0.063500><0.457200,0.036000,0.063500> rotate<0,90.000000,0> translate<15.513800,0.000000,45.381800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.126200,0.000000,45.458000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.126200,0.000000,44.924600>}
box{<0,0,-0.063500><0.533400,0.036000,0.063500> rotate<0,-90.000000,0> translate<13.126200,0.000000,44.924600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.126200,0.000000,44.924600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.973800,0.000000,44.924600>}
box{<0,0,-0.063500><0.152400,0.036000,0.063500> rotate<0,0.000000,0> translate<12.973800,0.000000,44.924600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.973800,0.000000,44.924600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.973800,0.000000,45.381800>}
box{<0,0,-0.063500><0.457200,0.036000,0.063500> rotate<0,90.000000,0> translate<12.973800,0.000000,45.381800> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.206200,0.000000,45.458000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.206200,0.000000,44.924600>}
box{<0,0,-0.063500><0.533400,0.036000,0.063500> rotate<0,-90.000000,0> translate<18.206200,0.000000,44.924600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.206200,0.000000,44.924600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.053800,0.000000,44.924600>}
box{<0,0,-0.063500><0.152400,0.036000,0.063500> rotate<0,0.000000,0> translate<18.053800,0.000000,44.924600> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.053800,0.000000,44.924600>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<18.053800,0.000000,45.381800>}
box{<0,0,-0.063500><0.457200,0.036000,0.063500> rotate<0,90.000000,0> translate<18.053800,0.000000,45.381800> }
//U1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.170000,0.000000,45.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.170000,0.000000,22.545000>}
box{<0,0,-0.101600><23.000000,0.036000,0.101600> rotate<0,-90.000000,0> translate<33.170000,0.000000,22.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.170000,0.000000,22.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,22.545000>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.170000,0.000000,22.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,22.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.170000,0.000000,22.545000>}
box{<0,0,-0.101600><1.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.170000,0.000000,22.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.170000,0.000000,22.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.170000,0.000000,45.545000>}
box{<0,0,-0.101600><23.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<29.170000,0.000000,45.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<29.170000,0.000000,45.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,45.545000>}
box{<0,0,-0.101600><1.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<29.170000,0.000000,45.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,45.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.170000,0.000000,45.545000>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<30.170000,0.000000,45.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<30.170000,0.000000,45.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<30.170000,0.000000,22.545000>}
box{<0,0,-0.063500><23.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<30.170000,0.000000,22.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,44.245000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,45.545000>}
box{<0,0,-0.101600><1.300000,0.036000,0.101600> rotate<0,90.000000,0> translate<30.170000,0.000000,45.545000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,41.645000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,39.145000>}
box{<0,0,-0.101600><2.500000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.170000,0.000000,39.145000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,36.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,28.945000>}
box{<0,0,-0.101600><7.600000,0.036000,0.101600> rotate<0,-90.000000,0> translate<30.170000,0.000000,28.945000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,22.545000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<30.170000,0.000000,23.845000>}
box{<0,0,-0.101600><1.300000,0.036000,0.101600> rotate<0,90.000000,0> translate<30.170000,0.000000,23.845000> }
//USB silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.732963,-1.536000,38.131909>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.630987,-1.536000,39.029934>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.732963,-1.536000,38.131909> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.630987,-1.536000,39.029934>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.630987,-1.536000,39.927959>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,90.000000,0> translate<4.630987,-1.536000,39.927959> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.630987,-1.536000,39.927959>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.732963,-1.536000,40.825984>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,44.997030,0> translate<3.732963,-1.536000,40.825984> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.732963,-1.536000,40.825984>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.834938,-1.536000,40.825984>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,0.000000,0> translate<2.834938,-1.536000,40.825984> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.630987,-1.536000,39.927959>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.529016,-1.536000,39.927959>}
box{<0,0,-0.076200><0.898028,0.036000,0.076200> rotate<0,0.000000,0> translate<4.630987,-1.536000,39.927959> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.529016,-1.536000,39.927959>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.427041,-1.536000,40.825984>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.529016,-1.536000,39.927959> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.427041,-1.536000,40.825984>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.427041,-1.536000,41.724013>}
box{<0,0,-0.076200><0.898028,0.036000,0.076200> rotate<0,90.000000,0> translate<6.427041,-1.536000,41.724013> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.427041,-1.536000,41.724013>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.529016,-1.536000,42.622038>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,44.997030,0> translate<5.529016,-1.536000,42.622038> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.529016,-1.536000,42.622038>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.630987,-1.536000,42.622038>}
box{<0,0,-0.076200><0.898028,0.036000,0.076200> rotate<0,0.000000,0> translate<4.630987,-1.536000,42.622038> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.630987,-1.536000,42.622038>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.732963,-1.536000,41.724013>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.732963,-1.536000,41.724013> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.732963,-1.536000,41.724013>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.732963,-1.536000,40.825984>}
box{<0,0,-0.076200><0.898028,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.732963,-1.536000,40.825984> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.834938,-1.536000,38.131909>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.936913,-1.536000,39.029934>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,44.997030,0> translate<1.936913,-1.536000,39.029934> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.732963,-1.536000,38.131909>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.834938,-1.536000,38.131909>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,0.000000,0> translate<2.834938,-1.536000,38.131909> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.936913,-1.536000,39.029934>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.936913,-1.536000,39.927959>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,90.000000,0> translate<1.936913,-1.536000,39.927959> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.834938,-1.536000,40.825984>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.936913,-1.536000,39.927959>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,-44.997030,0> translate<1.936913,-1.536000,39.927959> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.427041,-1.536000,41.724013>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.325066,-1.536000,41.724013>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,0.000000,0> translate<6.427041,-1.536000,41.724013> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.325066,-1.536000,41.724013>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.223091,-1.536000,42.622038>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,-44.997030,0> translate<7.325066,-1.536000,41.724013> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.223091,-1.536000,42.622038>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.223091,-1.536000,43.520063>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,90.000000,0> translate<8.223091,-1.536000,43.520063> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.223091,-1.536000,43.520063>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.325066,-1.536000,44.418087>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,44.997030,0> translate<7.325066,-1.536000,44.418087> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.325066,-1.536000,44.418087>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.427041,-1.536000,44.418087>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,0.000000,0> translate<6.427041,-1.536000,44.418087> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.427041,-1.536000,44.418087>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.529016,-1.536000,43.520063>}
box{<0,0,-0.076200><1.269999,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.529016,-1.536000,43.520063> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.529016,-1.536000,43.520063>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.529016,-1.536000,42.622038>}
box{<0,0,-0.076200><0.898025,0.036000,0.076200> rotate<0,-90.000000,0> translate<5.529016,-1.536000,42.622038> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-45.000000,0> translate<5.080000,-1.536000,41.275000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-45.000000,0> translate<3.283950,-1.536000,39.478947>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-45.000000,0> translate<6.876053,-1.536000,43.071050>}
//X2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.524000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.921000,-1.536000,9.525000>}
box{<0,0,-0.076200><1.397000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.524000,-1.536000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,-1.536000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,-1.536000,9.525000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.017000,-1.536000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,-1.536000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.239000,-1.536000,19.685000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.239000,-1.536000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.524000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.524000,-1.536000,19.685000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<1.524000,-1.536000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,-1.536000,9.017000>}
box{<0,0,-0.076200><0.523634,0.036000,0.076200> rotate<0,75.958743,0> translate<8.128000,-1.536000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.017000,-1.536000,9.525000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.128000,-1.536000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.255000,-1.536000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,-1.536000,9.017000>}
box{<0,0,-0.076200><1.143000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.112000,-1.536000,9.017000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.112000,-1.536000,9.017000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.239000,-1.536000,9.525000>}
box{<0,0,-0.076200><0.523634,0.036000,0.076200> rotate<0,-75.958743,0> translate<7.112000,-1.536000,9.017000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.239000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.128000,-1.536000,9.525000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.239000,-1.536000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.239000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.239000,-1.536000,19.685000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.239000,-1.536000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.239000,-1.536000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.921000,-1.536000,19.685000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.921000,-1.536000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.921000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.921000,-1.536000,19.685000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<2.921000,-1.536000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.921000,-1.536000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.239000,-1.536000,9.525000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<2.921000,-1.536000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<2.921000,-1.536000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<1.524000,-1.536000,19.685000>}
box{<0,0,-0.076200><1.397000,0.036000,0.076200> rotate<0,0.000000,0> translate<1.524000,-1.536000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,-1.536000,16.103600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,-1.536000,18.516600>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.683000,-1.536000,16.103600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,-1.536000,15.722600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,-1.536000,18.135600>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.064000,-1.536000,15.722600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,-1.536000,10.693400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,-1.536000,13.106400>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,-44.997030,0> translate<4.064000,-1.536000,10.693400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,-1.536000,11.074400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,-1.536000,13.487400>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.683000,-1.536000,11.074400> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<4.064000,-1.536000,16.103600>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<6.096000,-1.536000,18.135600>}
box{<0,0,-0.304800><2.873682,0.036000,0.304800> rotate<0,-44.997030,0> translate<4.064000,-1.536000,16.103600> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<4.064000,-1.536000,11.074400>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<6.096000,-1.536000,13.106400>}
box{<0,0,-0.304800><2.873682,0.036000,0.304800> rotate<0,-44.997030,0> translate<4.064000,-1.536000,11.074400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,-1.536000,15.722600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,-1.536000,16.103600>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,44.997030,0> translate<3.683000,-1.536000,16.103600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,-1.536000,18.135600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,-1.536000,18.516600>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,44.997030,0> translate<6.096000,-1.536000,18.516600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<4.064000,-1.536000,10.693400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.683000,-1.536000,11.074400>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,44.997030,0> translate<3.683000,-1.536000,11.074400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.477000,-1.536000,13.106400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,-1.536000,13.487400>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,44.997030,0> translate<6.096000,-1.536000,13.487400> }
difference{
cylinder{<8.128000,0,17.119600><8.128000,0.036000,17.119600>0.584200 translate<0,-1.536000,0>}
cylinder{<8.128000,-0.1,17.119600><8.128000,0.135000,17.119600>0.431800 translate<0,-1.536000,0>}}
difference{
cylinder{<8.128000,0,12.090400><8.128000,0.036000,12.090400>0.584200 translate<0,-1.536000,0>}
cylinder{<8.128000,-0.1,12.090400><8.128000,0.135000,12.090400>0.431800 translate<0,-1.536000,0>}}
difference{
cylinder{<5.080000,0,17.119600><5.080000,0.036000,17.119600>1.854200 translate<0,-1.536000,0>}
cylinder{<5.080000,-0.1,17.119600><5.080000,0.135000,17.119600>1.701800 translate<0,-1.536000,0>}}
difference{
cylinder{<5.080000,0,12.090400><5.080000,0.036000,12.090400>1.854200 translate<0,-1.536000,0>}
cylinder{<5.080000,-0.1,12.090400><5.080000,0.135000,12.090400>1.701800 translate<0,-1.536000,0>}}
box{<-0.381000,0,-1.905000><0.381000,0.036000,1.905000> rotate<0,-90.000000,0> translate<5.080000,-1.536000,14.605000>}
//X3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,10.795000>}
box{<0,0,-0.076200><1.397000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.259000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,10.795000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.163000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,20.955000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.163000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,20.955000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.656000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,10.287000>}
box{<0,0,-0.076200><0.523634,0.036000,0.076200> rotate<0,-75.958743,0> translate<34.925000,0.000000,10.287000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,10.795000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.163000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,10.287000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,10.287000>}
box{<0,0,-0.076200><1.143000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,10.287000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,10.287000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,10.795000>}
box{<0,0,-0.076200><0.523634,0.036000,0.076200> rotate<0,75.958743,0> translate<35.941000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,10.795000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.052000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,20.955000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.941000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,20.955000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.941000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,20.955000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.259000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,10.795000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.941000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,20.955000>}
box{<0,0,-0.076200><1.397000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.259000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,17.373600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,19.786600>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<37.084000,0.000000,19.786600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,16.992600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,19.405600>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<36.703000,0.000000,19.405600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,11.963400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,14.376400>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<36.703000,0.000000,14.376400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,14.757400>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<37.084000,0.000000,14.757400> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.116000,0.000000,17.373600>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.084000,0.000000,19.405600>}
box{<0,0,-0.304800><2.873682,0.036000,0.304800> rotate<0,44.997030,0> translate<37.084000,0.000000,19.405600> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.116000,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.084000,0.000000,14.376400>}
box{<0,0,-0.304800><2.873682,0.036000,0.304800> rotate<0,44.997030,0> translate<37.084000,0.000000,14.376400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,16.992600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,17.373600>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.116000,0.000000,16.992600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,19.405600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,19.786600>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.703000,0.000000,19.405600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,11.963400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,12.344400>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.116000,0.000000,11.963400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,14.376400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,14.757400>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.703000,0.000000,14.376400> }
difference{
cylinder{<35.052000,0,18.389600><35.052000,0.036000,18.389600>0.584200 translate<0,0.000000,0>}
cylinder{<35.052000,-0.1,18.389600><35.052000,0.135000,18.389600>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<35.052000,0,13.360400><35.052000,0.036000,13.360400>0.584200 translate<0,0.000000,0>}
cylinder{<35.052000,-0.1,13.360400><35.052000,0.135000,13.360400>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<38.100000,0,18.389600><38.100000,0.036000,18.389600>1.854200 translate<0,0.000000,0>}
cylinder{<38.100000,-0.1,18.389600><38.100000,0.135000,18.389600>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<38.100000,0,13.360400><38.100000,0.036000,13.360400>1.854200 translate<0,0.000000,0>}
cylinder{<38.100000,-0.1,13.360400><38.100000,0.135000,13.360400>1.701800 translate<0,0.000000,0>}}
box{<-0.381000,0,-1.905000><0.381000,0.036000,1.905000> rotate<0,-90.000000,0> translate<38.100000,0.000000,15.875000>}
//X4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,27.305000>}
box{<0,0,-0.076200><1.397000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.259000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,27.305000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.163000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,37.465000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.163000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,37.465000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.656000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,26.797000>}
box{<0,0,-0.076200><0.523634,0.036000,0.076200> rotate<0,-75.958743,0> translate<34.925000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,27.305000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.163000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.925000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,26.797000>}
box{<0,0,-0.076200><1.143000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.925000,0.000000,26.797000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,26.797000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,27.305000>}
box{<0,0,-0.076200><0.523634,0.036000,0.076200> rotate<0,75.958743,0> translate<35.941000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.052000,0.000000,27.305000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.052000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,37.465000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<35.941000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,37.465000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.941000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,37.465000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.259000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.941000,0.000000,27.305000>}
box{<0,0,-0.076200><4.318000,0.036000,0.076200> rotate<0,0.000000,0> translate<35.941000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.259000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.656000,0.000000,37.465000>}
box{<0,0,-0.076200><1.397000,0.036000,0.076200> rotate<0,0.000000,0> translate<40.259000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,33.883600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,36.296600>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<37.084000,0.000000,36.296600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,33.502600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,35.915600>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<36.703000,0.000000,35.915600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,28.473400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,30.886400>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<36.703000,0.000000,30.886400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,28.854400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,31.267400>}
box{<0,0,-0.076200><3.412497,0.036000,0.076200> rotate<0,44.997030,0> translate<37.084000,0.000000,31.267400> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.116000,0.000000,33.883600>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.084000,0.000000,35.915600>}
box{<0,0,-0.304800><2.873682,0.036000,0.304800> rotate<0,44.997030,0> translate<37.084000,0.000000,35.915600> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<39.116000,0.000000,28.854400>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.084000,0.000000,30.886400>}
box{<0,0,-0.304800><2.873682,0.036000,0.304800> rotate<0,44.997030,0> translate<37.084000,0.000000,30.886400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,33.502600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,33.883600>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.116000,0.000000,33.502600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,35.915600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,36.296600>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.703000,0.000000,35.915600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,28.473400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.497000,0.000000,28.854400>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.116000,0.000000,28.473400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.703000,0.000000,30.886400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,31.267400>}
box{<0,0,-0.076200><0.538815,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.703000,0.000000,30.886400> }
difference{
cylinder{<35.052000,0,34.899600><35.052000,0.036000,34.899600>0.584200 translate<0,0.000000,0>}
cylinder{<35.052000,-0.1,34.899600><35.052000,0.135000,34.899600>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<35.052000,0,29.870400><35.052000,0.036000,29.870400>0.584200 translate<0,0.000000,0>}
cylinder{<35.052000,-0.1,29.870400><35.052000,0.135000,29.870400>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<38.100000,0,34.899600><38.100000,0.036000,34.899600>1.854200 translate<0,0.000000,0>}
cylinder{<38.100000,-0.1,34.899600><38.100000,0.135000,34.899600>1.701800 translate<0,0.000000,0>}}
difference{
cylinder{<38.100000,0,29.870400><38.100000,0.036000,29.870400>1.854200 translate<0,0.000000,0>}
cylinder{<38.100000,-0.1,29.870400><38.100000,0.135000,29.870400>1.701800 translate<0,0.000000,0>}}
box{<-0.381000,0,-1.905000><0.381000,0.036000,1.905000> rotate<0,-90.000000,0> translate<38.100000,0.000000,32.385000>}
//X5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.050000,-1.536000,5.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.050000,-1.536000,5.415000>}
box{<0,0,-0.063500><16.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<11.050000,-1.536000,5.415000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.050000,-1.536000,5.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.050000,-1.536000,29.415000>}
box{<0,0,-0.063500><24.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<27.050000,-1.536000,29.415000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<27.050000,-1.536000,29.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.050000,-1.536000,29.415000>}
box{<0,0,-0.063500><16.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<11.050000,-1.536000,29.415000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.050000,-1.536000,29.415000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<11.050000,-1.536000,5.415000>}
box{<0,0,-0.063500><24.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<11.050000,-1.536000,5.415000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.050000,-1.536000,13.215000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<25.050000,-1.536000,13.215000>}
box{<0,0,-0.063500><12.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.050000,-1.536000,13.215000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<25.050000,-1.536000,13.215000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<25.050000,-1.536000,28.215000>}
box{<0,0,-0.063500><15.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<25.050000,-1.536000,28.215000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<25.050000,-1.536000,28.215000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.050000,-1.536000,28.215000>}
box{<0,0,-0.063500><12.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<13.050000,-1.536000,28.215000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.050000,-1.536000,28.215000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<13.050000,-1.536000,13.215000>}
box{<0,0,-0.063500><15.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<13.050000,-1.536000,13.215000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  HOMEFI_10(-21.431250,0,-23.495000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//F1	FUSEPICOFUSE	PICOFUSE
//GPIO	GPIO	TACT_PANA-EVQ
//HKLP1	HKLPM01	HKLPM01
//R1	S05K250	S05K250
//RESET	RESET	TACT_PANA-EVQ
//U$1	DHT11-PION.	DHT11-PION.
//U1	RELAY-SOLIDSTATEPTH	RELAY-S108T02
//X5		ESP-12
