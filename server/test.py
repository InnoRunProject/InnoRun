from os import walk

data = {}
var = [x for x in walk('../server/sessions')][0][2]
# print(var[0][2])
for session in var:
    print(session)
