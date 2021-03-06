
set_property PACKAGE_PIN R18 [get_ports {btns_4bits_tri_i[0]}]
set_property PACKAGE_PIN P16 [get_ports {btns_4bits_tri_i[1]}]
set_property PACKAGE_PIN V16 [get_ports {btns_4bits_tri_i[2]}]
set_property PACKAGE_PIN Y16 [get_ports {btns_4bits_tri_i[3]}]

set_property PACKAGE_PIN G15 [get_ports {sws_4bits_tri_i[0]}]
set_property PACKAGE_PIN P15 [get_ports {sws_4bits_tri_i[1]}]
set_property PACKAGE_PIN W13 [get_ports {sws_4bits_tri_i[2]}]
set_property PACKAGE_PIN T16 [get_ports {sws_4bits_tri_i[3]}]

set_property PACKAGE_PIN M14 [get_ports {leds_4bits_tri_o[0]}]
set_property PACKAGE_PIN M15 [get_ports {leds_4bits_tri_o[1]}]
set_property PACKAGE_PIN G14 [get_ports {leds_4bits_tri_o[2]}]
set_property PACKAGE_PIN D18 [get_ports {leds_4bits_tri_o[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {leds_4bits_tri_o[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btns_4bits_tri_i[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sws_4bits_tri_i[*]}]


set_property PACKAGE_PIN R19 [get_ports v_s]
set_property PACKAGE_PIN P19 [get_ports h_s]

set_property IOSTANDARD LVCMOS33 [get_ports h_s]
set_property IOSTANDARD LVCMOS33 [get_ports v_s]


set_property PACKAGE_PIN F19 [get_ports {RED[4]}]
set_property PACKAGE_PIN G20 [get_ports {RED[3]}]
set_property PACKAGE_PIN J20 [get_ports {RED[2]}]
set_property PACKAGE_PIN L20 [get_ports {RED[1]}]
set_property PACKAGE_PIN M19 [get_ports {RED[0]}]

set_property PACKAGE_PIN F20 [get_ports {GREEN[5]}]
set_property PACKAGE_PIN H20 [get_ports {GREEN[4]}]
set_property PACKAGE_PIN J19 [get_ports {GREEN[3]}]
set_property PACKAGE_PIN L19 [get_ports {GREEN[2]}]
set_property PACKAGE_PIN N20 [get_ports {GREEN[1]}]
set_property PACKAGE_PIN H18 [get_ports {GREEN[0]}]

set_property PACKAGE_PIN G19 [get_ports {BLUE[4]}]
set_property PACKAGE_PIN J18 [get_ports {BLUE[3]}]
set_property PACKAGE_PIN K19 [get_ports {BLUE[2]}]
set_property PACKAGE_PIN M20 [get_ports {BLUE[1]}]
set_property PACKAGE_PIN P20 [get_ports {BLUE[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {BLUE[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {GREEN[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RED[*]}]
