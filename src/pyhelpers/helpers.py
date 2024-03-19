import pyautogui as py
import yaml
import random
import os

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
