import cv2
import numpy as np


def mamaPhotos():
    imageName = 'img.jpeg'
    imgMatrix = cv2.imread(imageName, cv2.IMREAD_GRAYSCALE)
    copyImg = cv2.imread(imageName, cv2.IMREAD_GRAYSCALE)

    colors = [0, 20, 40, 60, 80, 100, 150, 200]
    threshold = 210

    imgMatrix [imgMatrix > threshold] = 255

    width, length = imgMatrix.shape
    print(width)
    print(length)

    # 2174, 660
    # -420, -920

    for color in colors:
        imgMatrix [copyImg < threshold] = color
        imgMatrix[:, :695] = 255
        imgMatrix[:, -420:] = 255
        imgMatrix[:660, :] = 255
        imgMatrix[-920:, :] = 255
        cv2.imwrite('result' + str(color) + '.jpeg', imgMatrix)

def droplet():
    imageName = 'droplet.png'
    imgMatrix = cv2.imread(imageName, cv2.IMREAD_UNCHANGED)

    imgMatrix [imgMatrix[:, :, 2] == 255] = [0, 0, 0, 0]

    imgMatrix [imgMatrix[:, :, 3] != 0] = [195, 99, 0, 255]

    cv2.imwrite('droplet_result.png', imgMatrix)

def gloveIcon():
    imageName = 'gloves-icon.png'
    imgMatrix = cv2.imread(imageName, cv2.IMREAD_UNCHANGED)
    imgMatrix [imgMatrix[:, :, 3] != 255] = [0, 0, 0, 0]
    # imgMatrix [imgMatrix[:, :, 3] != 0] = [195, 99, 0, 255]

    cv2.imwrite('result.png', imgMatrix)

gloveIcon()
