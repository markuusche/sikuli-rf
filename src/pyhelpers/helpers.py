import pyautogui as py
import pytesseract
import yaml
import random
import os

deviceName = os.environ['USERPROFILE'].split(os.path.sep)[-1]
path = f'C:\\Users\\{deviceName}\\AppData\\Local\\Programs\\Tesseract-OCR\\tesseract.exe'
pytesseract.pytesseract.tesseract_cmd = path

def data(*keys):
    with open('resources/config.yaml','r') as file:
        getData = yaml.load(file, Loader=yaml.FullLoader)

    for key in keys:
        getData = getData[key]

    return getData

def bet_on_region():
    regions = data('InGame', 'baccarat')
    coor = []
    for i in regions.values():
        coor.append(i)
    
    for i in range(20):
        choices = random.choice(coor)
        py.click(py.center(choices))

        if i == 10:
            break

def wait_until_message(value):
    while True:
        region = (741,364,437,72)
        screenshot = py.screenshot(region=region)
        gray = screenshot.convert('L')
        getText = pytesseract.image_to_string(gray)
        if value in getText:
            return True
        else:
            continue