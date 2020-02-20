# -*- coding: UTF-8 -*-

import os
import difflib

def stripFile(fileName):
    fd = open(fileName, mode = "r")
    lines = fd.readlines()
    stripedLines = []

    for line in lines:
        if (line.find("<=") != -1) & (line.startswith("@")) & (line.find("$ 0") == -1):
            stripedLines.append(line)
    
    fd.close()
    return stripedLines

def checkDiff(asmFilename, marsRes, verilogRes):
    diff = difflib.SequenceMatcher(a = marsRes, b = verilogRes, autojunk= False)
    diff_ratio = diff.ratio()
    if diff_ratio != 1.0 :
        reporter = difflib.HtmlDiff()
        report = reporter.make_file(fromlines = marsRes, tolines = verilogRes, fromdesc='marsResult', todesc='verilogResult')
        print("Differnt in " + asmFilename + "! Diff ratio is " + str(diff_ratio))
        fd = open("report_" + asmFilename.replace(".", "_") + ".html", "w")
        fd.writelines(report)
        print("Generated html report\n")
        fd.close
    else:
        print("Success in <" + asmFilename + ">!\n")

def runTest(asmList):
    for asmFile in asmList:
        print("Judging <" + asmFile + "> ... ")
        # mars result
        if os.path.exists("code.txt"):
            os.system("del code.txt")
        os.system("java -jar Mars.jar 1000000 nc mc  CompactDataAtZero dump .text HexText code.txt " + asmFile + " > marsResult")
        #os.system("pause")
        os.system("iverilog -o testbench.vvp .\\*.v")
        os.system("vvp testbench.vvp > verilogResult")
        marsRes = stripFile("marsResult")
        verilogRes = stripFile("verilogResult")

        checkDiff(asmFile, marsRes, verilogRes)

    return

def main():
    asmList = []

    for file in os.listdir():
        if file.endswith(".asm"):
            asmList.append(file)
    
    print("Below are files to be checked:")
    print(asmList)

    os.system("pause")

    runTest(asmList)
    os.system("del code.txt testbench.vvp marsResult verilogResult")

if (__name__ == "__main__"):
    main()
