import requests
import time
import subprocess as sp

start_time = 0 
running_instances = {}
errCount = 0
reqCount = 0

def printStatus(hostname,version):
    global running_instances
    global start_time, errCount, reqCount

    elapsed_time = int(time.time() - start_time)

    # if (elapsed_time % 2) == 0 :
    string_to_print = "\n"
    for x in running_instances:
        string_to_print += "\tVersion: " + x + ", Instances: " + str(len(running_instances[x])) + "\n"
    sp.call('clear',shell=True)
    print(f"Instances seen in past {elapsed_time} seconds ", string_to_print + "Requests: " + str(reqCount) + ", Errors: " + str(errCount))

    if elapsed_time >=30:
        start_time = time.time()
        running_instances = {}
        errCount = 0
        reqCount = 0
    
    if running_instances and version in running_instances:
        if not hostname in running_instances[version]:
            running_instances[version].append(hostname)
    else:
        running_instances[version] = [hostname]
        
    


def main():
    URL = "http://10.104.84.249"
    global start_time, errCount, reqCount
    start_time = time.time()

    while True:
        try:
            res = requests.get(url = URL)
            data = res.json()
            printStatus(data["os"]["name"],data["version"])
            reqCount+=1
        except:
            errCount+=1

        time.sleep(0.005)

if __name__ == '__main__':
    main()