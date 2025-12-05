with open("day_1.txt", "r") as file:
    lines = file.readlines()

zero_count = 0
zero_count_2 = 0
start = 50
for line in lines:
    direction = line[0]
    number = int(line[1:])
    if direction == "L":
        diff = start - number
        zero_count_2 += abs(diff) // 100

        if diff <= 0 and start != 0:
            zero_count_2 += 1
        start = diff % 100
    else:
        diff = start + number
        start = diff % 100
        zero_count_2 += diff // 100
    if start == 0:
        zero_count += 1

print(zero_count)
print(zero_count_2)
