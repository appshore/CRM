# server_version.py - retrieve and display database server version

import MySQLdb

conn = MySQLdb.connect (host = "localhost",
                        user = "root",
                        passwd = "root",
                        db = "appshore_backoffice")
cursor = conn.cursor ()
cursor.execute ("SELECT VERSION()")
row = cursor.fetchone ()
print "server version:", row[0]
cursor.close ()
conn.close ()

FILES = ["log.txt"]

# Get the Data
for file in FILES:
    infile = open(file,"r")
    while infile:
        line = infile.readline()
        logDate, tmp1 = line.split("server3 postfix/")
        logProcess, tmp2 = tmp1.split("[",1)        
        tmp1, logId, logMsg = tmp2.split(" ",2)
        if logProcess == "bounce" :
        	tmp1, logNotificationMsgId = logMsg.split(": ")
        elif logProcess == "cleanup" :
        	tmp1, tmp2 = logMsg.split("<")
        	logMsgId, tmp1 = tmp2.split(">")
        elif logProcess == "qmgr" :
        elif logProcess == "smtp" :
        else:
        	print logDate, logProcess, logId[:10], logMsg
#       	print logDate, logProcess, logId[:10], logMsg
#        s = line.split()
#        n = len(s)

