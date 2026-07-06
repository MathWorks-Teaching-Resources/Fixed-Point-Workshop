function R = makeRotationMatrix(phi,theta,psi)
    R = [cos(theta)*cos(psi) sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi) sin(phi)*sin(psi)+cos(phi)*sin(theta)*cos(psi)
         cos(theta)*sin(psi) cos(phi)*cos(psi)+sin(phi)*sin(psi)*sin(theta) cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi)
         -sin(theta)         sin(phi)*cos(theta)                              cos(phi)*cos(theta)];
end