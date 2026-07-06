function [theta_in_range, needToNegate] = cordiccexpInputQuadrantCorrection(theta_input)
    % cordiccexpInputQuadrantCorrection

    % Copyright 2009-2022 The MathWorks, Inc.
    %#codegen
    coder.allowpcode('plain');
    if coder.internal.isAmbiguousTypes()
        theta_in_range = zeros(size(theta_input));
        needToNegate = zeros(size(theta_input));
        return
    end
    
    theta = upcastInput(theta_input);
    needToNegate   = false(size(theta));
    
    if isfi(theta) && isfixed(theta) && ...
            ((theta.WordLength - theta.FractionLength - issigned(theta)) <= 0)
        % theta is guaranteed to be in the range [-pi/2,pi/2] with
        % this type.
        theta_in_range = theta;
        return;
    end

    % Get the correct NumericType "flavors" of pi/2 constants
    [theta_in_range,piOver2,onePi,twoPi] = initialize_variables(theta);

    for idx = 1:numel(theta)
        thetaMinusOnePi = theta(idx) - onePi;
        thetaPlusOnePi  = theta(idx) + onePi;
        thetaMinusTwoPi = theta(idx) - twoPi;
        thetaPlusTwoPi  = theta(idx) + twoPi;
        if cast(theta(idx),'like',piOver2) > piOver2
            % Convert an angle in range (pi/2 2*pi]
            %  to an angle in range [-pi/2 pi/2]:
            if (thetaMinusOnePi <= piOver2)
                % Need to subtract PI to get into [-pi/2 pi/2] range
                theta_in_range(idx) = thetaMinusOnePi;
                needToNegate(idx)   = 1;
            else
                % Need to subtract 2*PI to get into [-pi/2 pi/2] range
                theta_in_range(idx) = thetaMinusTwoPi;
            end

        elseif (cast(theta(idx),'like',piOver2) < -piOver2)
            % Convert an angle in range [-2*pi -pi/2)
            %  to an angle in range [-pi/2 pi/2]:
            if (thetaPlusOnePi >= -piOver2)
                % Need to add PI to get into [-pi/2 pi/2] range
                theta_in_range(idx) = thetaPlusOnePi;
                needToNegate(idx)   = 1;
            else
                % Need to add 2*PI to get into [-pi/2 pi/2] range
                theta_in_range(idx) = thetaPlusTwoPi;
            end
        else
            % No quadrant correction necessary
            theta_in_range(idx) = theta(idx);
        end
    end
    theta_in_range = removefimath(theta_in_range);
end

function [theta_in_range,piOver2,onePi,twoPi] = initialize_variables(theta)
    % Initialize variables.
    if isfloat(theta)
        % Floating point
        theta_in_range = zeros(size(theta),'like',theta);
        piOver2 = cast(pi/2,'like',theta);
        onePi = cast(pi,'like',theta);
        twoPi = cast(2*pi,'like',theta);
        % Empty fimath for float.
    else
        % Integer and fixed-point
        % Cast to fi in case theta is a builtin integer.  If theta is
        % already fi, then this is a no-op.
        theta = fi(theta);
        % theta_in_range is in the range [-pi/2, pi/2], so signed with
        % fractionLength = wordLength - 2 is a tight fit.  Don't go lower
        % than 16 bit word length so sine is always accurate to 16 bits.
        wordLength = max(16,theta.WordLength);
        theta_in_range = fi(zeros(size(theta)),1,wordLength,wordLength - 2);
        % Make the constants all have the same type as 2*pi because
        % the comparisons with theta will have to be cast to their
        % type to avoid going over 128 bits in code generation.
        twoPi = fi(2*pi,1,wordLength);
        onePi = cast(pi,'like',twoPi);
        piOver2 = cast(pi/2,'like',twoPi);
    end
    % Add fimath after using nearest rounding while constructing the
    % constants.  Setting empty fimath on float is a no-op. Set the fimaths
    % so adding or subtracting these values stays in the same type.
    theta_in_range = setfimath(theta_in_range,fixed.fimathLike(theta_in_range));
    twoPi = setfimath(twoPi,fixed.fimathLike(twoPi));
    onePi = setfimath(onePi,fixed.fimathLike(onePi));
    piOver2 = setfimath(piOver2,fixed.fimathLike(piOver2));
end

function theta = upcastInput(theta_input0)
    %upcastInput Upcast input to signed and adjust fraction length
    theta_input1 = integerToFi(theta_input0);
    theta_input2 = upcastUnsignedToSigned(theta_input1);
    theta = moveFractionLengthUp(theta_input2);
    theta = removefimath(theta);
end
function  theta_input1 = integerToFi(theta_input0)
    if isinteger(theta_input0)
        % Convert builtin integers to fixed point.
        theta_input1 = fi(theta_input0);
    else
        theta_input1 = theta_input0;
    end
end
function theta_input2 = upcastUnsignedToSigned(theta_input1)
    %upcastUnsignedToSigned Upcast unsigned to signed
    if isfi(theta_input1) && isscaledtype(theta_input1) && ~issigned(theta_input1)
        % Upcast unsigned to signed
        if (theta_input1.WordLength - theta_input1.FractionLength) <= 3
            % The input is in the range [-2*pi, 2*pi), so
            % there is a possibility of overflow, so add an addition bit to
            % the wordlength when casting from unsigned to signed.
            theta_input2 = fi(theta_input1,1,theta_input1.WordLength+1,theta_input1.FractionLength,'DataType',theta_input1.DataType);
        else
            % The input is in the range [-2*pi, 2*pi), so there is
            % no possibility of overflow, so keep the same wordlength when
            % casting unsigned to signed.
            theta_input2 = fi(theta_input1,1,theta_input1.WordLength,theta_input1.FractionLength,'DataType',theta_input1.DataType);
        end
    else
        theta_input2 = theta_input1;
    end
end
function theta = moveFractionLengthUp(theta_input2)
    %moveFractionLengthUp Move fraction length up if you can
    if isfi(theta_input2) && isscaledtype(theta_input2) && ((theta_input2.WordLength - theta_input2.FractionLength) > 4)
        % Move fraction length up.  It's guaranteed that -2pi <=
        % theta < 2pi, so this cast will happen without
        % quantization or overflow.
        theta = fi(theta_input2,1,theta_input2.WordLength,theta_input2.WordLength-4,'DataType',theta_input2.DataType);
    else
        theta = theta_input2;
    end
end