**free
ctl-opt dftactgrp(*no) bnddir('QC2LE'); // import routines from C

dcl-pr exit extproc('exit'); // exit routine prototype
  status int(3) value; // void exit(int status) -> exits the process with status
end-pr;

dcl-pr srand extproc('srand'); // srand routine prototype
    seed uns(10) value; // void srand(unsigned seed) -> initializes rand seed
end-pr;

dcl-pr rand int(10) extproc('rand'); // rand routine prototype
end-pr; // int rand(void) -> random number between 0 and RAND_MAX (both included)

dcl-pr clock int(10) extproc('clock'); // clock routine prototype
end-pr; // int clock(void) -> approximates used CPU time

dcl-c PLAYER_SYMBOL const('X');
dcl-c AI_SYMBOL const('O');
dcl-c PLAYER const(1);
dcl-c AI const(2);
dcl-c NOWINNER const(0);
dcl-c TIE const(3);

// main code

srand(clock()); // initializes rand
tictactoe();  // runs program
return;

// procedures cannot be before main code, only declarations (dcl-*) and some other things (i.e. ctl-opt) may be

dcl-proc input; // inputs message from user (max 26 chars)
    dcl-pi *n varchar(26); // returns input
        msg varchar(26); // and takes a message as argument
    end-pi;

    dcl-s user_input varchar(26);

    dsply msg '' user_input; // that's why this procedure exists, to wrap the weird dsply which outputs but also inputs
    return user_input;
end-proc;

dcl-proc get_player_of; // returns which player has played a symbol
    dcl-pi *n int(3); // returns number corresponding to the player
        symbol char(1); // symbol played, cannot be invalid (not AI_SYMBOL nor PLAYER_SYMBOL) otherwise PLAYER is returned
    end-pi;

    if symbol = AI_SYMBOL;
        return AI;
    endif;
    return PLAYER;
end-proc;

dcl-proc get_winner; // checks if someone has won the game
    dcl-pi *n int(3); // returns 1 for player, 2 for AI and 0 for no winner, 3 for tie
        grid char(1) dim(9);
    end-pi;

    dcl-s start int(3);
    dcl-s line int(3);
    dcl-s col int(3);
    dcl-s is_grid_full int(3) inz(1);

    for line = 0 to 2;
        start = line * 3 + 1;
        if grid(start) = grid(start + 1) and grid(start) = grid(start + 2) and grid(start) <> '_';
            return get_player_of(grid(start));
        endif;
    endfor;

    for col = 0 to 2;
        if grid(col + 1) = grid(col + 4) and grid(col + 1) = grid(col + 7) and grid(col + 1) <> '_';
            return get_player_of(grid(col + 1));
        endif;
    endfor;

    if grid(1) = grid(5) and grid(1) = grid(9) and grid(1) <> '_';
        return get_player_of(grid(1));
    endif;
    if grid(3) = grid(5) and grid(3) = grid(7) and grid(3) <> '_';
        return get_player_of(grid(3));
    endif;

    for start = 1 to 9;
        if grid(start) = '_';
            is_grid_full = 0;
            leave;
        endif;
    endfor;
    if is_grid_full = 1;
        return TIE;
    endif;

    return NOWINNER;
end-proc;

dcl-proc player_turn; // prompts the player to get its turn
    dcl-pi *n;
        grid char(1) dim(9);
    end-pi;

    dcl-s player_input varchar(26) inz('What box [1-9] ? ');
    dcl-s n uns(3);

    dow 1 = 1;
        monitor;
            n = %uns(input(player_input));
            on-error;
        endmon;
        if n <= 9 and n <> 0 and grid(n) = '_';
            leave;
        endif;
    enddo;
    grid(n) = PLAYER_SYMBOL;
end-proc;

dcl-proc ai_turn; // AI plays randomly
    dcl-pi *n;
        grid char(1) dim(9);
    end-pi;

    dcl-s i int(3);
    dcl-s n_empty int(3) inz(0);
    dcl-s turn int(3) inz(0);

    for i = 1 to 9;
        if grid(i) = '_';
            n_empty += 1; // counts empty boxes
        endif;
    endfor;

    if n_empty <> 1;
        turn = %rem(rand() : n_empty); // then playes on a random box among them
    endif; // if only one empty box, turn is still 0

    for i = 1 to 9;
        if grid(i) = '_';
            if turn = 0;
                grid(i) = AI_SYMBOL; // iterates over grid again to find the nth box
                leave;
            else;
                turn -= 1; // one more empty box is crossed
            endif;
        endif;
    endfor;
end-proc;

dcl-proc display_grid;
    dcl-pi *n;
        grid char(1) dim(9);
    end-pi;

    dcl-s line int(3);
    dcl-s start int(3);

    for line = 0 to 2;
        start = line * 3 + 1;
        dsply ('|' + grid(start) + '|' + grid(start + 1) + '|' + grid(start + 2));
    endfor;
    dsply '---------';
end-proc;

dcl-proc dsply_end_msg;     // displays end message, according to win or loss, and exits if game has ended
    dcl-pi *n;
        winner int(3);
    end-pi;

    if winner = TIE;
        dsply 'Tie.';
        exit(0);
    elseif winner = AI;
        dsply 'AI won.';
        exit(0);
    elseif winner = PLAYER;
        dsply 'Player won.';
        exit(0);
    endif;
end-proc;

dcl-proc tictactoe; // main code
    dcl-s grid char(1) dim(9);
    dcl-s winner int(3);
    grid = %list('_' : '_' : '_' : '_' : '_' : '_' : '_' : '_' : '_');

    display_grid(grid);
    dow 1 = 1;
        ai_turn(grid);
        display_grid(grid);
        winner = get_winner(grid);
        dsply_end_msg(winner);
        player_turn(grid);
        display_grid(grid);
        winner = get_winner(grid);
        dsply_end_msg(winner);
    enddo;
end-proc;
