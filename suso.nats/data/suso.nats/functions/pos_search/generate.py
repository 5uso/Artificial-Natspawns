for i in range(32):
    start = 0
    end = 32
    path = "s"
    for s in range(5):
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
           f.write('execute positioned ^ ^ ^{} align xyz positioned ~.5 ~ ~.5 run function suso.nats:try'.format(24.0 + 3 * (i + 1)))