# GPL-3.0-or-later
# mail
# https://github.com/breezecloud/mongoose_cmake1

add_library(mongoose "")

target_sources(mongoose
  PRIVATE
    mongoose.c
  PUBLIC
    mongoose.h
)

target_compile_options(mongoose
  PRIVATE
    "-DMG_ENABLE_DIRLIST=1"
    "-DMG_ENABLE_SSI=0"
    "-DMG_TLS=MG_TLS_OPENSSL"
)

if(CMAKE_BUILD_TYPE MATCHES "(Debug|Release|RelWithDebInfo|MinSizeRel)")
  target_compile_options(mongoose
    PRIVATE
      "-Wno-unused-parameter"
  )
endif()


target_include_directories(mongoose SYSTEM
  PRIVATE
    ${OPENSSL_INCLUDE_DIR}
)
