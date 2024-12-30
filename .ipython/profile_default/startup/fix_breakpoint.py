import sys

# Work around [1], as suggested in [2].
#
# 1: https://github.com/ipython/ipykernel/issues/897
# 2: https://github.com/chmp/ipytest/issues/80#issuecomment-1236058679
sys.breakpointhook = sys.__breakpointhook__
