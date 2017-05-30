from cv2 import *
import csv
import sys
import numpy as np

def norm_0_255(_src):
    src = _src.getMat()

def read_csv(filename, separator=';'):
    with open(filename, 'rb') as csvfile:
        lines = csv.reader(csvfile, delimiter=separator)
        images = []
        labels = []
        for line in lines:
            images.append(imread(line[0], 0))
            labels.append(int(line[1]))
        return images, labels

if __name__ == '__main__':

    if len(sys.argv) < 2:
        print("usage: "+argv[0]+" <csv.ext> <output_folder> ")
        exit(1)

    output_folder = "."
    if len(sys.argv) == 3:
        output_folder = sys.argv[2]

    fn_csv = sys.argv[1]
    images, labels = read_csv(fn_csv)

    if len(images) <= 1:
        raise Exception("This demo needs at least 2 images to work. Please add more images to your data set!")

    height = images[0].shape[0]
    testSample = images.pop(20)
    testLabel = labels.pop(20)

    model = createLBPHFaceRecognizer()
    model.train(np.array(images), np.array(labels))

    predictedLabel = model.predict(testSample)

    print("Predicted class = {} / Actual class = {}.".format(predictedLabel, testLabel))

    model.save("model.yml")
