# -*- coding: UTF-8 -*-

import random


class Instruction:
    'Instruction Block object, generate a list and shuffles it after generation'

    randomReplace = "{random}"
    randomNegReplace = "{randomNeg}"
    maxRegs = 32
    excludeZero = 1
    generatedInstruction = []

    def __init__(self, string, excludeZero=0):
        self.generatedInstruction.append(string.strip())
        self.excludeZero = excludeZero
        self.expand()

    def expand(self):
        for i in range(9):
            strToReplace = "{REGNAME" + str(i) + "}"
            tmpList = []
            for item in self.generatedInstruction:
                if item.find(strToReplace) != -1:
                    for i in range(self.excludeZero, self.maxRegs):
                        res = item.replace(strToReplace, str(i))
                        tmpList.append(res)
                else:
                    tmpList.append(item)
            random.shuffle(tmpList)
            self.generatedInstruction = tmpList

        tmpList = []
        for item in self.generatedInstruction:
            tmpStr = item
            while tmpStr.find(self.randomNegReplace) != -1:
                tmpStr = tmpStr.replace(self.randomNegReplace, str(random.randint(-32768, 32767)), 1)
            while tmpStr.find(self.randomReplace) != -1:
                tmpStr = tmpStr.replace(self.randomReplace, str(random.randint(0, 65535)), 1)
            tmpList.append(tmpStr)
        self.generatedInstruction = tmpList

def main():
    print("Usage: {REGNAME[0-9]} will be expanded to a number between 0 - 31, each creating a new instruction.")
    print("Usage: {random} will be expanded to a number between 0 - 65535")
    print("Usage: {REGNAME[0-9]} will be expanded to a number between (-32768) - 32767")
    print("Example: ori ${REGNAME0}, $0, {random}")
    raw = input()
    instr = Instruction(raw)
    for item in instr.generatedInstruction:
        print(item)

if __name__ == "__main__":
    main()
