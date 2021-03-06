set(COMPONENT_ADD_INCLUDEDIRS
    joylink_cloud/joylink_dev_sdk/agent
    joylink_cloud/joylink_dev_sdk/auth
    joylink_cloud/joylink_dev_sdk/joylink
    joylink_cloud/joylink_dev_sdk/json
    joylink_cloud/joylink_dev_sdk/list
    joylink_cloud/joylink_dev_sdk
    joylink_cloud/joylink_smnt_v3.0.11
    joylink_cloud/joylink_ble/include
    joylink_cloud/joylink_softap
    port/include
    port/jdinnet
    port/extern)

# Edit following two lines to set component requirements (see docs)
set(COMPONENT_REQUIRES bt nvs_flash app_update)
set(COMPONENT_PRIV_REQUIRES )

set(COMPONENT_SRCS 
    joylink_cloud/joylink_dev_sdk/agent/joylink_adapter_net.c
    joylink_cloud/joylink_dev_sdk/agent/joylink_agent.c
    joylink_cloud/joylink_dev_sdk/agent/joylink_agent_devs.c
    joylink_cloud/joylink_dev_sdk/agent/joylink_agent_gw_2_cloud.c
    joylink_cloud/joylink_dev_sdk/agent/joylink_agent_json.c
    joylink_cloud/joylink_dev_sdk/auth/joylink3_auth_uECC.c
    joylink_cloud/joylink_dev_sdk/auth/joylink_aes.c
    joylink_cloud/joylink_dev_sdk/auth/joylink_auth_crc.c
    joylink_cloud/joylink_dev_sdk/auth/joylink_auth_md5.c
    joylink_cloud/joylink_dev_sdk/auth/joylink_auth_uECC.c
    joylink_cloud/joylink_dev_sdk/auth/joylink_crypt.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_dev_lan.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_dev_sdk.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_dev_server.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_dev_timer.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_join_packet.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_packets.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_security.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_sub_dev.c
    joylink_cloud/joylink_dev_sdk/joylink/joylink_utils.c
    joylink_cloud/joylink_dev_sdk/json/joylink_json.c
    joylink_cloud/joylink_dev_sdk/json/joylink_json_sub_dev.c
    joylink_cloud/joylink_dev_sdk/list/joylink_list.c
    joylink_cloud/joylink_smnt_v3.0.11/joylink_smnt.c
    joylink_cloud/joylink_softap/joylink_softap.c
    joylink_cloud/joylink_softap/joylink_util.c
    port/app/joylink_app.c
    port/ble/joylink_ble.c
    port/extern/joylink_extern_json.c
    port/extern/joylink_extern_sub_dev.c
    port/extern/joylink_extern.c
    port/extern/joylink_porting_layer.c
    port/extern/joylink_upgrade.c
    port/jdinnet/jd_innet.c
    port/softap/joylink_softap.c)

register_component()
component_compile_options(-D__LINUX_UB2__ -D__LINUX__ -DJLdevice_aes_decrypt=device_aes_decrypt -D_GET_HOST_BY_NAME_ -Wno-error=unused-label -Wno-error=maybe-uninitialized -Wno-error=implicit-function-declaration -Wno-error=pointer-sign -Wno-error=char-subscripts -Wno-error=sizeof-pointer-memaccess -Wno-error=format)

if(CONFIG_BT_ENABLED)
# use this for idf v3.1/v3.2
target_link_libraries(esp-joylink "-L${CMAKE_CURRENT_LIST_DIR}/joylink_cloud/joylink_ble/lib")
target_link_libraries(esp-joylink joylink_ble)

# use this for idf v3.3+
# target_link_libraries(${COMPONENT_TARGET} INTERFACE "-L${CMAKE_CURRENT_LIST_DIR}/joylink_cloud/joylink_ble/lib")
# target_link_libraries(${COMPONENT_TARGET} PUBLIC joylink_ble)
endif()