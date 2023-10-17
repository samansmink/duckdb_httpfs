cmake_minimum_required(VERSION 2.8.12)

project(HTTPFsExtension)

include_directories(src/include duckdb/third_party/httplib duckdb/extension/parquet/include)

set(HTTPFS_SOURCES src/s3fs.cpp src/httpfs.cpp src/crypto.cpp src/httpfs_extension.cpp)
build_static_extension(httpfs ${HTTPFS_SOURCES})
build_loadable_extension(httpfs ${HTTPFS_SOURCES})

find_package(OpenSSL REQUIRED)

include_directories(${OPENSSL_INCLUDE_DIR})
target_link_libraries(httpfs_loadable_extension duckdb_mbedtls
                      ${OPENSSL_LIBRARIES})
target_link_libraries(httpfs_extension duckdb_mbedtls ${OPENSSL_LIBRARIES})

if(MINGW)
  find_package(ZLIB)
  target_link_libraries(httpfs_loadable_extension ZLIB::ZLIB -lcrypt32)
  target_link_libraries(httpfs_extension ZLIB::ZLIB -lcrypt32)
endif()

install(
  TARGETS httpfs_extension
  EXPORT "${DUCKDB_EXPORT_SET}"
  LIBRARY DESTINATION "${INSTALL_LIB_DIR}"
  ARCHIVE DESTINATION "${INSTALL_LIB_DIR}")
