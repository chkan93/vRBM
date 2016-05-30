HSeed = [137, 12, 108];
CSeed = [229, 154];



Hweight = [150, 54, 141;
           199, 65, 240;
           227, 202, 223;
           212, 167, 47];
Hbias = [111, 89, 152];


Cweight = [171, 177;51, 24; 89, 108];
Cbias = [147, 29];
ImageData = [1, 0, 0, 1];


%%%%%
% The result of first round
X = ImageData * Hweight + Hbias;
X

%% 	X = [ 473   310   340	];
