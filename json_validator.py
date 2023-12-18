
import sys
from glob import glob
from os import environ
from json import load, decoder

MY_PATH = environ.get('PWD')
JSON_FILES_PATH = glob(MY_PATH + '/**/*.json', recursive=True)
JSON_LOAD_ERRORS = 0

for json_file_path in JSON_FILES_PATH:
    json_file_relative_path = json_file_path.replace(MY_PATH, '')
    print(f'Validating file: {json_file_relative_path}')
    try:
        with open(json_file_path, 'r', encoding="utf-8") as json_file:
            load(json_file)
    except decoder.JSONDecodeError as error:
        print(error)
        JSON_LOAD_ERRORS += 1

sys.exit(JSON_LOAD_ERRORS)
