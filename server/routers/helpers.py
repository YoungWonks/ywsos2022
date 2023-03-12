import random
import string

def hexCode():
    letter_library = list(string.ascii_letters)
    final_hex = ''
    user_hex = random.sample(letter_library, counts=None, k=6)
    for chars in user_hex:
        final_hex += chars
    return final_hex

def passwordCheck(password):
    special_characters = "!@#$%^&*()-+?_=,<>/"
    if len(password) > 3:
        if any(c in special_characters for c in password):
            return True
        else:
            return False
    else:
        return False