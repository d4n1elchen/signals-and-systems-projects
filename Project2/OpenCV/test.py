from cv2 import *
from time import sleep
import sys, os

if len(sys.argv) < 2:
    print("usage: "+sys.argv[0]+" <Modelfile>")
    exit(1)

model_file = sys.argv[1]
model = createLBPHFaceRecognizer()
model.load(model_file)

cam = VideoCapture(0)

while True:
    s, img = cam.read()
    imshow('camera', img)

    label = model.predict(cvtColor(img, COLOR_BGR2GRAY))
    print(label)

    if waitKey(1)&0xFF == ord('q'):
        break

cam.release()
