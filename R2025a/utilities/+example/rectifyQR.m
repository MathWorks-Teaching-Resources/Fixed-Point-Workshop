function varargout = rectifyQR(varargin)
%rectifyQR Rectify the QR factorization
%   [Q,R] = fixed.example.rectifyQR(Q,R) rectifies QR factors Q and R
%   such that the diagonal elements of R are positive.
%
%   R = fixed.example.rectifyQR(R) rectifies QR factor R such that the
%   diagonal elements of R are positive.

%   Copyright 2021-2022 The MathWorks, Inc.
    if nargin==1
        nargoutchk(1,1);
        R = varargin{1};
        D = diag(mysign(diag(R)));
        R(:) = D*R;
        varargout{1} = R;
    elseif nargin==2
        nargoutchk(2,2);
        if isequal(varargin{1},triu(varargin{1}))
            R = varargin{1};
            Q = varargin{2};
            D = diag(mysign(diag(R)));
            R(:) = D*R;
            Q(:) = Q*D;
            varargout{1} = R;
            varargout{2} = Q;
        else
            Q = varargin{1};
            R = varargin{2};
            D = diag(mysign(diag(R)));
            R(:) = D*R;
            Q(:) = Q*D;
            varargout{1} = Q;
            varargout{2} = R;
        end
    else
        narginchk(1,2);
    end
    
end
function S = mysign(A)
    %MYSIGN True sign function with MYSIGN(0) = 1.
    S = sign(A);
    S(S==0) = 1;
end
