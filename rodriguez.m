%% Rotation matrix or Rotated vector according to rodriguez formula
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Basic theory of Rodriguez Rotation is as follows.
% vout = Rotmat * vin
% where, Rotmat = eye(3)
%               + sin(theta) * N
%               + [1-cos(theta)] * N^2
% and matrix N is defined as follows,
%     | 0  -n3 +n2|
% N = |+n3   0 -n1|
%     |-n2 +n1   0|
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If there are two inputs, then each should be arranged as follows.
% input 1 : nAxis, three element vector, which is rotation axis vector, 
%           normalization will be done automatically.
% input 2 : theta [radian], one element, rot degree according to nAxis.
% output  : Rotmat, 3x3 matrix, rotation matrix according to two inputs.
% (ex) Rotmat = rodriguez(nAxis,theta)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If there are three inputs, then each should be arranged as follows.
% input 1 : nAxis, three element vector, which is rotation axis vector, 
%           normalization will be done automatically.
% input 2 : theta [radian], one element, rot degree according to nAxis.
% input 3 : vin, three element vector, vector to be rotated.
%           whether vin is 3 x 1 or 1 x 3, output will be 3 x 1.
% output  : vout, 3 element vector, rotation matrix according to two inputs.
% (ex) vout = rodriguez(nAxis,theta,vin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Fout=rodriguez(varargin)
    
    if length(varargin) > 3
        error("Input element number should be 2 or 3");
    end
    
    if length(varargin) == 2        
        nAxis = varargin{1};  theta = varargin{2};
        
        if length(nAxis) ~= 3
            error("First input, nAxis should be 3-vector");
        end
        if length(theta) ~= 1
            error("second input, theta should be scalar, in radian");
        end

        nAxis = squeeze(nAxis);  nAxis = nAxis / norm(nAxis);
        theta = squeeze(theta);

        N = [ 0.000000, -nAxis(3),  nAxis(2) ; ...
              nAxis(3),  0.000000, -nAxis(1) ; ...
             -nAxis(2),  nAxis(1),  0.000000 ];

        Rotmat = eye(3) + sin(theta) * N + (1 - cos(theta)) * N * N;
        Fout = Rotmat;
    elseif length(varargin) == 3
        nAxis = varargin{1};  theta = varargin{2};  vin = varargin{3};
        if length(nAxis) ~= 3
            error("First input, nAxis should be 3-vector");
        end
        if length(theta) ~= 1
            error("second input, theta should be scalar, in radian");
        end
        if length(vin) ~= 3
            error("Third input, vin should be 3-vector");
        end        

        nAxis = squeeze(nAxis);  nAxis = nAxis / norm(nAxis);
        theta = squeeze(theta);
        vin = squeeze(vin);  vin_col = zeros(3,1);
        vin_col(1) = vin(1);  vin_col(2) = vin(2);  vin_col(3) = vin(3);

        N = [ 0.000000, -nAxis(3),  nAxis(2) ; ...
              nAxis(3),  0.000000, -nAxis(1) ; ...
             -nAxis(2),  nAxis(1),  0.000000 ];

        Rotmat = eye(3) + sin(theta) * N + (1 - cos(theta)) * N * N;
        
        vout = Rotmat * vin_col;
        Fout = vout;
    end
end