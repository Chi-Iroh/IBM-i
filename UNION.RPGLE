**free
Ctl-Opt DftActGrp(*no);

Dcl-Ds StrUnionArray;
    str char(15);               // cannot do str(5) = ' '
    arr char(1) dim(15) pos(1); // so we make an union with a char array
End-Ds;

str = 'helloworld';
snd-msg '''' + str + '''';
arr(5) = ' ';
snd-msg '''' + str + '''';
return;
