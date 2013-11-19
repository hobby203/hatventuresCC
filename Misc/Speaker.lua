s = peripheral.wrap("speaker_1")
print("What would you like to say?")
input = read()
s.speak(input)
