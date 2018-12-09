close all;

global global_rows global_columns filter_taps h1 h2 g1 g2 x1 x2 z1 z2 delay
global_rows = 512; 
global_columns = 512; 
filter_taps = 9;
delay = 5;

%Storahe for main program%
h1 = zeros(filter_taps, 1);
h2 = zeros(filter_taps, 1);
g1 = zeros(filter_taps, 1);
g2 = zeros(filter_taps, 1);
%X = zeros(global_rows, global_columns);
%Y = zeros(global_rows, global_columns);

x1 = zeros(1000,1);
x2 = zeros(1000,1);
z1 = zeros(1000,1);
z2 = zeros(1000,1);
temp = zeros(1000,1);

rows = global_rows;
columns = global_columns;

%Load Image
fid = fopen('lena.raw');
Y = fread(fid,[512,512],'uchar');
Y = Y';
fclose(fid);

X = Y;

h1(1) = 0.026749;
h1(2) = -0.016864;
h1(3) = -0.078223;
h1(4) = 0.266864;
h1(5) = 0.602949;
h1(6) = 0.266864;
h1(7) = -0.078223;
h1(8) = -0.016864;
h1(9) = 0.026749;

g1(1) = 0.0;
g1(2) = 0.091271763114;
g1(3) = -0.057543526229;
g1(4) = -0.591271763114;
g1(5) = 1.11508705;
g1(6) = -0.591271763114;
g1(7) = -0.057543526229;
g1(8) = 0.091271763114;
g1(9) = 0.0;


h2(1) = 0.0;
h2(2) = -g1(2);
h2(3) = g1(3);
h2(4) = -g1(4);
h2(5) = g1(5);
h2(6) = -g1(6);
h2(7) = g1(7);
h2(8) = -g1(8);
h2(9) = 0.0;

g2(1) = h1(1);
g2(2) = -h1(2);
g2(3) = h1(3);
g2(4) = -h1(4);
g2(5) = h1(5);
g2(6) = -h1(6);
g2(7) = h1(7);
g2(8) = -h1(8);
g2(9) = h1(9);


%%%%%%%%Divide the images into 4 equal subbands
row_offset = 0;
column_offset = 0;
Y = analysis_filter_rows(Y,rows,columns,row_offset,column_offset,h1,g1);

row_offset = 0;
column_offset = 0;
 Y = analysis_filter_columns(Y,rows/2,columns,row_offset,column_offset,h1,g1);

row_offset = rows/2;
column_offset = 0;
Y = analysis_filter_columns(Y,rows/2,columns,row_offset,column_offset,h1,g1);

%%%%%Further Divide each quarter-sized subband into 4 equal-sized subbands
%%% Filter upper left hand corner%%%
row_offset = 0;
column_offset = 0;
Y = analysis_filter_rows(Y,rows/2,columns/2,row_offset,column_offset,h1,g1);

row_offset = 0;
column_offset = 0;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);

row_offset = rows/4;
column_offset = 0;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);
% 
% 
% %Filter upper right hand corner
row_offset = 0;
column_offset = columns/2;
Y = analysis_filter_rows(Y,rows/2,columns/2,row_offset,column_offset,h1,g1);
% 
row_offset = 0;
column_offset = columns/2;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);
% 
row_offset = rows/4;
column_offset = columns/2;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);
% 
% % %Filter lower left-hand corner
% % 
row_offset = rows/2;
column_offset = 0;
Y = analysis_filter_rows(Y,rows/2,columns/2,row_offset,column_offset,h1,g1);

row_offset = rows/2;
column_offset = 0;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);
% 
row_offset = rows/2 +rows/4;
column_offset = 0;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);
% 
% % %Filter lower right-hand corner
row_offset = rows/2;
column_offset = columns/2;
Y = analysis_filter_rows(Y,rows/2,columns/2,row_offset,column_offset,h1,g1);
% 
row_offset = rows/2;
column_offset = columns/2;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);

row_offset = rows/2 + rows/4;
column_offset = columns/2;
Y = analysis_filter_columns(Y,rows/4,columns/2,row_offset,column_offset,h1,g1);

% Further divide lower left-hand subband into 4 subbands creating 19 subbands */

  row_offset = 0;
  column_offset = 0;
  Y = analysis_filter_rows(Y,rows/4,columns/4,row_offset,column_offset,h1,g1);

  row_offset = 0;
  column_offset = 0;
  Y = analysis_filter_columns(Y,rows/8,columns/4,row_offset,column_offset,h1,g1);
  
  row_offset = rows/8;
  column_offset = 0;
  Y = analysis_filter_columns(Y,rows/8,columns/4,row_offset,column_offset,h1,g1);

% Further divide lower left-hand subband into 4 subbands creating 22 subbands */

  row_offset = 0;
  column_offset = 0;
  Y = analysis_filter_rows(Y,rows/8,columns/8,row_offset,column_offset,h1,g1);

  row_offset = 0;
  column_offset = 0;
  Y = analysis_filter_columns(Y,rows/16,columns/8,row_offset,column_offset,h1,g1);
  
  row_offset = rows/16;
  column_offset = 0;
  analysis_filter_columns(Y,rows/16,columns/8,row_offset,column_offset,h1,g1);



%Make the highest frequency subband to zero
% Y(columns/2+columns/4:global_rows, rows/2+rows/4:global_columns)=0;

%Make the highest 3 frequency subbands to zero
%  Y(columns/2:columns/2+columns/4, rows/2+rows/4:global_rows)=0;
%  Y(columns/2+columns/4:global_rows, rows/2+rows/4:global_rows)=0;
%  Y(columns/2+columns/4:global_columns, rows/2:rows/2+rows/4)=0;

%Make the highest 10 frequencies subbands equal to zero
% Y(columns/2:columns/2+columns/4, rows/2+rows/4:global_rows)=0;
%  Y(columns/2+columns/4:global_columns, rows/2+rows/4:global_rows)=0;
%  Y(columns/2+columns/4:global_columns, rows/2:rows/2+rows/4)=0;
%  
%  Y(columns/4:columns/2, rows/2+rows/4:global_rows)=0;
%  Y(columns/2:columns/2+columns/4, rows/2:rows/2+rows/4)=0;
%  Y(columns/2+columns/4:global_columns, rows/4:rows/2)=0;
%  
%  Y(1:columns/4, rows/2+rows/4:global_rows)=0;
%  Y(columns/4:columns/2, rows/2:rows/2+rows/4)=0;
%  Y(columns/2:columns/2+columns/4, rows/4:rows/2)=0;
%  Y(columns/2+columns/4:global_columns, 1:rows/4)=0;

 %Make the highest 15 frequencies subbands equal to zero
Y(columns/2:columns/2+columns/4, rows/2+rows/4:global_rows)=0;
 Y(columns/2+columns/4:global_columns, rows/2+rows/4:global_rows)=0;
 Y(columns/2+columns/4:global_columns, rows/2:rows/2+rows/4)=0;
 
 Y(columns/4:columns/2, rows/2+rows/4:global_rows)=0;
 Y(columns/2:columns/2+columns/4, rows/2:rows/2+rows/4)=0;
 Y(columns/2+columns/4:global_columns, rows/4:rows/2)=0;
 
 Y(1:columns/4, rows/2+rows/4:global_rows)=0;
 Y(columns/4:columns/2, rows/2:rows/2+rows/4)=0;
 Y(columns/2:columns/2+columns/4, rows/4:rows/2)=0;
 Y(columns/2+columns/4:global_columns, 1:rows/4)=0;
 
 Y(1:columns/4, rows/2:rows/2+rows/4)=0;
 Y(columns/4:columns/2, rows/4:rows/2)=0;
 Y(columns/2:columns/2+columns/4, 1:rows/4)=0;
 Y(1:columns/4, rows/4:rows/2)=0;
Y(columns/4:columns/2, 1:rows/4)=0;
 
 
 
% %%%%Quantizer
% %Top left 4 subbands
%top left
x_coord1 = 1;
y_coord1 = 1;
x_coord2 = columns/16;
y_coord2 = rows/16;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);
%Top right
x_coord1 = columns/16;
y_coord1 = 1;
x_coord2 = columns/8;
y_coord2 = rows/16;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%Bottom Left
x_coord1 = 1;
y_coord1 = rows/16;
x_coord2 = columns/16;
y_coord2 = rows/8;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%bottom right
x_coord1 = columns/16;
y_coord1 = rows/16;
x_coord2 = columns/8;
y_coord2 = rows/8;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Top right
x_coord1 = columns/8;
y_coord1 = 1;
x_coord2 = columns/4;
y_coord2 = rows/8;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%Bottom Left
x_coord1 = 1;
y_coord1 = rows/8;
x_coord2 = columns/8;
y_coord2 = rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%bottom right
x_coord1 = columns/8;
y_coord1 = rows/8;
x_coord2 = columns/4;
y_coord2 = rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);



%%%Top right 4 subbands quantizetion
%top left
x_coord1 = columns/2; 
y_coord1 = 1;
x_coord2 = columns/2 +columns/4;
y_coord2 = rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);
%Top right
x_coord1 = columns/2+columns/4;
y_coord1 = 1;
x_coord2 = global_columns;
y_coord2 = rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%Bottom Left
x_coord1 = columns/2;
y_coord1 = rows/4;
x_coord2 = columns/2+columns/4;
y_coord2 = rows/2;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%bottom right
x_coord1 = columns/2+columns/4;
y_coord1 = rows/4;
x_coord2 = global_columns;
y_coord2 = rows/2;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%%%Bottom left 4 subbands quantization
%top left
x_coord1 =  1;
y_coord1 = rows/2;
x_coord2 = columns/4;
y_coord2 = rows/2+rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);
%Top right
x_coord1 = columns/4;
y_coord1 = rows/2;
x_coord2 = columns/2;
y_coord2 = rows/2+rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%Bottom Left
x_coord1 = 1;
y_coord1 = rows/2 +rows/4;
x_coord2 = columns/4;
y_coord2 = global_rows;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%bottom right
x_coord1 = columns/4; 
y_coord1 = rows/2+rows/4;
x_coord2 = columns/2;
y_coord2 = global_rows;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%%%Bottom right 4 subbands quantization
%top left
x_coord1 = columns/2; 
y_coord1 = rows/2;
x_coord2 = columns/2+columns/4;
y_coord2 = rows/2+rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);
%Top right
x_coord1 = columns/2+columns/4;
y_coord1 = rows/2;
x_coord2 = global_columns;
y_coord2 = rows/2+rows/4;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%Bottom Left
x_coord1 = columns/2;
y_coord1 = rows/2+rows/4;
x_coord2 = columns/2+columns/4;
y_coord2 = global_rows;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%bottom right
x_coord1 = columns/2 +columns/4; 
y_coord1 = rows/2+rows/4;
x_coord2 = global_rows;
y_coord2 = global_rows;

Y = quantizer(Y, x_coord1, y_coord1, x_coord2, y_coord2);

%%%%%%SYNTHESIS%%%%%%%
% Synthesis filter upper left-hand corner (from 22 subbands) */
  row_offset = 0;
  column_offset = 0;
  Y = synthesis_filter_columns(Y,rows/16,columns/16,row_offset,column_offset,h2,g2);
  
  row_offset = rows/16;
  column_offset = 0;
  Y = synthesis_filter_columns(Y,rows/16,columns/16,row_offset,column_offset,h2,g2);

  row_offset = 0;
  column_offset = 0;
  Y = synthesis_filter_rows(Y,rows/16,columns/8,row_offset,column_offset,h2,g2);
  
  % Synthesis filter upper left-hand corner (from 19 subbands) */
  row_offset = 0;
  column_offset = 0;
  Y = synthesis_filter_columns(Y,rows/8,columns/8,row_offset,column_offset,h2,g2);
  
  row_offset = rows/8;
  column_offset = 0;
  Y = synthesis_filter_columns(Y,rows/8,columns/8,row_offset,column_offset,h2,g2);

  row_offset = 0;
  column_offset = 0;
  Y = synthesis_filter_rows(Y,rows/8,columns/4,row_offset,column_offset,h2,g2);


%Synthesis filter upper left-hand corner (from 16 subband)

row_offset = 0;
column_offset = 0;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = rows/4;
column_offset = 0;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = 0;
column_offset = 0;
Y = synthesis_filter_rows(Y,rows/4,columns/2,row_offset,column_offset,h2,g2);
% 
% %Synthesis filter upper right-hand corner (from 16 subband)
% 
row_offset = 0;
column_offset = columns/2;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = rows/4;
column_offset = columns/2;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = 0;
column_offset = columns/2;
Y = synthesis_filter_rows(Y,rows/4,columns/2,row_offset,column_offset,h2,g2);
% % 
% % %Synthesis filter lower left-hand corner (from 16 subband)
% % 
row_offset = rows/2;
column_offset = 0;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = rows/2 + rows/4;
column_offset = 0;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = rows/2;
column_offset = 0;
Y = synthesis_filter_rows(Y,rows/4,columns/2,row_offset,column_offset,h2,g2);
% % 
% % %Synthesis filter lower right-hand corner (from 16 subband)
% % 
row_offset = rows/2;
column_offset = columns/2;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = rows/2 + rows/4;
column_offset = columns/2;
Y = synthesis_filter_columns(Y,rows/4,columns/4,row_offset,column_offset,h2,g2);
% 
row_offset = rows/2;
column_offset = columns/2;
Y = synthesis_filter_rows(Y,rows/4,columns/2,row_offset,column_offset,h2,g2);
% 
% %Synthesis filter entire image
fprintf('Synthesis-filtering level 2\n')

% %Synthesis filter upper left-hand corner 
% 
row_offset = 0;
column_offset = 0;
Y = synthesis_filter_columns(Y,rows/2,columns/2,row_offset,column_offset,h2,g2);
% 
row_offset = rows/2;
column_offset = 0;
Y = synthesis_filter_columns(Y,rows/2,columns/2,row_offset,column_offset,h2,g2);
% 
fprintf('Synthesis-filtering level 1\n')

row_offset = 0;
column_offset = 0;
Y = synthesis_filter_rows(Y,rows/2,columns,row_offset,column_offset,h2,g2);

Y = round(Y-128);
% 
for row = 1:rows
    for column = 1:columns
        if Y(row, column) < 0.0
            Y(row, column) = 0.0;
        end
        if Y(row, column) > 255.0
            Y(row,column) = 255.0;
        end
    end
end

H = X-Y;


imagesc(Y,[0,255]);
colormap(gray);
axis equal;
axis off;
psnr(Y,X)
function X = analysis_filter_rows(X,rows,columns,row_offset,column_offset,h,g)
    global x1 x2 delay z1 z2 filter_taps
    N = rows;
    for column = (column_offset+1):(columns+column_offset)
        for n = 1:delay
            x1(n) = X(delay - n + row_offset+1, column);
        end
        for n = 1:N
            x1(n + delay) = X(n + row_offset, column);
        end
        for n = N:(N + delay)
            x1(n + delay) = X(2*N - n-2+row_offset, column);
        end
        
        for n = 1:(N+2*delay)
            x2(n) = x1(n);
        end
        %%% filter even in C but filter odd in matlab
        for m = 1:2:N
            sum = 0.0;  
            for n = (m - filter_taps):m
                
                if (m-n)== 0
                    sum = sum + x1(n + filter_taps)*h(9);
                else
                    sum = sum + x1(n + filter_taps)*h(m-n);
                end
            end
            z1(m) = sum;
        end
        %%% filter odd in C but filter even in matlab
        for m = 2:2:N
            sum = 0.0;
            for n = (m - filter_taps):m
                if (m-n)== 0
                    sum = sum + x1(n + filter_taps)*g(9);
                else
                    sum = sum + x1(n + filter_taps)*g(m-n);
                end

            end
            z2(m) = sum;
        end
        %Decimate and write back low-frequency results
        for row = 1:rows/2
            X(row + row_offset, column) = z1(2*row+1);
        end
        
        %decimate and write back high-frequency result
        for row = 1:rows/2
            X(row + row_offset + rows/2, column) = z2(2*row);
        end
            
    end

end

function X = analysis_filter_columns(X,rows,columns,row_offset,column_offset,h,g)
    global x1 x2 delay z1 z2 filter_taps
    N = columns;
    for row = (row_offset+1):(rows+row_offset)
        for n = 1:delay
            x1(n) = X(row, delay - n + column_offset + 1);
        end
        for n = 1:N
            x1(n + delay) = X(row, n + column_offset);
        end
        for n = N:(N + delay)
            x1(n + delay) = X(row, 2*N - n - 2 +column_offset + 1);
        end
        
        for n = 1:(N+2*delay)
            x2(n) = x1(n);
        end
        
        for m = 1:2:N
            sum = 0.0;
            for n = (m - filter_taps):m
                if (m-n)== 0
                    sum = sum + x1(n + filter_taps)*h(9);
                else
                    sum = sum + x1(n + filter_taps)*h(m-n);
                end
                
            end
            z1(m) = sum;
        end
        
        for m = 2:2:N
            sum = 0.0;
            for n = (m - filter_taps):m
                if (m-n)== 0
                    sum = sum + x1(n + filter_taps)*g(9);
                else
                    sum = sum + x1(n + filter_taps)*g(m-n);
                end
                
            end
            z2(m) = sum;
        end
        %Decimate and write back low-frequency results
        for column = 1:columns/2
            X(row, column + column_offset) = z1(2*column+1);
        end
        
        %decimate and write back high-frequency result
        for column = 1:columns/2
            X(row, column + column_offset + columns/2) = z2(2*column);
        end
            
    end

end

function X = synthesis_filter_rows(X, rows, columns, row_offset, column_offset, h, g)
global x1 x2 z1 z2 temp delay filter_taps
N = 2*rows;
    for column = (column_offset+1):(columns+column_offset)
        for n = 1:(delay-1)/2
            x1(n) = X((delay-1)/2 - n + row_offset + 1, column);
        end
        for n = 1:rows
            x1(n + (delay-1)/2) = X(n + row_offset, column);
        end
        for n = rows:(rows + (delay-1)/2)
            x1(n + (delay-1)/2) = X(2*rows - n - 1 + row_offset, column);
        end
        
        for n = 1:(rows + delay)
            temp(2*n) = 0.0;
            temp(2*n-1) = x1(n);
        end
        
        for m = 1:2:N
            sum = 0.0;
            for n = (m - filter_taps):2:m
                sum = sum + temp(n + filter_taps)*h(m - n);
            end
            z1(m) = sum;
            
            sum = 0.0;
            for n = ((m + 2)-filter_taps):2:m
                sum = sum + temp(n+filter_taps)*h(m-n+1);
            end
            z1(m+1) = sum;
        end
        
        for n = 1:(delay-1)/2
            x2(n) = X((delay-1)/2 - n -1+row_offset +rows, column);
        end
        for n = 1:rows
            %%%
            x2(n+(delay-1)/2)= X(n+row_offset+rows, column);
        end
        for n = rows:(rows+(delay-1)/2)
            x2(n + (delay-1)/2) = X(2*rows-n-2+row_offset+rows, column);
        end
        
        for n = 1:(rows + delay)
            temp(2*n) = 0.0;
            temp(2*n+1) = x2(n);
           
        end
        
        for m = 1:2:N
            sum = 0.0;
            for n = ((m+1) - filter_taps):2:m
                sum = sum + temp(n + filter_taps)*g(m-n+1);
            end
            
            sum = 0.0;
            for n =((m+1)-filter_taps):2:(m+1)
                sum = sum + temp(n + filter_taps)*g(m-n+1);
            end
            z2(m+1) = sum;
        end
        
        for row = 1:N
            X(row + row_offset, column) = z1(row) + z2(row);
        end 
    end
end

function X = synthesis_filter_columns(X, rows, columns, row_offset, column_offset, h, g)
global x1 x2 z1 z2 temp delay filter_taps
N = 2*columns;
    for row = (row_offset+1):(rows+row_offset)
        for n = 1:(delay-1)/2
            x1(n) = X(row, (delay-1)/2 - n + column_offset+1);
        end
        for n = 1:columns
            x1(n + (delay-1)/2) = X(row, n + column_offset);
        end
        for n = columns:(columns + (delay-1)/2)
            x1(n + (delay-1)/2) = X(row, 2*columns - n - 1 + column_offset);
        end
        
        for n = 1:(columns + delay)
            temp(2*n) = 0.0;
            temp(2*n-1) = x1(n);
        end
        
        for m = 1:2:N
            sum = 0.0;
            for n = (m - filter_taps):2:m
                sum = sum + temp(n + filter_taps)*h(m - n);
            end
            z1(m) = sum;
            sum = 0.0;
            for n = ((m + 2)-filter_taps):2:m
                sum = sum + temp(n+filter_taps)*h(m-n+1);
            end
            z1(m+1) = sum;
        end
        
        for n = 1:(delay-1)/2
            x2(n) = X(row, (delay-1)/2 - n -1+column_offset +columns);
        end
        for n = 1:columns
            x2(n+(delay-1)/2)= X(row, n+column_offset+columns);
        end
        for n = columns:(columns+(delay-1)/2)
            x2(n + (delay-1)/2) = X(rows, 2*columns-n-2+column_offset+columns);
        end
        
        for n = 1:(columns + delay)           
            temp(2*n) = 0.0;
            temp(2*n-1) = x2(n);
        end
        
        for m = 1:2:N
            sum = 0.0;
            for n = ((m+1) - filter_taps):2:m
                sum = sum + temp(n + filter_taps)*g(m-n+1);
            end
            
            sum = 0.0;
            for n =((m+1)-filter_taps):2:(m+1)
                sum = sum + temp(n + filter_taps)*g(m-n+1);
            end
            z2(m+1) = sum;
        end
        
        for column = 1:N
            X(row, column + column_offset) = z1(column) + z2(column);
        end 
    end
end
function X = quantizer(X, x1, y1, x2, y2)

Aux = X(x1:x2,y1:y2);
X(x1:x2,y1:y2) = X(x1:x2,y1:y2)./((max(Aux(:)) - min(Aux(:)))/1024);

end









