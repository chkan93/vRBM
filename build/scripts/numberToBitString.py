def toHex(num):
    s = hex(num).split('x')[1]
    if num >= 0:
        return s
    else:
        return '-' + s
