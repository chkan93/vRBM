def toHex(num):
    s = hex(num).split('x')[1]
    if num >= 0:
        return s
    else:
        return '-' + s

def binToHex(s):
    # print s
    return '%0*X' % ((len(s) + 3) // 4, int(s, 2))

def toBin(num, bits=12):
    sign = "0"
    if num < 0:
        sign = "1"
    num = abs(num)
    nc_list = list(bin(num))[2:]
    nc_list = patchToDim(nc_list, bits=bits-1)
    if sign == "1":
        nc_list = negateBin(nc_list)

    nc_list = [sign] + nc_list
    if sign == "1":
        nc_list = addOne(nc_list)
    return "".join(nc_list)



def patchToDim(list, bits=11):
    lst = ["0"] * (bits - len(list))
    return lst + list


def negateBin(lst):
    return ["1" if l == "0" else "0" for l in lst]

def addOne(lst):
    c = "1"
    r = []
    for i in reversed(lst):
        if c == "1" and i == "1":
            r.insert(0, "0")
        elif (c == "1" and i =="0") or (c == "0" and i == "1"):
            c = "0"
            r.insert(0, "1")
        elif c == "0" and i == "0":
            c = "0"
            r.insert(0, "0")
    return r



# x = toBin(-124)
# print x;
# print binToHex(x)