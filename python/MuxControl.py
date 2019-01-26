import serial
import sys
import time

def readData(recOn):
    rec=recOn
    out = ''
    if (mymbed.readable()):
        out += mymbed.readline()
    # while mymbed.inWaiting() > 0:
    #     out += mymbed.read(1)
    #     print ">>" + out
    return out

def sendData(mux1, mux2,mux3):
    print('Sending Data')
    mymbed.write(bytearray([mux1,mux2,mux3]))

cmdargs = (sys.argv)
#print cmdargs

if len(cmdargs) != 5:
    print "Error: Wrong number of arguments. \r\nArgument format: [port#, Channel, mu3channel] \r\nNow Exiting"
    #print (cmdargs)
    sys.exit()

port= (cmdargs[1])
#port=float(port)
mux1ch=cmdargs[2]
mux2ch=cmdargs[3]
mux3ch=cmdargs[4]

# print type(mux3ch)
# print(int(mux1ch)|8)
# mux1ch=str((int(mux1ch))|8)
# mux2ch=str((int(mux1ch))|8)
# mux3ch=str((int(mux1ch))|8)
# print 'here is mux1chn '  + mux1ch
# print type(mux1ch)
# print (bytearray([mux1ch,mux2ch,mux3ch]))

baudrate = 460800

try:
    mymbed=serial.Serial(port,baudrate, timeout=1)
    sendData(mux1ch, mux2ch,mux3ch)
    #mymbed.write('0123456')
    # mymbed.write('1')
    # mymbed.write('2')
    # mymbed.write('3')


    a=readData(1)
    print(a)
    time.sleep(.01)
    print readData(1)
    time.sleep(.01)
    print readData(1)

    mymbed.close()
except:
    print "Failed to connect! \r\n"

print('done')