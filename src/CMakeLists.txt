# copyright
# app name
# url

# copyright
# app name
# url


add_executable(myapp "")

if(CMAKE_BUILD_TYPE MATCHES "(Release|Debug)")
  target_compile_options(myapp
    PRIVATE
      "-Wconversion"
      "-Wformat=2"
  )
endif()

target_include_directories(myapp
  PRIVATE 
    ${PROJECT_BINARY_DIR}
    ${PROJECT_SOURCE_DIR}
    ${OPENSSL_INCLUDE_DIR}
)

target_sources(myapp
  PRIVATE
    main.c
)