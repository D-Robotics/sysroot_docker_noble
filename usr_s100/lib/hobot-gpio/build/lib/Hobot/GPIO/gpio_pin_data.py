import os
import os.path
import copy


HOBOT_PI = 'HOBOT_PI'
SYSFS_GPIO = "/sys/class/gpio"
SYSFS_PLATFORM_PATH = '/sys/devices/platform/'
SYSFS_BOARDID_PATH = '/sys/class/socinfo/board_id'
HOBOT_PI_PATTERN = 'hobot,x3'


if not os.path.exists(SYSFS_BOARDID_PATH):
    SYSFS_BOARDID_PATH = '/sys/class/boardinfo/adc_boardid'

# [0]- GPIO chip sysfs directory
# [1]- Linux exported GPIO name,
# [2]- Pin number (BOARD mode)
# [3]- Pin number (BCM mode)
# [4]- Pin name (CVM mode)
# [5]- Pin name (SOC mode)
# [6]- PWM chip sysfs directory
# [7]- PWM ID

SDBV3_PIN = [
    ["soc/a6003000.gpio", 11, 3, 2, 'I2C1_SDA', 'I2C1_SDA', None, None],
    ["soc/a6003000.gpio", 10, 5, 3, 'I2C1_SCL', 'I2C1_SCL', None, None],
    ["soc/a6003000.gpio", 38, 7, 4, 'GPIO38', 'GPIO38', None, None],
    ["soc/a6003000.gpio", 6, 11, 17, 'GPIO6', 'JTG_TDI', None, None],
    ["soc/a6003000.gpio", 5, 13, 27, 'GPIO5', 'JTG_TMS', None, None],
    ["soc/a6003000.gpio", 30, 15, 22, 'GPIO30', 'BIFSPI_MISO', None, None],
    ["soc/a6003000.gpio", 18, 19, 10, 'SPI0_MOSI',
        'SPI0_MOSI', "soc/a500e000.pwm", 2],
    ["soc/a6003000.gpio", 19, 21, 9, 'SPI0_MISO',
        'SPI0_MISO', "soc/a500f000.pwm", 0],
    ["soc/a6003000.gpio", 17, 23, 11, 'SPI0_SCLK', 'SPI0_SCLK', None, None],
    ["soc/a6003000.gpio", 14, 29, 5, 'GPIO14', 'SPI2_SCLK', None, None],
    ["soc/a6003000.gpio", 31, 31, 6, 'GPIO31', 'BIFSPI_RSTN', None, None],
    ["soc/a6003000.gpio", 13, 33, 13, 'PWM8', 'SPI2_MISO', "soc/a500f000.pwm", 2],
    ["soc/a6003000.gpio", 103, 35, 19, 'I2S0_LRCK', 'I2S0_LRCK', None, None],
    ["soc/a6003000.gpio", 29, 37, 26, 'GPIO29', 'BIFSPI_MOSI', None, None],

    ["soc/a6003000.gpio", 95, 8, 14, 'UART0_TXD', 'UART0_TXD', None, None],
    ["soc/a6003000.gpio", 96, 10, 15, 'UART0_RXD', 'UART0_RXD', None, None],
    ["soc/a6003000.gpio", 102, 12, 18, 'I2S0_BCLK', 'I2S0_BCLK', None, None],
    ["soc/a6003000.gpio", 27, 16, 23, 'GPIO27', 'BIFSPI_CSN', None, None],
    ["soc/a6003000.gpio", 7, 18, 24, 'GPIO7', 'JTG_TDO', None, None],
    ["soc/a6003000.gpio", 15, 22, 25, 'GPIO15', 'SPI2_CSN', None, None],
    ["soc/a6003000.gpio", 16, 24, 8, 'SPI0_CSN', 'I2C4_SDA', None, None],
    ["soc/a6003000.gpio", 120, 26, 7, 'SPI0_CSN1', 'QSPI_CSN1', None, None],
    ["soc/a6003000.gpio", 12, 32, 12, 'PWM7', 'SPI2_MOSI', "soc/a500f000.pwm", 1],
    ["soc/a6003000.gpio", 28, 36, 16, 'GPIO28', 'BIFSPI_SCLK', None, None],
    ["soc/a6003000.gpio", 104, 38, 20, 'I2S0_SDIO', 'I2S0_SDIO', None, None],
    ["soc/a6003000.gpio", 108, 40, 21, 'I2S1_SDIO', 'I2S1_SDIO', None, None],
]

SDB_PIN = [
    ["soc/a6003000.gpio", 11, 3, 2, 'I2C1_SDA', 'I2C1_SDA', None, None],
    ["soc/a6003000.gpio", 10, 5, 3, 'I2C1_SCL', 'I2C1_SCL', None, None],
    ["soc/a6003000.gpio", 101, 7, 4, 'I2S0_MCLK', 'I2S0_MCLK', None, None],
    ["soc/a6003000.gpio", 6, 11, 17, 'GPIO6', 'JTG_TDI', None, None],
    ["soc/a6003000.gpio", 5, 13, 27, 'GPIO5', 'JTG_TMS', None, None],
    ["soc/a6003000.gpio", 30, 15, 22, 'GPIO30', 'BIFSPI_MISO', None, None],
    ["soc/a6003000.gpio", 18, 19, 10, 'SPI0_MOSI',
        'SPI0_MOSI', "soc/a500e000.pwm", 2],
    ["soc/a6003000.gpio", 19, 21, 9, 'SPI0_MISO',
        'SPI0_MISO', "soc/a500f000.pwm", 0],
    ["soc/a6003000.gpio", 17, 23, 11, 'SPI0_SCLK', 'SPI0_SCLK', None, None],
    ["soc/a6003000.gpio", 106, 27, 0, 'I2S1_BLCK', 'I2S1_BLCK', None, None],
    ["soc/a6003000.gpio", 14, 29, 5, 'GPIO14', 'SPI2_SCLK', None, None],
    ["soc/a6003000.gpio", 31, 31, 6, 'GPIO31', 'BIFSPI_RSTN', None, None],
    ["soc/a6003000.gpio", 4, 33, 13, 'PWM0', 'PWM0', "soc/a500d000.pwm", 0],
    ["soc/a6003000.gpio", 103, 35, 19, 'I2S0_LRCK', 'I2S0_LRCK', None, None],
    ["soc/a6003000.gpio", 105, 37, 26, 'GPIO105', 'I2S1_MCLK', None, None],

    ["soc/a6003000.gpio", 111, 8, 14, 'UART3_TXD', 'UART3_TXD', None, None],
    ["soc/a6003000.gpio", 112, 10, 15, 'UART3_RXD', 'UART3_RXD', None, None],
    ["soc/a6003000.gpio", 102, 12, 18, 'I2S0_BCLK', 'I2S0_BCLK', None, None],
    ["soc/a6003000.gpio", 27, 16, 23, 'GPIO27', 'BIFSPI_CSN', None, None],
    ["soc/a6003000.gpio", 7, 18, 24, 'GPIO7', 'JTG_TDO', None, None],
    ["soc/a6003000.gpio", 15, 22, 25, 'GPIO15', 'SPI2_CSN', None, None],
    ["soc/a6003000.gpio", 16, 24, 8, 'SPI0_CSN', 'I2C4_SDA', None, None],
    ["soc/a6003000.gpio", 120, 26, 7, 'SPI0_CSN1', 'QSPI_CSN1', None, None],
    ["soc/a6003000.gpio", 107, 28, 1, 'I2S1_LRCK', 'I2S1_LRCK', None, None],
    ["soc/a6003000.gpio", 25, 32, 12, 'PWM4', 'PWM4', "soc/a500e000.pwm", 1],
    ["soc/a6003000.gpio", 3, 36, 16, 'GPIO3', 'JTG_TCK', None, None],
    ["soc/a6003000.gpio", 104, 38, 20, 'I2S0_SDIO', 'I2S0_SDIO', None, None],
    ["soc/a6003000.gpio", 108, 40, 21, 'I2S1_SDIO', 'I2S1_SDIO', None, None],
]

X3_PI_PIN = [
    ["soc/a6003000.gpio", 9, 3, 2, 'I2C0_SDA', 'I2C0_SDA', None, None],
    ["soc/a6003000.gpio", 8, 5, 3, 'I2C0_SCL', 'I2C0_SCL', None, None],
    ["soc/a6003000.gpio", 101, 7, 4, 'I2S0_MCLK', 'I2S0_MCLK', None, None],
    ["soc/a6003000.gpio", 6, 11, 17, 'GPIO6', 'JTG_TDI', None, None],
    ["soc/a6003000.gpio", 5, 13, 27, 'GPIO5', 'JTG_TMS', None, None],
    ["soc/a6003000.gpio", 30, 15, 22, 'GPIO30', 'BIFSPI_MISO', None, None],
    ["soc/a6003000.gpio", 12, 19, 10, 'SPI2_MOSI',
        'SPI2_MOSI', "soc/a500f000.pwm", 1],
    ["soc/a6003000.gpio", 13, 21, 9, 'SPI2_MISO',
        'SPI2_MISO', "soc/a500f000.pwm", 2],
    ["soc/a6003000.gpio", 14, 23, 11, 'SPI2_SCLK', 'SPI2_SCLK', None, None],
    ["soc/a6003000.gpio", 106, 27, 0, 'I2S1_BCLK', 'I2S1_BCLK', None, None],
    ["soc/a6003000.gpio", 119, 29, 5, 'GPIO119', 'GPIO119', None, None],
    ["soc/a6003000.gpio", 118, 31, 6, 'GPIO118', 'GPIO118', None, None],
    ["soc/a6003000.gpio", 4, 33, 13, 'PWM0', 'JTG_TRSTN', "soc/a500d000.pwm", 0],
    ["soc/a6003000.gpio", 103, 35, 19, 'I2S0_LRCK', 'I2S0_LRCK', None, None],
    ["soc/a6003000.gpio", 105, 37, 26, 'GPIO105', 'I2S1_MCLK', None, None],

    ["soc/a6003000.gpio", 111, 8, 14, 'UART_TXD', 'SENSOR2_MCLK', None, None],
    ["soc/a6003000.gpio", 112, 10, 15, 'UART_RXD', 'SENSOR3_MCLK', None, None],
    ["soc/a6003000.gpio", 102, 12, 18, 'I2S0_BCLK', 'I2S0_BCLK', None, None],
    ["soc/a6003000.gpio", 27, 16, 23, 'GPIO27', 'BIFSPI_CSN', None, None],
    ["soc/a6003000.gpio", 7, 18, 24, 'GPIO7', 'JTG_TDO', None, None],
    ["soc/a6003000.gpio", 29, 22, 25, 'GPIO29', 'BIFSPI_MOSI', None, None],
    ["soc/a6003000.gpio", 15, 24, 8, 'SPI2_CSN', 'SPI2_CSN', None, None],
    ["soc/a6003000.gpio", 28, 26, 7, 'GPIO28', 'BIFSPI_SCLK', None, None],
    ["soc/a6003000.gpio", 107, 28, 1, 'I2S1_LRCK', 'I2S1_LRCK', None, None],
    ["soc/a6003000.gpio", 25, 32, 12, 'PWM4', 'PWM4', "soc/a500e000.pwm", 1],
    ["soc/a6003000.gpio", 3, 36, 16, 'GPIO3', 'JTG_TCK', None, None],
    ["soc/a6003000.gpio", 104, 38, 20, 'I2S0_SDIO', 'I2S0_SDIO', None, None],
    ["soc/a6003000.gpio", 108, 40, 21, 'I2S1_SDIO', 'I2S1_SDIO', None, None],
]

X3_CM_PIN = [
    ["soc/a6003000.gpio", 9, 3, 2, 'I2C0_SDA', 'I2C0_SDA', None, None],
    ["soc/a6003000.gpio", 8, 5, 3, 'I2C0_SCL', 'I2C0_SCL', None, None],
    ["soc/a6003000.gpio", 101, 7, 4, 'I2S0_MCLK', 'I2S0_MCLK', None, None],
    ["soc/a6003000.gpio", 12, 11, 17, 'GPIO17',
        'SPI2_MOSI', "soc/a500f000.pwm", 1],
    ["soc/a6003000.gpio", 13, 13, 27, 'GPIO27',
        'SPI2_MISO', "soc/a500f000.pwm", 2],
    ["soc/a6003000.gpio", 30, 15, 22, 'GPIO22', 'BIFSPI_MISO', None, None],
    ["soc/a6003000.gpio", 6, 19, 10, 'SPI1_MOSI', 'SPI1_MOSI', None, None],
    ["soc/a6003000.gpio", 7, 21, 9, 'SPI1_MISO', 'SPI1_MISO', None, None],
    ["soc/a6003000.gpio", 3, 23, 11, 'SPI1_SCLK', 'SPI1_SCLK', None, None],
    ["soc/a6003000.gpio", 15, 27, 0, 'I2C3_SDA', 'I2C3_SDA', None, None],
    ["soc/a6003000.gpio", 119, 29, 5, 'GPIO5', 'LPWM3', None, None],
    ["soc/a6003000.gpio", 118, 31, 6, 'GPIO6', 'LPWM4', None, None],
    ["soc/a6003000.gpio", 4, 33, 13, 'PWM0', 'PWM0', "soc/a500d000.pwm", 0],
    ["soc/a6003000.gpio", 103, 35, 19, 'I2S0_LRCK', 'I2S0_LRCK', None, None],
    ["soc/a6003000.gpio", 117, 37, 26, 'GPIO25', 'LPWM5', None, None],

    ["soc/a6003000.gpio", 111, 8, 14, 'UART_TXD', 'UART3_TXD', None, None],
    ["soc/a6003000.gpio", 112, 10, 15, 'UART_RXD', 'UART3_RXD', None, None],
    ["soc/a6003000.gpio", 102, 12, 18, 'I2S0_BCLK', 'I2S0_BCLK', None, None],
    ["soc/a6003000.gpio", 27, 16, 23, 'GPIO23', 'BIFSPI_CSN', None, None],
    ["soc/a6003000.gpio", 22, 18, 24, 'GPIO24', 'PWM1', "soc/a500d000.pwm", 1],
    ["soc/a6003000.gpio", 29, 22, 25, 'GPIO25', 'BIFSPI_MOSI', None, None],
    ["soc/a6003000.gpio", 5, 24, 8, 'SPI1_CSN', 'SPI1_CSN', None, None],
    ["soc/a6003000.gpio", 28, 26, 7, 'GPIO7', 'BIFSPI_SCLK', None, None],
    ["soc/a6003000.gpio", 14, 28, 1, 'I2C3_SCL', 'I2C3_SCL', None, None],
    ["soc/a6003000.gpio", 25, 32, 12, 'PWM4', 'PWM4', "soc/a500e000.pwm", 1],
    ["soc/a6003000.gpio", 20, 36, 16, 'GPIO16', 'BIFSD_CLK', None, None],
    ["soc/a6003000.gpio", 108, 38, 20, 'I2S1_SDIO', 'I2S1_SDIO', None, None],
    ["soc/a6003000.gpio", 104, 40, 21, 'I2S0_SDIO', 'I2S0_SDIO', None, None],
]

X3_PI_V2_1_PIN = [
    ["soc/a6003000.gpio", 9, 3, 2, 'I2C0_SDA', 'I2C0_SDA', None, None],
    ["soc/a6003000.gpio", 8, 5, 3, 'I2C0_SCL', 'I2C0_SCL', None, None],
    ["soc/a6003000.gpio", 101, 7, 4, 'I2S0_MCLK', 'I2S0_MCLK', None, None],
    ["soc/a6003000.gpio", 12, 11, 17, 'GPIO17',
        'SPI2_MOSI', "soc/a500f000.pwm", 1],
    ["soc/a6003000.gpio", 13, 13, 27, 'GPIO27',
        'SPI2_MISO', "soc/a500f000.pwm", 2],
    ["soc/a6003000.gpio", 30, 15, 22, 'GPIO22', 'BIFSPI_MISO', None, None],
    ["soc/a6003000.gpio", 6, 19, 10, 'SPI1_MOSI', 'SPI1_MOSI', None, None],
    ["soc/a6003000.gpio", 7, 21, 9, 'SPI1_MISO', 'SPI1_MISO', None, None],
    ["soc/a6003000.gpio", 3, 23, 11, 'SPI1_SCLK', 'SPI1_SCLK', None, None],
    ["soc/a6003000.gpio", 15, 27, 0, 'I2C3_SDA', 'I2C3_SDA', None, None],
    ["soc/a6003000.gpio", 119, 29, 5, 'GPIO5', 'LPWM3', None, None],
    ["soc/a6003000.gpio", 118, 31, 6, 'GPIO6', 'LPWM4', None, None],
    ["soc/a6003000.gpio", 4, 33, 13, 'PWM0', 'PWM0', "soc/a500d000.pwm", 0],
    ["soc/a6003000.gpio", 103, 35, 19, 'I2S0_LRCK', 'I2S0_LRCK', None, None],
    ["soc/a6003000.gpio", 117, 37, 26, 'GPIO25', 'LPWM5', None, None],

    ["soc/a6003000.gpio", 111, 8, 14, 'UART_TXD', 'UART3_TXD', None, None],
    ["soc/a6003000.gpio", 112, 10, 15, 'UART_RXD', 'UART3_RXD', None, None],
    ["soc/a6003000.gpio", 102, 12, 18, 'I2S0_BCLK', 'I2S0_BCLK', None, None],
    ["soc/a6003000.gpio", 27, 16, 23, 'GPIO23', 'BIFSPI_CSN', None, None],
    ["soc/a6003000.gpio", 22, 18, 24, 'GPIO24', 'PWM1', "soc/a500d000.pwm", 1],
    ["soc/a6003000.gpio", 29, 22, 25, 'GPIO25', 'BIFSPI_MOSI', None, None],
    ["soc/a6003000.gpio", 5, 24, 8, 'SPI1_CSN', 'SPI1_CSN', None, None],
    ["soc/a6003000.gpio", 28, 26, 7, 'GPIO7', 'BIFSPI_SCLK', None, None],
    ["soc/a6003000.gpio", 14, 28, 1, 'I2C3_SCL', 'I2C3_SCL', None, None],
    ["soc/a6003000.gpio", 25, 32, 12, 'PWM4', 'PWM4', "soc/a500e000.pwm", 1],
    ["soc/a6003000.gpio", 20, 36, 16, 'GPIO16', 'BIFSD_CLK', None, None],
    ["soc/a6003000.gpio", 104, 38, 20, 'I2S0_SDIO', 'I2S0_SDIO', None, None],
    ["soc/a6003000.gpio", 108, 40, 21, 'I2S1_SDIO', 'I2S1_SDIO', None, None],
]

RDK_X5_PIN = [
    ["soc/34000000.a55_apb0/34120000.gpio", 387, 3, 2,
        'SDA', 'I2C5_SDA', None, None],  # I2C5_SDA/UART3_TXD
    ["soc/34000000.a55_apb0/34120000.gpio", 389, 5, 3,
        'SCL', 'I2C5_SCL', None, None],  # I2C5_SCL/UART3_RXD
    ["soc/32080000.dsp_apb/32150000.gpio", 420, 7, 4,
        'GPCLK0', 'I2S1_MCLK', None, None],  # I2S1_MCLK
    ["soc/34000000.a55_apb0/34120000.gpio", 380, 11, 17,
        'GPIO17', 'UART7_TXD', None, None],  # UART7_TXD
    ["soc/34000000.a55_apb0/34120000.gpio", 379, 13, 27,
        'GPIO27', 'UART7_RXD', None, None],  # UART7_RXD
    ["soc/34000000.a55_apb0/34120000.gpio", 388, 15, 22,
        'GPIO22', 'UART2_TXD', None, None],  # UART2_TXD
    ["soc/34000000.a55_apb0/34120000.gpio", 398, 19, 10,
        'SPI_MOSI', 'SPI1_MOSI', None, None],  # SPI1_MOSI/JTG_TDO
    ["soc/34000000.a55_apb0/34120000.gpio", 397, 21, 9,
        'SPI_MISO', 'SPI1_MISO', None, None],  # SPI1_MISO/JTG_TDI
    ["soc/34000000.a55_apb0/34120000.gpio", 395, 23, 11,
        'SPI_SCLK', 'SPI1_SCLK', None, None],  # SPI1_SCLK/JTG_TCK
    ["soc/34000000.a55_apb0/34130000.gpio", 355, 27, 0,
        'ID_SD', 'I2C0_SDA', None, None],  # I2C0_SDA/PWM5
    ["soc/34000000.a55_apb0/34120000.gpio", 399, 29, 5,
        'GPIO5', 'SPI2_SCLK', None, None],  # SPI2_SCLK/PWM0
    ["soc/34000000.a55_apb0/34120000.gpio", 400, 31, 6,
        'GPIO6', 'I2C1_SDA', None, None],  # I2C1_SDA/PWM1
    ["soc/34000000.a55_apb0/34130000.gpio", 357, 33, 13, 'PWM', 'PWM7',
        "soc/34000000.a55_apb0/34170000.pwm", 1],  # PWM7/I2C1_SDA
    ["soc/32080000.dsp_apb/32150000.gpio", 422, 35, 19,
        'PCM_FS', 'I2S1_LRCK', None, None],  # I2S1_LRCK
    ["soc/34000000.a55_apb0/34120000.gpio", 401, 37, 26,
        'GPIO26', 'SPI2_MISO', None, None],  # SPI2_MISO

    ["soc/34000000.a55_apb0/34120000.gpio", 383, 8, 14,
        'TXD', 'UART1_TXD', None, None],  # UART1_TXD
    ["soc/34000000.a55_apb0/34120000.gpio", 384, 10, 15,
        'RXD', 'UART1_RXD', None, None],  # UART1_RXD
    ["soc/32080000.dsp_apb/32150000.gpio", 421, 12, 18,
        'PCM_CLK', 'I2S1_BCLK', None, None],  # I2S1_BCLK
    ["soc/34000000.a55_apb0/34120000.gpio", 382, 16, 23,
        'GPIO23', 'UART6_TXD', None, None],  # UART6_TXD/UART7_RTS
    ["soc/34000000.a55_apb0/34120000.gpio", 402, 18, 24,
        'GPIO24', 'SPI2_MOSI', None, None],  # SPI2_MOSI/PWM3
    ["soc/34000000.a55_apb0/34120000.gpio", 387, 22, 25,
        'GPIO25', 'UART2_RXD', None, None],  # UART2_RXD
    ["soc/34000000.a55_apb0/34120000.gpio", 394, 24, 8,
        'SPI_CSN0', 'SPI1_CSN1', None, None],  # SPI1_CSN1/JTG_TMS
    ["soc/34000000.a55_apb0/34120000.gpio", 396, 26, 7, 'SPI_CSN1',
        'SPI1_CSN0', None, None],  # SPI1_CSN0/JTG_TRSTN
    ["soc/34000000.a55_apb0/34130000.gpio", 354, 28, 1,
        'ID_SC', 'I2C0_SCL', None, None],  # I2C0_SCL/PWM4
    ["soc/34000000.a55_apb0/34130000.gpio", 356, 32, 12, 'PWM', 'PWM6',
        "soc/34000000.a55_apb0/34170000.pwm", 0],  # PWM6/I2C1_SCL/TIME_SYNC1
    ["soc/34000000.a55_apb0/34120000.gpio", 381, 36, 16,
        'GPIO16', 'BIFSD_CLK', None, None],  # UART6_RXD/UART7_CTS
    ["soc/32080000.dsp_apb/32150000.gpio", 423, 38, 20,
        'PCM_DIN', 'I2S1_SDIN', None, None],  # I2S1_SDIN
    ["soc/32080000.dsp_apb/32150000.gpio", 424, 40, 21,
        'PCM_DOUT', 'I2S1_SDOUT', None, None],  # I2S1_SDOUT
]
RDK_S100_30_PIN = [
    ["soc/39500000.gpio", 476, 9, 0, 'GPIO_PERI34', 'PCM0_BLK', None, None],
    ["soc/39500000.gpio", 477, 11, 1, 'GPIO_PERI35', 'PCM0_FSYNC', None, None],
    ["soc/39500000.gpio", 475, 13, 2, 'GPIO_PERI33', 'PCM0_MCLK', None, None],
    ["soc/39500000.gpio", 478, 15, 3, 'GPIO_PERI36', 'PCM0_DATA0', None, None],
    ["soc/39500000.gpio", 479, 17, 4, 'GPIO_PERI37', 'PCM0_DATA1', None, None],
    ["soc/394f0000.gpio", 500, 21, 5, 'GPIO_PERI20', 'SPI0_MISO', None, None],
    ["soc/394f0000.gpio", 499, 23, 6, 'GPIO_PERI19', 'SPI0_MOSI', None, None],
    ["soc/394f0000.gpio", 501, 25, 7, 'GPIO_PERI21', 'SPI0_SCLK', None, None],
    ["soc/394f0000.gpio", 497, 27, 8, 'GPIO_PERI17', 'SPI0_CSN0', None, None],
    ["soc/394f0000.gpio", 498, 29, 9, 'GPIO_PERI18', 'SPI0_CSN1', None, None],

    ["soc/394f0000.gpio", 507, 10, 10, 'GPIO_PERI27', 'UART0_TXD', None, None],
    ["soc/394f0000.gpio", 508, 12, 11, 'GPIO_PERI28', 'UART0_RXD', None, None],
    ["soc/370f5000.gpio", 473, 14, 12, 'GPIO_CAM17', 'I2C4_SDA', None, None],
    ["soc/370f5000.gpio", 472, 16, 13, 'GPIO_CAM16', 'I2C4_SCL', None, None],
    ["soc/394f0000.gpio", 496, 18, 14, 'GPIO_PERI16', 'I2C5_SDA', None, None],
    ["soc/394f0000.gpio", 495, 20, 15, 'GPIO_PERI15', 'I2C5_SCL', None, None],
    ["soc/394f0000.gpio", 505, 24, 16, 'GPIO_PERI25', 'SPI1_MISO', None, None],
    ["soc/394f0000.gpio", 504, 26, 17, 'GPIO_PERI24', 'SPI1_MOSI', None, None],
    ["soc/394f0000.gpio", 506, 28, 18, 'GPIO_PERI26', 'SPI1_SCLK', None, None],
    ["soc/394f0000.gpio", 502, 30, 19, 'GPIO_PERI22', 'SPI1_CSN0', None, None],
]

RDK_S100_40_PIN = [
    ["soc/394f0000.gpio", 496, 3, 2, 'SDA', 'I2C5_SDA', None, None],
    ["soc/394f0000.gpio", 495, 5, 3, 'SCL', 'I2C5_SCL', None, None],
    ["soc/39500000.gpio", 475, 7, 4, 'GPCLK0',      'PCM0_MCLK', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 407, 11, 17,
        'PERI_GPIO', 'PERI_GPIO0', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 408, 13, 27,
        'PERI_GPIO', 'PERI_GPIO1', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 409, 15, 22,
        'PERI_GPIO', 'PERI_GPIO2', None, None],
    ["soc/394f0000.gpio", 499, 19, 10, 'SPI_MOSI', 'SPI0_MOSI', None, None],
    ["soc/394f0000.gpio", 500, 21, 9, 'SPI_MISO', 'SPI0_MISO', None, None],
    ["soc/394f0000.gpio", 501, 23, 11, 'SPI_SCLK', 'SPI0_SCLK', None, None],
    ["soc/370f5000.gpio", 473, 27, 0, 'SDA', 'I2C4_SDA', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 410, 29, 5,
        'PERI_GPIO', 'PERI_GPIO3', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 411, 31, 6,
        'PERI_GPIO', 'PERI_GPIO4', None, None],
    ["soc/370f5000.gpio", 460, 33, 13, 'GPIO_CAM4',
        'LPWM1_DOUT0', "soc/370f1000.lpwm1", 0],
    ["soc/39500000.gpio", 477, 35, 19, 'GPIO_PERI35', 'PCM0_FSYNC', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 412, 37, 26,
        'PERI_GPIO', 'PERI_GPIO5', None, None],

    ["soc/394f0000.gpio", 496, 8,  14, 'SDA', 'I2C5_SDA', None, None],
    ["soc/394f0000.gpio", 495, 10, 15, 'SCL', 'I2C5_SCL', None, None],
    ["soc/39500000.gpio", 476, 12, 18, 'GPCLK0', 'PCM0_BCLK', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 413, 16, 23,
        'PERI_GPIO', 'PERI_GPIO6', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 414, 18, 24,
        'PERI_GPIO', 'PERI_GPIO7', None, None],
    ["soc/39420000.i2c/i2c-0/0-0024", 415, 22, 25,
        'PERI_GPIO', 'PERI_GPIO8', None, None],
    ["soc/394f0000.gpio", 497, 24, 8, 'SPI_CSN', 'SPI0_CS0', None, None],
    ["soc/394f0000.gpio", 498, 26, 7, 'SPI_CSN', 'SPI0_CS1', None, None],
    ["soc/370f5000.gpio", 472, 28, 1, 'SCL', 'I2C4_SCL', None, None],
    ["soc/370f5000.gpio", 461, 32, 12, 'GPIO_CAM5',
        'LPWM1_DOUT1', "soc/370f1000.lpwm1", 1],
    ["soc/39420000.i2c/i2c-0/0-0024", 416, 36, 16,
        'PERI_GPIO', 'PERI_GPIO9', None, None],
    ["soc/39500000.gpio", 478, 38, 20, 'GPIO_PERI36', 'PCM0_DATA0', None, None],
    ["soc/39500000.gpio", 479, 40, 21, 'GPIO_PERI37', 'PCM0_DATA1', None, None],
]

ALL_BOARD_DATA = [
    {'board_name': 'X3SDBV3', 'pin_info': SDBV3_PIN, 'board_id': 0x304},
    {'board_name': 'X3SDB', 'pin_info': SDB_PIN, 'board_id': 0x404},
    {'board_name': 'X3PI', 'pin_info': X3_PI_PIN, 'board_id': 0x504},
    {'board_name': 'X3PI', 'pin_info': X3_PI_PIN, 'board_id': 0x604},
    {'board_name': 'X3CM', 'pin_info': X3_CM_PIN, 'board_id': 0xb04},
    {'board_name': 'X3PI_V2_1', 'pin_info': X3_PI_V2_1_PIN, 'board_id': 0x804},
    {'board_name': 'RDK_X5', 'pin_info': RDK_X5_PIN, 'board_id': 0x301},
    {'board_name': 'RDK_X5', 'pin_info': RDK_X5_PIN, 'board_id': 0x302},
]


class AllInfo(object):
    def __init__(self, gpio_chip_dir, gpio_id, pwm_chip_dir, pwm_id):
        self.gpio_chip_dir = gpio_chip_dir
        self.gpio_id = gpio_id
        self.pwm_chip_dir = pwm_chip_dir
        self.pwm_id = pwm_id


def parse_boardid():
    with open(SYSFS_BOARDID_PATH, 'r') as f:
        sboard_id = f.read()
        if '0x' not in sboard_id:
            sboard_id = "0x" + sboard_id
        iboard_id = int(sboard_id, 16)
        board_id = iboard_id & 0xffff

        return board_id


def if_s100_40pin(board_id):
    last_digit = board_id & 0xF
    if last_digit >= 4 and last_digit <= 7:
        return True
    else:
        return False


def find_s100_pin_data(board_id, pin_data, model, res):
    prefix = board_id >> 8
    if prefix == 0x64 or prefix == 0x6a:
        model = 'RDK_S100'
        res = True
        if if_s100_40pin(board_id):
            pin_data = copy.deepcopy(RDK_S100_40_PIN)
        else:
            pin_data = copy.deepcopy(RDK_S100_30_PIN)
    else:
        res = False
    return pin_data, model, res


def get_all_pin_data():
    if (not os.access(SYSFS_GPIO + '/export', os.W_OK)):
        raise RuntimeError(
            "Insufficient permissions, need root permissions:" + SYSFS_GPIO + '/export')
    if (not os.access(SYSFS_GPIO + '/unexport', os.W_OK)):
        raise RuntimeError("Insufficient permissions, need root permissions")
    if (not os.access(SYSFS_BOARDID_PATH, os.R_OK)):
        raise RuntimeError("Insufficient permissions, need root permissions")
    if (not os.access(SYSFS_BOARDID_PATH, os.R_OK)):
        raise RuntimeError("Insufficient permissions, need root permissions")

    res = False
    pin_data = {}
    model = ""
    compatible_path = '/proc/device-tree/compatible'
    with open(compatible_path, 'r') as f:
        compatibles = f.read().split('\x00')
    board_id = parse_boardid()
    for board_data in ALL_BOARD_DATA:
        if board_data['board_id'] == board_id:
            pin_data = copy.deepcopy(board_data['pin_info'])
            model = board_data['board_name']
            res = True
            break
    if not res:
        pin_data, model, res = find_s100_pin_data(
            board_id, pin_data, model, res)
    if not res:
        raise Exception("Board type is not support")
    # Check GPIO chip dir
    for n, x in enumerate(pin_data):
        if x[0] is None:
            continue
        gpio_chip_name = x[0]
        gpio_chip_dir = SYSFS_PLATFORM_PATH + gpio_chip_name
        gpio_chip_dir = gpio_chip_dir + '/gpio'
        if not os.path.exists(gpio_chip_dir):
            continue
        for f in os.listdir(gpio_chip_dir):
            if not f.startswith('gpiochip'):
                continue
            gpio_chip_dir = gpio_chip_dir + '/' + f
            pin_data[n][0] = gpio_chip_dir
            break
    # Check PWM chip dir
    for n, x in enumerate(pin_data):
        if x[6] is None:
            continue
        pwm_chip_name = x[6]
        pwm_chip_dir = SYSFS_PLATFORM_PATH + pwm_chip_name
        pwm_chip_dir = pwm_chip_dir + '/pwm'
        if not os.path.exists(pwm_chip_dir):
            continue
        for f in os.listdir(pwm_chip_dir):
            if not f.startswith('pwmchip'):
                continue
            pwm_chip_dir = pwm_chip_dir + '/' + f
            pin_data[n][6] = pwm_chip_dir
            break

    def sort_data(pin_name, pin_data):
        return {x[pin_name]: AllInfo(
            x[0],
            x[1],
            x[6],
            x[7]) for x in pin_data}

    all_pin_data = {
        'BOARD': sort_data(2, pin_data),
        'BCM': sort_data(3, pin_data),
        'CVM': sort_data(4, pin_data),
        'SOC': sort_data(1, pin_data),
        'TEGRA_SOC': sort_data(5, pin_data),
    }
    return model, all_pin_data
