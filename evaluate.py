import sys

def evaluate(conll_file):
    total = 0.0
    correct = 0.0
    for line in open(conll_file):
        if line.strip():
            items = line.split('\t')
            total += 1
            if items[6] == items[8]:
                correct += 1
    print 'accuracy: %6.2f%%' % (100 * correct/total)

if __name__ == '__main__':
    evaluate(sys.argv[1])