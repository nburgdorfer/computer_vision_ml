import csv
import numpy as np
import sys

def main():
    if (len(sys.argv) != 2):
        print("ERROR: Usage {} <file-name>".format(sys.argv[0]))
        sys.exit()

    inputfile = sys.argv[1]
    with open(inputfile) as csvfile:

        rows = csv.reader(csvfile, delimiter=",")
        
        # format csv info into -> (algo_name, bad2.0, avgerr)
        data = []
        points = []
        elem = ()
        for row in rows:
            data.append((row[0], float(row[1]), float(row[2])))
            points.append((float(row[1]),float(row[2])))

        final = []
        for (name,dat2,avgerr) in data:
            smaller = list(filter(lambda p: p[0] < dat2 and p[1] < avgerr, points))

            if (len(smaller) == 0):
                final.append((name,dat2,avgerr))

        print(final)


if __name__ == "__main__":
    main()
