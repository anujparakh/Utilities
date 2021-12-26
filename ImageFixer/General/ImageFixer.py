import cv2
import numpy as np

def readImage(filename):
    image = cv2.imread(filename, cv2.IMREAD_COLOR)
    print(image)
    # Split the BGR channels
    b_channel, g_channel, r_channel = cv2.split(image)
    # Add alpha channel
    alpha_channel = np.ones(b_channel.shape, dtype=b_channel.dtype) * 255
    image = cv2.merge((b_channel, g_channel, r_channel, alpha_channel))
    return image

def writeImage(imageMatrix, filename):
    cv2.imwrite(filename, imageMatrix)

def removeColor(imageMatrix, toRemove):
    nrows, ncols = imageMatrix.shape [:-1]
    for i in range(0, nrows):
        for j in range(0, ncols):
            # If pixel is matching color, make transparent
            if (imageMatrix[i][j][0:3] == toRemove).all():
                imageMatrix[i][j][3] = 0
    return imageMatrix

def removeEverythingButColor(imageMatrix, toKeep):
    nrows, ncols = imageMatrix.shape [:-1]
    for i in range(0, nrows):
        for j in range(0, ncols):
            # If pixel is not matching color, make transparent
            if (imageMatrix[i][j][0:3] != toKeep).all():
                imageMatrix[i][j][3] = 0
    return imageMatrix

def switchSingleColor(imageMatrix, toChange, newColor):
    nrows, ncols = imageMatrix.shape [:-1]
    for i in range(0, nrows):
        for j in range(0, ncols):
            # If pixel is matching color, change it
            if (imageMatrix[i][j][0:3] == toChange).all():
                imageMatrix[i][j][0:3] = newColor
    return imageMatrix


# ---------------------------------
# ----------- Main Code -----------
# ---------------------------------

# Input the file
inputImageName = input('Enter image name: ')
imageMatrix = readImage(inputImageName)

# Output name
outputImageName = input('Enter output name: ')
outputFolder = "Output/"
outputType = ".png"

# Input type of fixing
fixingType = int(input('Choose type of fix\n'
                 + '1. Remove single color\n'
                 + '2. Keep single color\n'
                 + '3. Switch only one color\n'
                 + 'Enter choice: '
                 ))


if fixingType == 1: # Remove a single color
    toRemove = [int(item) for item in input("Enter color to remove as B G R values: : ").split()]
    imageMatrix = removeColor(imageMatrix, toRemove)

elif fixingType == 2: # Keep a single color
    toKeep = [int(item) for item in input("Enter color to keep as B G R values: : ").split()]
    removeEverythingButColor(imageMatrix, toKeep)

elif fixingType == 3: # Switch only one color
    toChange = [int(item) for item in input("Enter color to change as B G R values: : ").split()]
    newColor = [int(item) for item in input("Enter new color as B G R values: : ").split()]
    switchSingleColor(imageMatrix, toChange, newColor)

writeImage(imageMatrix, outputFolder + outputImageName + outputType)