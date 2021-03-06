function [ I , Dots ] = dealing( A )
%   MAIN Summary of this function goes here
%   Detailed explanation goes here
%   A           inputs  picture matrix
%   rA          local   remember A
%   ma          local   # A's row
%   na          local   # A's column
%   flag        local   which column program proceed to
%                       initial number 1
%   S           local   record the start position of the column first
%                       non-zero entry and the end postion of the
%                       successive non-zero entry 
%   judge_num   local   0 implies that column all zeros 
%                       1 implies that column has non-zero entry
%   run         local   initial # assemble iteratedly
%   dir         local   0 implies no need direction
%                       1 implies direction is up
%                       2 implies direction is down
%   X           local   the figure's x-coordinate
%   Y           local   the figure's y-coordinate
%   coeff       local   the function's coefficient
    
    set(0,'RecursionLimit',2000)
    
    [ ma , na ] =size( A );
    flag = 1 ;
    idx = 1;
    num = 1;
    I = [0];
    Dots = zeros(2,1);
    J = [ 1 ; 1 ];
    
    tic;
    
    global timer
    textctrl = findobj('tag', 'text4');
    
    % when A become a zero matrix , program finished
    while norm(A) > 0
        
        set(textctrl, 'string', round((now - timer) * 24 * 60 * 60 * 1000) / 1000);
        drawnow;
        
        rA = A;
        % start to search non-zero column from flag column
        for i = flag : na ;
            [ A , S , judge_num ] = judge_col ( A , i , J , 0);
            if  judge_num == 1
                flag = i ;
                J = S( : , 1 );
                break ;
            else
                J = [ 1 ; i + 1 ];
            end
        end

        % start to group
        [ A , G1 , G2 ] = dealing_group( A , rA , S );
      
        hold on;
        axis equal;
        
        % plot G1's and G2's figure
        [ I , idx , Dots , num ] = dealing_plot( rA , S , G1 , G2 , I , idx , Dots , num );
    end
    toc;
end