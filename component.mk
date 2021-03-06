#
# component Makefile.
#
# (Uses default behaviour of compiling all source files in directory, adding 'include' to include path.)

JOYLINK_SDK ?= joylink_cloud/joylink_dev_sdk
JOYLINK_THUNDER ?= joylink_cloud/joylink_thunder
JOYLINK_SOFTAP ?= joylink_cloud/joylink_softap
JOYLINK_PORT ?= port

COMPONENT_ADD_INCLUDEDIRS := 
JOYLINK_SDK_INCLUDEDIRS = auth joylink json list
JOYLINK_SDK_SRCDIRS = auth joylink json list
COMPONENT_ADD_INCLUDEDIRS += $(addprefix $(JOYLINK_SDK)/,$(JOYLINK_SDK_INCLUDEDIRS)) \
				$(JOYLINK_SDK)
COMPONENT_SRCDIRS += $(addprefix $(JOYLINK_SDK)/,$(JOYLINK_SDK_SRCDIRS))

COMPONENT_ADD_INCLUDEDIRS += $(JOYLINK_THUNDER)
COMPONENT_SRCDIRS += $(JOYLINK_THUNDER)

ifndef CONFIG_IDF_TARGET_ESP8266

LIBS += joylink_ble

COMPONENT_ADD_LDFLAGS += -L $(COMPONENT_PATH)/joylink_cloud/joylink_ble/lib \
                           $(addprefix -l,$(LIBS))
endif

COMPONENT_ADD_INCLUDEDIRS += joylink_cloud/joylink_ble/include

JOYLINK_SDK_C_FILES =  auth/joylink3_auth_uECC.c		\
			auth/joylink_aes.c			\
			auth/joylink_auth_crc.c			\
			auth/joylink_auth_md5.c			\
			auth/joylink_auth_uECC.c		\
			auth/joylink_crypt.c			\
								\
								\
			joylink/joylink_dev_lan.c		\
			joylink/joylink_dev_sdk.c		\
			joylink/joylink_dev_server.c		\
			joylink/joylink_dev_timer.c		\
			joylink/joylink_join_packet.c		\
			joylink/joylink_packets.c		\
			joylink/joylink_security.c		\
			joylink/joylink_sub_dev.c		\
			joylink/joylink_utils.c			\
			joylink/joylink_cloud_log.c     \
			joylink/joylink_dev_active.c    \
								\
								\
			json/joylink_json.c			\
			json/joylink_json_sub_dev.c		\
								\
								\
			list/joylink_list.c


JOYLINK_THUNDER_C_FILES = joylink_smnt.c \
						  joylink_thunder_slave_sdk.c  \
						  joylink_probe.c

JOYLINK_SOFTAP_C_FILES = joylink_softap.c 

COMPONENT_ADD_INCLUDEDIRS += $(JOYLINK_SOFTAP)
COMPONENT_SRCDIRS += $(JOYLINK_SOFTAP)

COMPONENT_OBJS += $(addprefix $(JOYLINK_SDK)/,$(JOYLINK_SDK_C_FILES:%.c=%.o))
COMPONENT_OBJS += $(addprefix $(JOYLINK_THUNDER)/,$(JOYLINK_THUNDER_C_FILES:%.c=%.o))
COMPONENT_OBJS += $(addprefix $(JOYLINK_SOFTAP)/,$(JOYLINK_SOFTAP_C_FILES:%.c=%.o))


JOYLINK_PORT_SRCDIRS = app ble extern jdinnet softap
JOYLINK_PORT_INCLUDEDIRS = include jdinnet extern

JOYLINK_PORT_C_FILES =	app/joylink_app.c			\
			ble/joylink_ble.c						\
			extern/joylink_extern_json.c			\
			extern/joylink_extern_sub_dev.c			\
			extern/joylink_extern.c					\
			extern/joylink_porting_layer.c			\
			extern/joylink_upgrade.c				\
			jdinnet/jd_innet.c						\
			softap/joylink_softap_config.c


COMPONENT_ADD_INCLUDEDIRS += $(addprefix $(JOYLINK_PORT)/,$(JOYLINK_PORT_INCLUDEDIRS))
COMPONENT_SRCDIRS += $(addprefix  $(JOYLINK_PORT)/,$(JOYLINK_PORT_SRCDIRS))
COMPONENT_OBJS += $(addprefix  $(JOYLINK_PORT)/,$(JOYLINK_PORT_C_FILES:%.c=%.o))

CFLAGS += -D__LINUX_UB2__ -D__LINUX__ -DJLdevice_aes_decrypt=device_aes_decrypt -D_GET_HOST_BY_NAME_
CFLAGS += -Wno-error=unused-label -Wno-error=maybe-uninitialized -Wno-error=implicit-function-declaration -Wno-error=pointer-sign -Wno-error=char-subscripts -Wno-error=sizeof-pointer-memaccess -Wno-error=format