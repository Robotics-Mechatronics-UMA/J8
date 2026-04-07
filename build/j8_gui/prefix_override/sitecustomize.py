import sys
if sys.prefix == '/usr':
    sys.real_prefix = sys.prefix
    sys.prefix = sys.exec_prefix = '/home/rhobtor/PHD/test_j8_hayat/J8/install/j8_gui'
