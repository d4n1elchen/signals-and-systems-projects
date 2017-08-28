from cv2 import *
import io
import os

# Imports the Google Cloud client library
from google.cloud import vision

# Instantiates a client
vision_client = vision.Client('application-default')

# The name of the image file to annotate
# file_name = os.path.join(
#     os.path.dirname(__file__),
#     'wakeupcat.jpg')
cam = VideoCapture(0)
s, img = cam.read()
imwrite("camera.jpg", img);
# print type(img)

# Loads the image into memory
# with io.open(file_name, 'rb') as image_file:
#     content = image_file.read()
#     image = vision_client.image(
#         content=content)
    # print type(content)
content = imencode('.jpg', img)[1].tostring();
image = vision_client.image(content=content);

# Performs label detection on the image file
labels = image.detect_labels()

print('Labels:')
for label in labels:
    print(label.description)
