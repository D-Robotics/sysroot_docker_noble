# Import the sipconfig.py for the correct python3 version and normal or debug
# build.

import sys

if sys.version_info[1] == 12:
    from sipconfig_nd12 import *
    from sipconfig_nd12 import _pkg_config, _default_macros

