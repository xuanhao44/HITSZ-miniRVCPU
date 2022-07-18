from os import listdir
from os import system
from os.path import isfile, join
tb = [f for f in listdir("bin") if isfile(join("bin", f))]
success = []
fail = []
for t in tb:
    t = t.split('.')[0]
    print("\n\n==================== Testing %s ====================" % t) 
    cmd = "make run_for_python TEST="+t
    result = system(cmd)
    if result == 0:
        success.append(t)
    else:
        fail.append(t)
    print("==================== %s END ==================== " % t)

print("\n\n==================== SUMMARY ==================== ")
print("Passed Tests:")
print(", ".join(success))
print("Failed Tests:")
print(", ".join(fail))
