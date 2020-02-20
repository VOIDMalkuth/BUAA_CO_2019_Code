#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define INSTR_NOP 0
#define INSTR_R_3OP 1
#define INSTR_MUL_2OP 2
#define INSTR_1OP 3
#define INSTR_I_UNSIGNED 4
#define INSTR_I_SIGNED 5
#define INSTR_I_SHIFT 6
#define INSTR_LOAD 7
#define INSTR_SAVE 8
#define INSTR_BRANCH 9
#define INSTR_LUI 10
#define INSTR_JAL 11
#define INSTR_JR 12
#define INSTR_J 13

// no JR so far, hard to do

const int maxInstructionCount = 1000;

int instrRatioRand(void){
    int randVal = rand() % 200;
    
    if(randVal < 60)
        return INSTR_R_3OP;
    else if(randVal < 75)
        return INSTR_MUL_2OP;
    else if(randVal < 90)
        return INSTR_1OP;
    else if(randVal < 110)
        return INSTR_I_UNSIGNED;
    else if(randVal < 135)
        return INSTR_I_SIGNED;
    else if(randVal < 150)
        return INSTR_LOAD;
    else if(randVal < 170)
        return INSTR_SAVE;
    else if(randVal < 185)
        return INSTR_BRANCH;
    else if(randVal < 195)
        return INSTR_LUI;
    else if(randVal < 198)
        return INSTR_JAL;
    /* else if(randVal < 115)
        return INSTR_JR; */
    else    // == 198
        return INSTR_J;
}

// 0 , 2 - 5, 31 , 6 registers, more hazard
int rand0Up(void){
    int randVal = rand() % 9;
    if(randVal < 4)
        return 0;
    else if(randVal == 8)
        return 31;
    else
        return randVal - 2;
}

int rand0Down(void){
    int randVal = rand() % 16;
    if(randVal == 0)
        return 0;
    else if(randVal >= 13 && randVal < 16 )
        return 31;
    else
        return (randVal + 2)/3 + 1; // 2 3 4 5
}

int randRegNormal(void){
    int tmp = rand() % 5;
    int reg = (tmp == 4) ? 31 : ((tmp == 0) ? 0 : (tmp + 1));

    return reg;
}

// Instructions here
void nop(int total){
    printf("L%d: nop\n", total);
}

void three_cal(int total, char * mnemonic){
    int dest = rand0Down();
    int src1 = randRegNormal();
    int src2 = randRegNormal();
    printf("L%d: %s $%d, $%d, $%d\n", total, mnemonic, dest, src1, src2);
}
void two_cal(int total, char * mnemonic){
    int dest = rand0Down();
    int src1 = randRegNormal();
    printf("L%d: %s $%d, $%d\n", total, mnemonic, dest, src1);
}

void one_cal(int total, char * mnemonic){
    int dest = rand0Down();
    printf("L%d: %s $%d\n", total, mnemonic, dest);
}

void twoOpOneImm_signed(int total, char * mnemonic, int isSigned){
    int dest = rand0Down();
    int src1 = rand0Down();
    int imm = 0;
    if(isSigned){
        imm = rand() % (65536 / 2 - 1);
        imm = (rand() % 2 == 0) ? imm : -imm;
    }else{
        imm = (rand() + rand()) % 65536;
    }
    printf("L%d: %s $%d, $%d, %d\n", total, mnemonic, dest, src1, imm);
}

// no add and no sub to avoid overflow
char r_3ins[11][10] = {"addu", "subu", "sllv", "srlv", "srav", "and", "or", "xor", "nor", "slt", "sltu"};
void r_type_3op(int total){
    int op = rand() % 11;
    three_cal(total, r_3ins[op]);
}

char r_2ins[4][10] = {"mult", "multu", "div", "divu"};
void mul_2op(int total){
    int op = rand() % 4;
    if(op == 0 || op == 1)
        two_cal(total, r_2ins[op]);
    else{
        printf("L%d: %s $%d, $sp\n", total, r_2ins[op], rand0Down());
    }
}

char r_1ins[4][10] = {"mfhi", "mflo", "mthi", "mtlo"};
void signleOp(int total){
    int op = rand() % 4;
    one_cal(total, r_1ins[op]);
}

char r_2op1immsigned[3][10] = {"addiu", "slti", "sltiu"}; // addi may overflow
void iSigned(int total){
    int op = rand() % 3;
    twoOpOneImm_signed(total, r_2op1immsigned[op], 1);
}

char r_2op1immUnsigned[3][10] = {"andi", "ori", "xori"};
void iUnsigned(int total){
    int op = rand() % 3;
    twoOpOneImm_signed(total, r_2op1immUnsigned[op], 0);
}

char r_shift[3][10] = {"sll", "sra", "srl"};
void iShift(int total){
    int op = rand() % 3;
    int shamt = rand() % 32;
    int src = rand0Down();
    int dst = rand0Down();
    printf("L%d: %s $%d, $%d, %d\n", total, r_shift[op], dst, src, shamt);
}

void lui(int total){
    // randMax is 0x7fff
    printf("L%d: lui $%d, %d\n", total, rand0Down(), (rand() + rand())%65536);
}

void load(int total){
    int rawRand = rand() % 2048;
    int randWord = (rawRand % 2048 < 512) ? 0 : ((rawRand % 2048 >= 1536)?1023: (rawRand - 512));
    int randAddr = randWord << 2;
    char mnemonic[10] = "lw";
    int type = rand() % 5;

    if(type == 0){
        ; // lw, do nothing
    }else if(type == 1){
        mnemonic[1] = 'h';
        mnemonic[2] = '\0';
        randAddr += (rand() % 2 == 0) ? 2 : 0;
    }
    else if(type == 2){
        mnemonic[1] = 'b';
        mnemonic[2] = '\0';
        randAddr += rand() % 4;
    }else if(type == 3){
        mnemonic[1] = 'h';
        mnemonic[2] = 'u';
        mnemonic[3] = '\0';
        randAddr += (rand() % 2 == 0) ? 2 : 0;
    }else if(type == 4){
        mnemonic[1] = 'b';
        mnemonic[2] = 'u';
        mnemonic[3] = '\0';
        randAddr += rand() % 4;
    }

    printf("L%d: %s $%d, 0x%x($0)\n", total, mnemonic, rand0Down(), randAddr);
}

void save(int total){
    int rawRand = rand() % 2048;
    int randWord = (rawRand % 2048 < 512) ? 0 : ((rawRand % 2048 >= 1536)?1023: (rawRand - 512));
    int randAddr = randWord << 2;
    int type = rand() % 5;
    char mnemonic[10] = "sw";

    if(type == 0){
        ; // lw, do nothing
    }else if(type == 1){
        mnemonic[1] = 'h';
        mnemonic[2] = '\0';
        randAddr += (rand() % 2 == 0) ? 2 : 0;
    }
    else if(type == 2){
        mnemonic[1] = 'b';
        mnemonic[2] = '\0';
        randAddr += rand() % 4;
    }

    printf("L%d: %s $%d, %d($0)\n", total, mnemonic, rand0Down(), randAddr);
}

char b_ins[6][10] = {"beq", "bne", "blez", "bgtz", "bltz", "bgez"};
void branches(int total){
    int randJump = rand() % 5 + 1;
    int label = ((total + randJump) < 999) ? (total + randJump) : 1001;
    int op = rand() % 6;
    if(op == 0 || op == 1){
        if(rand()%2)
            printf("L%d: %s $%d, $%d, L%d\n", total, b_ins[op], (rand()%2)?rand0Up():(rand()%3 + 10), (rand()%3 + 10), label);
        else
            printf("L%d: %s $%d, $%d, L%d\n", total, b_ins[op], (rand()%3 + 10), (rand()%2)?rand0Up():(rand()%3 + 10), label);
    }else{
        printf("L%d: %s $%d, L%d\n", total, b_ins[op], randRegNormal(), label);
    }
}

void jal(int total){
    int randJump = rand() % 5 + 1;
    int label = ((total + randJump) < 999) ? (total + randJump) : 1001;
    printf("L%d: jal L%d\n", total, label);
}

void j(int total){
    int randJump = rand() % 5 + 1;
    int label = ((total + randJump) < 999) ? (total + randJump) : 1001;
    printf("L%d: j L%d\n", total, label);
}

int main(void){
    srand((unsigned)time(NULL));

    int isLastInstrJump = 0;
    int total = 0;

    printf("INTI0: li $gp, 0x1800\n");
    printf("INTI1: li $sp, 0x2fff\n");
    printf("INTI2: li $10, 13\n");
    printf("INTI3: li $11, 0\n");
    printf("INTI4: li $12, -12\n");

    do {
        switch(instrRatioRand()){
            case INSTR_R_3OP:
                r_type_3op(total);
                isLastInstrJump = 0;
                break;

            case INSTR_MUL_2OP:
                mul_2op(total);
                isLastInstrJump = 0;
                break;

            case INSTR_1OP:
                signleOp(total);
                isLastInstrJump = 0;
                break;

            case INSTR_I_UNSIGNED:
                iUnsigned(total);
                isLastInstrJump = 0;
                break;

            case INSTR_I_SIGNED:
                iSigned(total);
                isLastInstrJump = 0;
                break;

            case INSTR_I_SHIFT:
                iShift(total);
                isLastInstrJump = 0;
                break;

            case INSTR_LOAD:
                load(total);
                isLastInstrJump = 0;
                break;

            case INSTR_SAVE:
                save(total);
                isLastInstrJump = 0;
                break;

            case INSTR_BRANCH:
                if(isLastInstrJump)
                    total--;
                else
                    branches(total);
                    isLastInstrJump = 1;
                break;

            case INSTR_LUI:
                lui(total);
                isLastInstrJump = 0;
                break;

            case INSTR_JAL:
                if(isLastInstrJump)
                    total--;
                else
                    jal(total);
                    isLastInstrJump = 1;
                break;

            case INSTR_J:
                if(isLastInstrJump)
                    total--;
                else
                    j(total);
                    isLastInstrJump = 1;
                break;

            default:
                nop(total);
        }
        
    } while (total++ < maxInstructionCount);

    printf("L1001: nop\n");
    printf("Exit: nop\n");
}