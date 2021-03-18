if (NOT DEFINED ENV{CUBE})
	message(FATAL_ERROR "CUBE environment variable was not defined!")
endif()

set(CUBE_HOME "$ENV{CUBE}" CACHE INTERNAL "Copied from environment variable")

SET (CUBE_ROOT "${CUBE_HOME}/Repository/STM32Cube_FW_L4_V1.16.0")
 
SET (LINKER_SCRIPT "${CUBE_ROOT}/Projects/NUCLEO-L476RG/Templates/SW4STM32/STM32L476RG_NUCLEO/STM32L476RGTx_FLASH.ld")
 
SET (CMAKE_SYSTEM_NAME Generic)
SET (CMAKE_SYSTEM_PROCESSOR arm)
 

SET(CMAKE_CXX_FLAGS "-mcpu=cortex-m4 -std=c++17 -fno-rtti -fno-exceptions -Wall -fdata-sections -ffunction-sections -MD -Wall -Wno-psabi" CACHE INTERNAL "cxx compiler flags")
 
SET (CMAKE_EXE_LINKER_FLAGS "-T ${LINKER_SCRIPT} -specs=nosys.specs -Wl,--gc-sections" CACHE INTERNAL "exe link flags")
