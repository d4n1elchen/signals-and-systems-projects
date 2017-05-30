from cv2 import *
from time import sleep
import sys, os

if len(sys.argv) < 2:
    print("usage: "+sys.argv[0]+" <Name>")
    exit(1)

save_dir = sys.argv[1]
cam = VideoCapture(1)

while True:
    s, img = cam.read()
    imshow('camera', img)

    if waitKey(1)&0xFF == ord('s'):
        break

if not os.path.exists(save_dir):
    os.makedirs(save_dir)

for i in range(10):
    s, img = cam.read()
    imshow('camera', img)
    imwrite(save_dir+'/'+str(i+1)+'.jpg', img)
    waitKey(1000)

cam.release()
