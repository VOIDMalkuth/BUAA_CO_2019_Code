L0: subu $3, $3, $1
L1: addu $31, $0, $1
L2: lw $3, 0($0)
L3: beq $0, $3, L64
L4: subu $3, $1, $3
L5: subu $2, $31, $0
L6: ori $1, $31, 35808
L7: sw $2, 0($0)
L8: subu $31, $31, $3
L9: ori $1, $2, 33658
L10: subu $31, $2, $1
L11: lui $2, 21239
L12: subu $31, $1, $2
L13: ori $1, $31, 17151
L14: subu $0, $2, $0
L15: jal L79
L16: ori $1, $1, 37056
L17: beq $0, $0, L49
L18: sw $2, 3760($0)
L19: lw $2, 4020($0)
L20: sw $31, 2804($0)
L21: j L22
L22: sw $1, 3748($0)
L23: lui $1, 50610
L24: lui $31, 43977
L25: lui $1, 55024
L26: j L63
L27: sw $3, 3984($0)
L28: subu $3, $3, $0
L29: j L85
L30: sw $3, 0($0)
L31: subu $3, $31, $0
L32: lui $31, 32519
L33: ori $3, $1, 38407
L34: lui $3, 17555
L35: subu $2, $31, $2
L36: sw $2, 784($0)
L37: j L54
L38: lw $3, 172($0)
L39: lw $2, 3588($0)
L40: lui $31, 23872
L41: sw $3, 0($0)
L42: ori $3, $2, 31274
L43: j L79
L44: subu $0, $2, $31
L45: subu $1, $2, $0
L46: subu $31, $1, $1
L47: beq $1, $0, L67
L48: lw $3, 2064($0)
L49: lw $1, 1452($0)
L50: lw $1, 360($0)
L51: ori $2, $31, 43826
L52: sw $1, 1228($0)
L53: ori $2, $31, 26841
L54: beq $0, $0, L69
L55: subu $2, $3, $1
L56: subu $3, $0, $31
L57: ori $1, $0, 62723
L58: j L67
L59: subu $0, $31, $31
L60: ori $3, $31, 23947
L61: subu $1, $0, $0
L62: sw $1, 0($0)
L63: ori $3, $1, 20796
L64: beq $0, $0, L102
L65: lui $1, 10165
L66: lw $2, 968($0)
L67: subu $31, $1, $2
L68: subu $31, $2, $1
L69: beq $2, $0, L84
L70: ori $0, $31, 33002
L71: addu $0, $3, $0
L72: sw $3, 2480($0)
L73: lw $31, 64($0)
L74: ori $1, $2, 55319
L75: addu $2, $0, $31
L76: beq $1, $0, L109
L77: addu $31, $31, $31
L78: lw $31, 0($0)
L79: subu $2, $0, $31
L80: lw $1, 388($0)
L81: addu $2, $3, $3
L82: jal L126
L83: lui $3, 45646
L84: j L86
L85: sw $2, 3596($0)
L86: sw $1, 0($0)
L87: nop
L88: lw $3, 3808($0)
L89: jal L148
L90: lui $1, 15653
L91: lui $2, 33781
L92: addu $2, $31, $0
L93: lw $31, 244($0)
L94: subu $0, $3, $2
L95: sw $31, 1024($0)
L96: addu $3, $0, $0
L97: subu $3, $3, $0
L98: ori $3, $3, 8516
L99: addu $3, $2, $1
L100: beq $1, $3, L152
L101: nop
L102: beq $1, $31, L103
L103: lui $2, 38569
L104: lw $31, 0($0)
L105: lui $31, 34132
L106: jal L146
L107: lw $3, 0($0)
L108: lui $1, 40701
L109: lw $1, 1676($0)
L110: lui $3, 11992
L111: lw $31, 0($0)
L112: subu $1, $2, $31
L113: subu $3, $2, $3
L114: lw $3, 3496($0)
L115: subu $31, $2, $3
L116: addu $2, $2, $2
L117: subu $31, $0, $3
L118: subu $1, $0, $3
L119: jal L164
L120: subu $31, $0, $3
L121: lw $3, 2352($0)
L122: ori $31, $1, 35064
L123: lw $3, 212($0)
L124: beq $3, $0, L148
L125: addu $3, $0, $31
L126: beq $0, $0, L168
L127: subu $1, $0, $3
L128: jal L163
L129: lw $31, 0($0)
L130: beq $2, $2, L140
L131: subu $2, $1, $1
L132: beq $2, $31, L183
L133: subu $31, $0, $3
L134: subu $3, $1, $2
L135: ori $3, $3, 16197
L136: ori $3, $31, 20965
L137: lui $1, 14541
L138: beq $0, $0, L162
L139: ori $2, $2, 32953
L140: beq $0, $0, L150
L141: ori $0, $31, 37970
L142: j L203
L143: addu $2, $3, $0
L144: lw $0, 0($0)
L145: ori $31, $1, 21119
L146: lui $31, 35639
L147: subu $31, $0, $31
L148: sw $1, 2860($0)
L149: subu $31, $0, $1
L150: lui $3, 26890
L151: lui $0, 26381
L152: subu $3, $2, $1
L153: lw $1, 3492($0)
L154: subu $3, $3, $31
L155: subu $31, $1, $0
L156: j L198
L157: ori $3, $1, 26601
L158: lui $1, 21429
L159: j L211
L160: ori $2, $31, 37855
L161: j L204
L162: addu $3, $0, $1
L163: subu $2, $0, $31
L164: ori $2, $1, 46736
L165: beq $0, $0, L200
L166: subu $0, $1, $3
L167: addu $2, $0, $3
L168: jal L218
L169: lui $1, 42314
L170: addu $3, $1, $31
L171: lw $31, 688($0)
L172: lui $2, 50678
L173: addu $2, $1, $0
L174: jal L180
L175: lui $31, 13620
L176: j L208
L177: lui $3, 17907
L178: subu $31, $31, $2
L179: lw $3, 3040($0)
L180: j L221
L181: addu $2, $1, $2
L182: ori $0, $3, 32012
L183: lui $2, 30251
L184: beq $0, $3, L222
L185: addu $2, $0, $3
L186: addu $31, $0, $2
L187: lui $31, 38052
L188: j L203
L189: subu $31, $31, $0
L190: beq $3, $31, L226
L191: lui $31, 35740
L192: ori $2, $1, 33412
L193: subu $1, $0, $1
L194: beq $0, $31, L254
L195: addu $2, $1, $2
L196: ori $1, $1, 51280
L197: sw $1, 0($0)
L198: ori $1, $3, 49032
L199: subu $0, $1, $0
L200: ori $31, $1, 22910
L201: subu $2, $0, $0
L202: lw $1, 2568($0)
L203: lw $2, 0($0)
L204: j L246
L205: subu $31, $3, $31
L206: jal L266
L207: sw $1, 3052($0)
L208: subu $31, $1, $2
L209: subu $2, $2, $0
L210: ori $1, $3, 22911
L211: addu $1, $0, $0
L212: ori $2, $1, 26870
L213: lui $3, 27296
L214: lw $2, 0($0)
L215: jal L245
L216: lw $1, 0($0)
L217: ori $1, $31, 12723
L218: ori $1, $31, 35071
L219: beq $3, $0, L260
L220: ori $0, $3, 14882
L221: lw $1, 696($0)
L222: j L238
L223: addu $1, $2, $31
L224: lui $3, 49775
L225: subu $3, $1, $0
L226: ori $3, $2, 22536
L227: lw $2, 2212($0)
L228: subu $1, $31, $31
L229: ori $3, $2, 31438
L230: lw $1, 0($0)
L231: ori $31, $3, 38291
L232: addu $3, $3, $1
L233: ori $31, $1, 43353
L234: j L294
L235: addu $31, $0, $31
L236: subu $31, $2, $3
L237: beq $1, $3, L265
L238: addu $1, $3, $2
L239: subu $2, $3, $31
L240: beq $2, $0, L250
L241: subu $2, $0, $31
L242: lui $3, 21230
L243: beq $31, $0, L275
L244: lui $1, 35624
L245: sw $31, 2892($0)
L246: ori $2, $1, 38635
L247: beq $0, $0, L293
L248: lui $31, 29647
L249: sw $0, 0($0)
L250: lw $3, 1548($0)
L251: lui $3, 18878
L252: lw $3, 0($0)
L253: subu $3, $3, $2
L254: lui $2, 15201
L255: subu $3, $0, $0
L256: subu $1, $2, $2
L257: beq $31, $0, L293
L258: ori $31, $31, 34545
L259: addu $2, $1, $1
L260: beq $0, $0, L267
L261: lw $1, 0($0)
L262: addu $2, $31, $0
L263: addu $2, $2, $2
L264: lw $1, 2824($0)
L265: lw $31, 1552($0)
L266: ori $1, $1, 31898
L267: sw $3, 0($0)
L268: lui $2, 43686
L269: subu $2, $3, $2
L270: addu $3, $0, $0
L271: addu $31, $2, $0
L272: j L274
L273: lui $2, 19819
L274: subu $1, $0, $31
L275: addu $31, $0, $2
L276: jal L321
L277: addu $2, $31, $0
L278: lui $3, 30186
L279: addu $31, $0, $1
L280: lw $3, 0($0)
L281: lui $1, 44770
L282: beq $0, $0, L320
L283: nop
L284: beq $3, $0, L305
L285: subu $1, $0, $3
L286: ori $31, $2, 22530
L287: lw $2, 2128($0)
L288: ori $31, $3, 18775
L289: lui $3, 32937
L290: beq $0, $0, L338
L291: subu $2, $2, $31
L292: beq $0, $0, L335
L293: lw $2, 0($0)
L294: lui $2, 38836
L295: subu $31, $3, $2
L296: ori $1, $1, 47574
L297: lw $1, 2316($0)
L298: sw $31, 1036($0)
L299: j L340
L300: sw $1, 0($0)
L301: lw $0, 0($0)
L302: jal L361
L303: lw $31, 0($0)
L304: lw $2, 300($0)
L305: lui $31, 21778
L306: beq $0, $31, L334
L307: sw $1, 2732($0)
L308: addu $2, $31, $2
L309: subu $0, $1, $3
L310: subu $31, $31, $1
L311: lui $3, 26409
L312: beq $0, $3, L352
L313: addu $3, $31, $0
L314: beq $3, $2, L366
L315: subu $3, $0, $3
L316: subu $3, $1, $31
L317: sw $2, 2320($0)
L318: lw $3, 1752($0)
L319: lui $31, 41209
L320: lui $31, 32759
L321: ori $31, $31, 8295
L322: sw $31, 3624($0)
L323: lw $31, 3256($0)
L324: subu $2, $1, $0
L325: addu $0, $3, $31
L326: lw $1, 0($0)
L327: subu $3, $1, $3
L328: sw $2, 616($0)
L329: subu $2, $1, $2
L330: beq $0, $0, L342
L331: lw $3, 408($0)
L332: subu $31, $3, $31
L333: subu $3, $0, $1
L334: addu $31, $2, $1
L335: jal L377
L336: ori $31, $1, 53492
L337: sw $31, 3632($0)
L338: jal L365
L339: subu $1, $31, $1
L340: lui $1, 23946
L341: jal L344
L342: lui $31, 21889
L343: addu $3, $2, $2
L344: lw $1, 0($0)
L345: ori $3, $3, 30495
L346: lui $3, 18961
L347: addu $2, $1, $31
L348: j L366
L349: sw $31, 2124($0)
L350: lw $3, 2368($0)
L351: ori $3, $31, 28407
L352: subu $2, $1, $0
L353: lui $2, 24220
L354: subu $31, $3, $1
L355: jal L372
L356: subu $31, $3, $2
L357: lw $1, 3924($0)
L358: j L409
L359: nop
L360: beq $3, $0, L404
L361: lw $1, 0($0)
L362: beq $2, $2, L364
L363: subu $3, $31, $0
L364: lw $1, 3084($0)
L365: j L422
L366: ori $1, $1, 39461
L367: lui $3, 23977
L368: lui $1, 33882
L369: beq $1, $2, L419
L370: lui $31, 15390
L371: j L405
L372: lui $3, 22282
L373: subu $2, $0, $31
L374: lw $31, 3664($0)
L375: ori $31, $3, 44025
L376: lui $31, 40286
L377: subu $31, $2, $1
L378: subu $3, $1, $1
L379: j L424
L380: lui $3, 41905
L381: addu $31, $31, $3
L382: j L416
L383: ori $3, $3, 36150
L384: beq $31, $31, L407
L385: ori $1, $31, 12888
L386: lui $1, 54383
L387: sw $1, 2232($0)
L388: lw $0, 544($0)
L389: jal L421
L390: subu $2, $3, $0
L391: lw $31, 1240($0)
L392: subu $31, $1, $2
L393: beq $0, $0, L426
L394: ori $2, $3, 33513
L395: jal L429
L396: lui $3, 49508
L397: lui $31, 46360
L398: ori $31, $3, 45873
L399: lw $1, 980($0)
L400: beq $0, $3, L407
L401: subu $31, $0, $2
L402: addu $3, $31, $2
L403: lui $1, 33482
L404: jal L442
L405: lw $2, 0($0)
L406: lui $3, 47181
L407: ori $3, $3, 43495
L408: jal L421
L409: lw $0, 3648($0)
L410: ori $31, $3, 11193
L411: ori $0, $31, 34926
L412: beq $3, $0, L427
L413: subu $1, $1, $0
L414: addu $31, $0, $31
L415: lui $31, 46946
L416: subu $3, $1, $31
L417: subu $3, $0, $31
L418: subu $0, $0, $2
L419: ori $2, $2, 28396
L420: beq $1, $0, L451
L421: subu $3, $1, $3
L422: ori $0, $1, 23757
L423: subu $2, $1, $2
L424: addu $31, $31, $3
L425: addu $1, $2, $1
L426: sw $1, 2624($0)
L427: lw $31, 0($0)
L428: ori $1, $3, 13638
L429: j L478
L430: ori $2, $2, 32005
L431: j L443
L432: lui $1, 15510
L433: lui $0, 10386
L434: subu $1, $0, $2
L435: j L469
L436: lw $2, 4048($0)
L437: lui $2, 22930
L438: j L490
L439: lui $1, 30852
L440: lui $3, 49312
L441: j L451
L442: sw $31, 3216($0)
L443: subu $31, $1, $2
L444: ori $2, $2, 13217
L445: addu $31, $1, $1
L446: lui $2, 16897
L447: ori $31, $3, 35295
L448: subu $3, $2, $31
L449: ori $3, $31, 39120
L450: lw $1, 3524($0)
L451: beq $1, $2, L508
L452: addu $31, $1, $1
L453: subu $3, $31, $1
L454: lui $31, 62533
L455: lw $0, 3616($0)
L456: j L500
L457: ori $1, $3, 47265
L458: sw $31, 0($0)
L459: ori $2, $3, 23319
L460: addu $0, $1, $3
L461: sw $31, 0($0)
L462: subu $3, $31, $3
L463: beq $31, $1, L469
L464: addu $31, $2, $3
L465: sw $1, 0($0)
L466: lui $2, 7349
L467: beq $2, $2, L480
L468: subu $2, $2, $0
L469: ori $2, $2, 24960
L470: lui $1, 37395
L471: lui $31, 39500
L472: beq $31, $2, L533
L473: subu $3, $3, $31
L474: lui $2, 32472
L475: lw $2, 1928($0)
L476: lw $2, 1204($0)
L477: beq $1, $0, L478
L478: addu $2, $0, $3
L479: lw $31, 416($0)
L480: lw $2, 0($0)
L481: lui $1, 54857
L482: beq $1, $1, L526
L483: lui $3, 28026
L484: lw $31, 876($0)
L485: lui $2, 56019
L486: beq $0, $31, L492
L487: subu $1, $1, $2
L488: lui $2, 19432
L489: addu $1, $31, $0
L490: nop
L491: addu $0, $3, $31
L492: j L527
L493: lw $1, 904($0)
L494: beq $0, $0, L541
L495: ori $31, $2, 27171
L496: ori $1, $2, 20066
L497: beq $0, $1, L546
L498: ori $1, $2, 24901
L499: lw $1, 0($0)
L500: beq $2, $0, L548
L501: subu $2, $3, $2
L502: j L540
L503: nop
L504: subu $31, $31, $1
L505: lui $31, 24496
L506: ori $2, $1, 42292
L507: subu $2, $2, $2
L508: ori $2, $2, 27245
L509: jal L521
L510: sw $0, 3840($0)
L511: ori $3, $3, 36285
L512: lui $3, 15179
L513: lw $3, 3472($0)
L514: subu $3, $3, $3
L515: ori $3, $31, 56992
L516: subu $2, $0, $0
L517: beq $1, $31, L545
L518: ori $2, $0, 39827
L519: beq $0, $0, L564
L520: subu $31, $31, $2
L521: beq $3, $1, L552
L522: lui $31, 40824
L523: subu $0, $2, $1
L524: lw $1, 3168($0)
L525: addu $2, $31, $1
L526: beq $3, $0, L532
L527: lw $31, 0($0)
L528: subu $31, $3, $31
L529: ori $3, $2, 18479
L530: beq $1, $0, L592
L531: lui $2, 48882
L532: beq $2, $3, L555
L533: addu $3, $31, $1
L534: beq $31, $2, L561
L535: addu $1, $2, $0
L536: jal L573
L537: subu $2, $31, $31
L538: ori $3, $0, 39440
L539: ori $31, $31, 35485
L540: sw $31, 0($0)
L541: lui $31, 17143
L542: subu $3, $31, $0
L543: sw $0, 2084($0)
L544: addu $0, $2, $1
L545: nop
L546: subu $1, $3, $31
L547: jal L603
L548: addu $2, $1, $0
L549: subu $31, $2, $1
L550: lui $2, 23711
L551: j L608
L552: ori $2, $2, 34751
L553: subu $2, $1, $31
L554: ori $0, $1, 9959
L555: lui $2, 22892
L556: beq $31, $0, L599
L557: lw $1, 60($0)
L558: subu $3, $0, $31
L559: ori $2, $1, 41270
L560: lw $31, 3264($0)
L561: lw $31, 0($0)
L562: lui $1, 54608
L563: lw $1, 1304($0)
L564: addu $2, $31, $1
L565: ori $2, $31, 33822
L566: beq $2, $0, L608
L567: lui $3, 54448
L568: jal L583
L569: subu $1, $3, $3
L570: addu $2, $0, $0
L571: subu $0, $3, $1
L572: lui $3, 51462
L573: beq $31, $0, L629
L574: ori $31, $3, 44634
L575: beq $1, $1, L623
L576: ori $31, $3, 56816
L577: addu $1, $1, $1
L578: lui $31, 28468
L579: ori $1, $2, 42834
L580: j L613
L581: subu $1, $3, $2
L582: beq $0, $0, L645
L583: subu $31, $3, $2
L584: addu $2, $31, $0
L585: lui $3, 14996
L586: subu $31, $1, $1
L587: lui $31, 15485
L588: subu $3, $31, $3
L589: addu $2, $31, $2
L590: subu $1, $0, $3
L591: nop
L592: lw $2, 0($0)
L593: nop
L594: sw $1, 0($0)
L595: lui $31, 29196
L596: subu $31, $0, $31
L597: ori $1, $3, 33808
L598: beq $1, $1, L635
L599: lui $3, 17946
L600: sw $31, 1588($0)
L601: beq $0, $31, L656
L602: lui $0, 14402
L603: subu $3, $1, $1
L604: j L655
L605: lw $31, 0($0)
L606: addu $1, $31, $0
L607: ori $31, $2, 37426
L608: lui $1, 25288
L609: jal L636
L610: ori $0, $3, 9655
L611: lw $1, 0($0)
L612: beq $0, $0, L614
L613: ori $3, $31, 25466
L614: lui $1, 35213
L615: beq $0, $1, L638
L616: lw $31, 0($0)
L617: beq $1, $0, L625
L618: sw $31, 0($0)
L619: lui $2, 27798
L620: lui $31, 28927
L621: sw $2, 2764($0)
L622: sw $31, 0($0)
L623: subu $0, $3, $31
L624: j L646
L625: ori $31, $31, 34175
L626: j L647
L627: subu $1, $31, $1
L628: sw $31, 0($0)
L629: jal L634
L630: subu $1, $3, $2
L631: ori $0, $31, 4353
L632: lw $1, 0($0)
L633: beq $0, $3, L680
L634: addu $1, $3, $1
L635: lui $31, 10584
L636: subu $1, $31, $31
L637: beq $0, $0, L644
L638: subu $31, $31, $2
L639: lw $1, 3912($0)
L640: subu $2, $31, $31
L641: jal L685
L642: subu $2, $31, $2
L643: lui $3, 58548
L644: ori $31, $31, 33229
L645: j L665
L646: lui $31, 33684
L647: subu $31, $1, $0
L648: lui $3, 24279
L649: lui $2, 6766
L650: lui $1, 37276
L651: ori $31, $1, 32733
L652: sw $1, 3044($0)
L653: ori $31, $3, 22018
L654: lw $1, 1276($0)
L655: lui $3, 11488
L656: lw $3, 0($0)
L657: lw $1, 1572($0)
L658: beq $2, $0, L688
L659: lw $2, 1184($0)
L660: sw $2, 1428($0)
L661: lw $1, 3372($0)
L662: ori $1, $2, 32442
L663: subu $0, $0, $3
L664: lw $1, 0($0)
L665: beq $1, $0, L715
L666: addu $0, $1, $31
L667: subu $2, $31, $2
L668: sw $3, 1316($0)
L669: beq $0, $3, L724
L670: subu $1, $2, $3
L671: beq $1, $0, L696
L672: lui $31, 28579
L673: beq $2, $0, L704
L674: ori $31, $31, 31932
L675: ori $2, $31, 49195
L676: subu $1, $0, $0
L677: lw $31, 0($0)
L678: addu $1, $2, $31
L679: j L693
L680: ori $2, $2, 30539
L681: lw $31, 0($0)
L682: lw $0, 1032($0)
L683: addu $3, $0, $1
L684: lui $3, 35727
L685: addu $2, $2, $31
L686: sw $1, 2944($0)
L687: ori $1, $2, 33202
L688: sw $2, 0($0)
L689: addu $2, $1, $3
L690: addu $2, $1, $1
L691: subu $2, $3, $3
L692: lw $31, 1544($0)
L693: ori $1, $2, 24522
L694: addu $1, $2, $31
L695: beq $1, $0, L712
L696: ori $2, $2, 40314
L697: lw $1, 3100($0)
L698: jal L759
L699: subu $2, $3, $2
L700: lw $1, 2652($0)
L701: lui $1, 34539
L702: addu $0, $1, $2
L703: j L716
L704: lw $31, 3172($0)
L705: beq $0, $1, L728
L706: lw $2, 1640($0)
L707: ori $1, $2, 27305
L708: lw $0, 0($0)
L709: lw $1, 3592($0)
L710: nop
L711: subu $31, $31, $3
L712: subu $1, $2, $3
L713: lui $0, 22862
L714: ori $3, $2, 30989
L715: ori $1, $2, 27784
L716: subu $31, $2, $31
L717: lw $1, 0($0)
L718: beq $0, $3, L730
L719: addu $1, $2, $2
L720: addu $1, $0, $31
L721: addu $2, $0, $0
L722: ori $2, $0, 31533
L723: sw $1, 640($0)
L724: subu $31, $3, $3
L725: lw $3, 0($0)
L726: sw $3, 2496($0)
L727: ori $1, $2, 25547
L728: lw $3, 80($0)
L729: ori $3, $3, 21234
L730: addu $3, $31, $31
L731: lui $2, 48244
L732: lw $3, 16($0)
L733: ori $31, $31, 28210
L734: ori $2, $2, 48680
L735: addu $3, $1, $0
L736: sw $2, 0($0)
L737: lui $1, 33930
L738: beq $0, $0, L793
L739: addu $31, $31, $0
L740: lui $3, 29999
L741: subu $2, $0, $1
L742: addu $31, $3, $3
L743: subu $31, $3, $31
L744: subu $31, $31, $2
L745: lw $1, 900($0)
L746: sw $31, 1392($0)
L747: ori $1, $0, 55160
L748: beq $2, $2, L778
L749: subu $1, $31, $0
L750: addu $1, $2, $31
L751: beq $3, $0, L769
L752: ori $2, $31, 9626
L753: ori $1, $31, 25491
L754: subu $31, $2, $0
L755: beq $0, $3, L773
L756: addu $1, $2, $2
L757: sw $3, 3720($0)
L758: subu $0, $1, $2
L759: sw $2, 0($0)
L760: beq $3, $2, L799
L761: lui $31, 22964
L762: j L776
L763: lui $3, 47570
L764: j L827
L765: subu $1, $0, $3
L766: lui $3, 42657
L767: subu $2, $3, $0
L768: lw $31, 264($0)
L769: lw $3, 0($0)
L770: beq $31, $0, L833
L771: subu $3, $31, $31
L772: ori $31, $0, 28510
L773: ori $1, $3, 18110
L774: lw $0, 0($0)
L775: beq $0, $31, L782
L776: lw $1, 1244($0)
L777: jal L805
L778: lui $3, 44500
L779: ori $31, $1, 43409
L780: subu $1, $0, $0
L781: beq $1, $1, L830
L782: sw $31, 1172($0)
L783: lw $3, 3148($0)
L784: sw $1, 72($0)
L785: ori $3, $3, 21589
L786: lui $3, 51943
L787: subu $2, $0, $1
L788: beq $0, $0, L818
L789: lw $2, 0($0)
L790: jal L796
L791: ori $31, $3, 32792
L792: ori $2, $3, 31742
L793: lui $3, 26682
L794: lui $2, 25256
L795: subu $31, $2, $1
L796: ori $2, $3, 5402
L797: j L843
L798: sw $0, 2688($0)
L799: nop
L800: jal L855
L801: sw $31, 0($0)
L802: j L832
L803: sw $1, 2968($0)
L804: addu $0, $2, $1
L805: subu $3, $1, $0
L806: nop
L807: lw $1, 3812($0)
L808: ori $3, $2, 1321
L809: ori $2, $31, 32455
L810: lui $31, 15161
L811: ori $1, $1, 34433
L812: lw $31, 3476($0)
L813: lw $1, 2668($0)
L814: sw $1, 3708($0)
L815: lw $2, 1180($0)
L816: ori $3, $2, 26175
L817: nop
L818: addu $0, $2, $2
L819: addu $31, $3, $0
L820: subu $2, $0, $0
L821: lw $3, 0($0)
L822: subu $1, $2, $0
L823: subu $2, $2, $3
L824: j L835
L825: lui $31, 30169
L826: j L872
L827: ori $1, $31, 38631
L828: sw $2, 4088($0)
L829: sw $3, 2564($0)
L830: subu $3, $31, $0
L831: beq $0, $2, L893
L832: ori $1, $3, 54590
L833: j L873
L834: ori $1, $1, 2781
L835: addu $3, $2, $0
L836: ori $31, $3, 45778
L837: sw $1, 100($0)
L838: nop
L839: ori $3, $3, 33606
L840: sw $3, 0($0)
L841: beq $3, $1, L849
L842: subu $31, $2, $31
L843: j L859
L844: subu $0, $3, $31
L845: lw $31, 0($0)
L846: lui $3, 36664
L847: ori $31, $3, 49919
L848: j L877
L849: subu $31, $1, $3
L850: lw $1, 280($0)
L851: subu $2, $2, $31
L852: subu $31, $0, $1
L853: lw $1, 380($0)
L854: beq $0, $1, L872
L855: ori $2, $1, 11788
L856: lui $31, 39326
L857: ori $3, $3, 19901
L858: beq $0, $1, L900
L859: addu $3, $2, $31
L860: jal L921
L861: addu $0, $0, $1
L862: ori $0, $0, 29554
L863: subu $1, $2, $3
L864: subu $0, $31, $0
L865: subu $1, $1, $3
L866: subu $1, $31, $2
L867: lw $3, 2688($0)
L868: ori $1, $0, 8166
L869: j L879
L870: sw $31, 0($0)
L871: lui $2, 31708
L872: lui $2, 12648
L873: subu $2, $1, $1
L874: j L895
L875: lui $0, 32160
L876: lui $3, 44123
L877: lui $2, 29521
L878: lui $2, 43969
L879: jal L907
L880: addu $2, $0, $1
L881: addu $3, $1, $31
L882: j L895
L883: lui $2, 46659
L884: lui $2, 29372
L885: ori $31, $31, 28614
L886: lui $31, 27181
L887: ori $31, $31, 23001
L888: addu $1, $2, $31
L889: subu $1, $31, $3
L890: beq $0, $2, L937
L891: ori $1, $31, 19791
L892: lw $2, 92($0)
L893: j L907
L894: lui $3, 40730
L895: ori $0, $0, 36726
L896: j L952
L897: subu $3, $1, $1
L898: jal L941
L899: lw $31, 3576($0)
L900: beq $1, $0, L911
L901: lui $31, 25140
L902: addu $1, $31, $3
L903: beq $0, $0, L927
L904: ori $1, $1, 8237
L905: j L936
L906: ori $3, $3, 34133
L907: ori $31, $2, 51318
L908: subu $31, $31, $1
L909: beq $3, $1, L945
L910: lui $0, 45883
L911: beq $31, $0, L964
L912: lw $0, 12($0)
L913: beq $31, $31, L972
L914: lw $3, 2080($0)
L915: beq $0, $3, L931
L916: ori $1, $3, 23305
L917: nop
L918: beq $0, $0, L958
L919: sw $1, 132($0)
L920: beq $0, $0, L977
L921: lui $0, 34059
L922: lw $2, 20($0)
L923: beq $0, $0, L953
L924: lui $31, 31483
L925: subu $3, $1, $1
L926: nop
L927: j L947
L928: lw $1, 356($0)
L929: lui $1, 33528
L930: ori $2, $3, 28932
L931: beq $0, $0, L965
L932: sw $3, 0($0)
L933: lui $31, 34219
L934: sw $31, 1712($0)
L935: lw $3, 80($0)
L936: lui $1, 42017
L937: lui $1, 17548
L938: lui $3, 24396
L939: subu $1, $2, $31
L940: j L941
L941: addu $31, $31, $31
L942: addu $1, $1, $31
L943: lw $1, 648($0)
L944: beq $1, $1, L994
L945: subu $2, $31, $0
L946: ori $3, $31, 12973
L947: addu $3, $1, $2
L948: beq $0, $31, L1001
L949: addu $3, $3, $31
L950: subu $31, $0, $2
L951: jal L992
L952: subu $3, $0, $3
L953: lui $2, 35382
L954: sw $3, 668($0)
L955: beq $31, $0, L1001
L956: addu $1, $3, $0
L957: subu $31, $31, $0
L958: j L986
L959: sw $1, 0($0)
L960: ori $3, $2, 15688
L961: ori $1, $31, 51932
L962: nop
L963: lw $1, 0($0)
L964: ori $3, $2, 26084
L965: lui $0, 27434
L966: lw $2, 0($0)
L967: subu $31, $1, $3
L968: addu $2, $1, $31
L969: addu $1, $31, $3
L970: addu $1, $31, $31
L971: subu $31, $1, $31
L972: lw $2, 3900($0)
L973: beq $0, $31, L1001
L974: addu $31, $3, $3
L975: ori $1, $31, 33292
L976: j L1001
L977: lw $1, 2348($0)
L978: addu $3, $3, $31
L979: lw $2, 2384($0)
L980: beq $3, $31, L1001
L981: lw $3, 3308($0)
L982: addu $31, $2, $3
L983: ori $2, $3, 29123
L984: lui $3, 21804
L985: ori $3, $31, 47604
L986: beq $2, $0, L1001
L987: lui $2, 20495
L988: lw $1, 0($0)
L989: lw $1, 948($0)
L990: lw $2, 1900($0)
L991: ori $3, $3, 56083
L992: lui $2, 30450
L993: addu $3, $3, $31
L994: sw $1, 0($0)
L995: addu $3, $2, $0
L996: lui $31, 53681
L997: lui $31, 22733
L998: sw $1, 2692($0)
L999: lw $31, 3548($0)
L1000: ori $3, $2, 31787
L1001: nop
Exit: nop
