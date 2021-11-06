# TCL File Generated by Component Editor 18.1
# Wed Nov 03 17:03:24 CET 2021
# DO NOT MODIFY


# 
# LCD_controller "LCD_controller" v1.0
#  2021.11.03.17:03:24
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module LCD_controller
# 
set_module_property DESCRIPTION ""
set_module_property NAME LCD_controller
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME LCD_controller
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL LCDPort
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file screen.vhd VHDL PATH screen.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock_sink
set_interface_property avalon_slave_0 associatedReset reset_sink
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 Address address Input 3
add_interface_port avalon_slave_0 ChipSelect chipselect Input 1
add_interface_port avalon_slave_0 Write write Input 1
add_interface_port avalon_slave_0 WriteData writedata Input 16
add_interface_port avalon_slave_0 wait_request waitrequest Output 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink signalsClk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink nReset reset_n Input 1


# 
# connection point CS
# 
add_interface CS conduit end
set_interface_property CS associatedClock clock_sink
set_interface_property CS associatedReset ""
set_interface_property CS ENABLED true
set_interface_property CS EXPORT_OF ""
set_interface_property CS PORT_NAME_MAP ""
set_interface_property CS CMSIS_SVD_VARIABLES ""
set_interface_property CS SVD_ADDRESS_GROUP ""

add_interface_port CS LCD_CS export Output 1


# 
# connection point C_D
# 
add_interface C_D conduit end
set_interface_property C_D associatedClock clock_sink
set_interface_property C_D associatedReset ""
set_interface_property C_D ENABLED true
set_interface_property C_D EXPORT_OF ""
set_interface_property C_D PORT_NAME_MAP ""
set_interface_property C_D CMSIS_SVD_VARIABLES ""
set_interface_property C_D SVD_ADDRESS_GROUP ""

add_interface_port C_D LCD_C_D export Output 1


# 
# connection point DATA
# 
add_interface DATA conduit end
set_interface_property DATA associatedClock clock_sink
set_interface_property DATA associatedReset ""
set_interface_property DATA ENABLED true
set_interface_property DATA EXPORT_OF ""
set_interface_property DATA PORT_NAME_MAP ""
set_interface_property DATA CMSIS_SVD_VARIABLES ""
set_interface_property DATA SVD_ADDRESS_GROUP ""

add_interface_port DATA LCD_DATA export Output 16


# 
# connection point IM0
# 
add_interface IM0 conduit end
set_interface_property IM0 associatedClock clock_sink
set_interface_property IM0 associatedReset ""
set_interface_property IM0 ENABLED true
set_interface_property IM0 EXPORT_OF ""
set_interface_property IM0 PORT_NAME_MAP ""
set_interface_property IM0 CMSIS_SVD_VARIABLES ""
set_interface_property IM0 SVD_ADDRESS_GROUP ""

add_interface_port IM0 LCD_IM0 export Output 1


# 
# connection point RD
# 
add_interface RD conduit end
set_interface_property RD associatedClock clock_sink
set_interface_property RD associatedReset reset_sink
set_interface_property RD ENABLED true
set_interface_property RD EXPORT_OF ""
set_interface_property RD PORT_NAME_MAP ""
set_interface_property RD CMSIS_SVD_VARIABLES ""
set_interface_property RD SVD_ADDRESS_GROUP ""

add_interface_port RD LCD_RD export Output 1


# 
# connection point RES
# 
add_interface RES conduit end
set_interface_property RES associatedClock clock_sink
set_interface_property RES associatedReset ""
set_interface_property RES ENABLED true
set_interface_property RES EXPORT_OF ""
set_interface_property RES PORT_NAME_MAP ""
set_interface_property RES CMSIS_SVD_VARIABLES ""
set_interface_property RES SVD_ADDRESS_GROUP ""

add_interface_port RES LCD_RES export Output 1


# 
# connection point WR
# 
add_interface WR conduit end
set_interface_property WR associatedClock clock_sink
set_interface_property WR associatedReset ""
set_interface_property WR ENABLED true
set_interface_property WR EXPORT_OF ""
set_interface_property WR PORT_NAME_MAP ""
set_interface_property WR CMSIS_SVD_VARIABLES ""
set_interface_property WR SVD_ADDRESS_GROUP ""

add_interface_port WR LCD_WR export Output 1

