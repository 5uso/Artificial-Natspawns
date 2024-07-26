# Configure up here
BITS     = 5
MIN_DIST = 27
MAX_DIST = 120
#------------------

_AMOUNT = pow(2, BITS)
_STEP = (MAX_DIST - MIN_DIST) / (_AMOUNT - 1)

for i in range(_AMOUNT):
    start = 0
    end = _AMOUNT
    path = "s"
    for s in range(BITS):
        mid = (start + end) / 2
        with open('./{}.mcfunction'.format(path), "w") as f:
           f.write('execute if score $s suso.nats matches ..{} run function suso.nats:pos_search/{}0\n'.format(int(mid - 1), path))
           f.write('execute if score $s suso.nats matches {}.. run function suso.nats:pos_search/{}1\n'.format(int(mid), path))
        if i < mid:
            end = mid
            path += "0"
        else:
            start = mid
            path += "1"
    print(path)
    with open('./{}.mcfunction'.format(path), "w") as f:
           f.write('execute positioned ^ ^ ^{} align xyz positioned ~.5 ~ ~.5 run function suso.nats:try'.format(MIN_DIST + _STEP * i))