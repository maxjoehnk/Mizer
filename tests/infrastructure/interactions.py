import cv2
import numpy as np
import pyautogui
import pytesseract
from pytesseract import Output

ocr_lang = 'eng'
app_region = (1920, 0, 1920, 1080)


def move_to_center():
    pyautogui.moveTo(app_region[0] + app_region[2] / 2,
                     app_region[1] + app_region[3] / 2)


def click_on_text(text: str):
    # FIXME: search for multiple words
    text = text.split(' ')[0]
    (x, y) = find_coordinates_text(text)
    pyautogui.click(x + app_region[0], y + app_region[1])


def find_coordinates_text(text: str):
    print(f"Looking for {text}")
    screenshot = pyautogui.screenshot(region=app_region)

    img = np.array(screenshot)

    data = pytesseract.image_to_data(img, config='--psm 12', lang=ocr_lang, output_type=Output.DATAFRAME)

    # Find the coordinates of the provided text (text)
    try:
        left = data[data['text'] == text]['left'].iloc[0]
        top = data[data['text'] == text]['top'].iloc[0]
        width = data[data['text'] == text]['width'].iloc[0]
        height = data[data['text'] == text]['height'].iloc[0]

        x, y = left + width // 2, top + height // 2

    except IndexError:
        # The text was not found on the screen
        print(data)
        n_boxes = len(data['level'])
        for i in range(n_boxes):
            (x, y, w, h) = (data['left'][i], data['top'][i], data['width'][i], data['height'][i])
            cv2.rectangle(img, (x, y), (x + w, y + h), (0, 0, 255), 2)

        cv2.imwrite(f'screenshot_{text}.png', img)
        return None

    return x, y


def take_screenshot(file: str):
    img = pyautogui.screenshot(region=app_region)
    img.save(file)
