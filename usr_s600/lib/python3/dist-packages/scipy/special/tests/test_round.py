import numpy as np
import pytest
import platform

from scipy.special import _test_internal

machine=platform.machine()
if ( machine.startswith('arm') or
     machine=='alpha' or
     machine=='parisc64' ):
    pytest.skip("rounding tests known to fail on armel, alpha and hppa", allow_module_level=True)

@pytest.mark.skipif(not _test_internal.have_fenv(), reason="no fenv()")
def test_add_round_up():
    np.random.seed(1234)
    _test_internal.test_add_round(10**5, 'up')


@pytest.mark.skipif(not _test_internal.have_fenv(), reason="no fenv()")
def test_add_round_down():
    np.random.seed(1234)
    _test_internal.test_add_round(10**5, 'down')
