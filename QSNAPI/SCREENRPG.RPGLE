**free

/include QSNAPI,QSNAPIINC

dcl-s text char(80) inz;


MyQsn_ClrScr(MyQsn_ScreenMode.Mode_27x132 : *omit : *omit : *omit);

text = 'Hello, press F3 to proceed';
// 5th row // 10th column
MyQsn_WrtDta(
    text : %len(%trim(text)) :
    *omit : 5 : 10 :
    MyQsn_MonochromeAttribute.HighIntensity : MyQsn_MonochromeAttribute.Normal :
    MyQsn_ColorAttribute.Blue : MyQsn_ColorAttribute.Normal :
    *omit : *omit : *omit
);

dou pressedF3();
enddo;

text = 'Press F3 again to quit';
MyQsn_WrtDta(
    text : %len(%trim(text)) :
    *omit : 6 : 10 :
    MyQsn_MonochromeAttribute.HighIntensity : MyQsn_MonochromeAttribute.Normal :
    MyQsn_ColorAttribute.Blue : MyQsn_ColorAttribute.Normal :
    *omit : *omit : *omit
);

dou pressedF3();
enddo;

*inlr = *on;
return;

dcl-proc pressedF3;
    dcl-pi *n ind;
    end-pi;

    dcl-s AID_code char(1) inz;

    MyQsn_GetAID(AID_code : *omit : *omit);
    return aid_code = MyQsn_AID_Code.F03;
end-proc;
