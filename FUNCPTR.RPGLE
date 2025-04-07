**free
ctl-opt bnddir('QC2LE');

dcl-pr rand int(10) extproc('rand');
end-pr;

dcl-pr callfunc;
    func pointer(*PROC) value;
end-pr;

dcl-pr print0;
end-pr;

dcl-pr print1;
end-pr;

dcl-s n int(10);

n = rand();
if %rem(n : 2) = 0;
    callfunc(%paddr(print0));
else;
    callfunc(%paddr(print1));
endif;
return;

dcl-proc print0;
    dsply '0 !';
end-proc;

dcl-proc print1;
    dsply '1 !';
end-proc;

dcl-proc callfunc;
    dcl-pi *n;
        func pointer(*PROC) value;
    end-pi;
    dcl-pr f extproc(func);
    end-pr;

    f();
end-proc;
