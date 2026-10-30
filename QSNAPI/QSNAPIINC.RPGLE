**free

ctl-opt dftactgrp(*no) ccsid(*exact);

// IBM fixed-format include files
/include QSYSINC/QRPGLESRC,QUSEC
/include QSYSINC/QRPGLESRC,QSNAPI

dcl-ds MyQsn_ErrorCode qualified template;
    bytesProvided int(10);
    bytesAvailable int(10);
    exceptionID char(7);
    $reserved char(1);
end-ds;

dcl-enum MyQsn_ScreenMode char(1) qualified;
    // Screen size is kept
    Mode_LeaveAsIs '0';
    // Screen size is set to 24x80 (*DS3)
    Mode_24x80 '3';
    // Screen size is set to 27x132 (*DS4)
    Mode_27x132 '4';
end-enum;

dcl-pr MyQsn_ClrScr int(10) extproc('QsnClrScr');
    screenMode char(1) const options(*omit);
    commandBufferHandle int(10) const options(*omit);
    lowLevelEnvironmentHandle int(10) const options(*omit);
    errorCode char(32767) const options(*varsize : *omit);
end-pr;

dcl-enum MyQsn_MonochromeAttribute qualified;
    None x'00'; // QsnNoSA
    Normal x'20'; // QsnSANorm
    ColumnSeparator x'30'; // QsnSACS
    Blink x'28'; // QsnSABL
    Underline x'24'; // QsnSAUL
    HighIntensity x'22'; // QsnSAHI
    ReverseImage x'21'; // QsnSARI
    // Equivalent to specifying Underline, HighIntensity and ReverseImage
    NonDisplay x'27'; // QsnSAND
end-enum;

dcl-enum MyQsn_ColorAttribute qualified;
    Nondisplay x'27'; // QsnSAND
    Nondisplay0x27 x'27'; // QsnSAND
    Nondisplay0x2F x'2F'; // QsnND2F
    Nondisplay0x37 x'37'; // QsnND37
    Nondisplay0x3F x'3F'; // QsnND3F

    // Same as Green
    Normal x'20'; // QsnSANorm

    Green x'20'; // QsnGrn
    GreenReverse x'21'; // QsnGrnRI
    GreenUnderline x'24'; // QsnGrnUL
    GreenUnderlineReverse x'25'; // QsnGrnULRI

    White x'22'; // QsnWht
    WhiteReverse x'23'; // QsnWhtRI
    WhiteUnderline x'26'; // QsnWhtUL

    Red x'28'; // QsnRed
    RedReverse x'29'; // QsnRedRI
    RedBlink x'2A'; // QsnRedBL
    RedReverseBlink x'2B'; // QsnRedRIBL
    RedUnderline x'2C'; // QsnRedUL
    RedUnderlineReverse x'2D'; // QsnRedULRI
    RedUnderlineBlink x'2E'; // QsnRedULBL

    TurquoiseColumnSeparators x'30'; // QsnTrqCS
    TurquoiseColumnSeparatorsReverse x'31'; // QsnTrqCSRI
    TurquoiseUnderline x'34'; // QsnTrqUL
    TurquoiseUnderlineReverse x'35'; // QsnTrqULRI

    YellowColumnSeparators x'32'; // QsnYlwCS
    YellowColumnSeparatorsReverse x'33'; // QsnYlwCSRI
    YellowUnderline x'36'; // QsnYlwUL

    Pink x'38'; // QsnPnk
    PinkUnderline x'3C'; // QsnPnkUL
    PinkUnderlineREverse x'3D'; // QsnPnkULRI

    Blue x'3A'; // QsnBlu
    BlueReverse x'3B'; // QsnBluRI
    BlueUnderline x'3E'; // QsnBluUL
end-enum;

dcl-pr MyQsn_WrtDta int(10) extproc('QsnWrtDta');
    data char(32767) const options(*varsize);
    dataLength int(10) const;
    fieldId int(10) const options(*omit);
    row int(10) const options(*omit);
    column int(10) const options(*omit);
    startingMonochromeAttribute char(1) const options(*omit);
    endingMonochromeAttribute char(1) const options(*omit);
    startingColorAttribute char(1) const options(*omit);
    endingColorAttribute char(1) const options(*omit);
    commandBufferHandle int(10) const options(*omit);
    lowLevelEnvironmentHandle int(10) const options(*omit);
    errorCode char(32767) const options(*varsize : *omit);
end-pr;

dcl-enum MyQsn_AID_Code qualified;
    F01 x'31'; // QsnF1
    F02 x'32'; // QsnF2
    F03 x'33'; // QsnF3
    F04 x'34'; // QsnF4
    F05 x'35'; // QsnF5
    F06 x'36'; // QsnF6
    F07 x'37'; // QsnF7
    F08 x'38'; // QsnF8
    F09 x'39'; // QsnF9
    F10 x'3A'; // QsnF10
    F11 x'3B'; // QsnF11
    F12 x'3C'; // QsnF12
    F13 x'B1'; // QsnF13
    F14 x'B2'; // QsnF14
    F15 x'B3'; // QsnF15
    F16 x'B4'; // QsnF16
    F17 x'B5'; // QsnF17
    F18 x'B6'; // QsnF18
    F19 x'B7'; // QsnF19
    F20 x'B8'; // QsnF20
    F21 x'B9'; // QsnF21
    F22 x'BA'; // QsnF22
    F23 x'BB'; // QsnF23
    F24 x'BC'; // QsnF24

    SelectorLightPenAutoEnter x'3F'; // QsnSLP
    ForwardEdgeTriggerAutoEnter x'50'; // QsnFET

    PA1 x'6C'; // QsnPA1
    PA2 x'6E'; // QsnPA2
    PA3 x'6B'; // QsnPA3

    // dcl-c mandatory to name it like 'Clear' keyword
    dcl-c Clear x'BD'; // QsnClearK
    // Same as RecordAdvance
    Enter x'F1'; // QsnEnterK
    // Same as Enter
    RecordAdvance x'F1'; // QsnEnterK
    Help x'F3'; // QsnHelpK

    // Same as PageUp
    RollDown x'F4'; // QsnRollDnK
    // Same as RollDown
    PageUp x'F4'; // QsnPageUpK

    // Same as PageDown
    RollUp x'F5'; // QsnRollUpK
    // Same as RollUp
    PageDown x'F5'; // QsnPageDnK

    Print x'F6'; // QsnPrintK
    RecordBackspace x'F8'; // QsnRecBSK


    // Control characters

    CC1_Null x'00'; // QsnCC1Null
    CC1_LockKeyboard x'20'; // QsnCC1Lock
    CC1_MdtAll x'60'; // QsnCC1MDTA
    CC1_ClrMod x'80'; // QsnCC1ClrM
    CC1_MdtNByClrAll x'A0'; // QsnCC1NBYA
    CC1_MdtNByClrMod x'C0'; // QsnCC1NBYM
    CC1_MdtAllClrAll x'E0'; // QsnCC1All

    CC2_NoInsertCursor x'40'; // QsnCC2NoIC
    CC2_ResetBlinkingCursor x'20'; // QsnCC2RstB
    CC2_SetBlinkingCursor x'10'; // QsnCC2SetB
    CC2_UnlockKeyboard x'08'; // QsnCC2Unlk
    CC2_Alarm x'04'; // QsnCC2Alrm
    CC2_MessageWaitingIndOff x'02'; // QsnCC2MOff
    CC2_MessageWaitingIndOn x'01'; // QsnCC2MOn
end-enum;

dcl-pr MyQsn_GetAID char(1) extproc('QsnGetAID');
    AID_Code char(1) options(*omit);
    lowLevelEnvironmentHandle int(10) const options(*omit);
    errorCode char(32767) const options(*varsize : *omit);
end-pr;
