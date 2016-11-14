if exist('OCTAVE_VERSION', 'builtin') ~= 0
pkg load statistics
addpath('/home/student/mexopencv')
addpath('/home/student/mexopencv/+cv/private')
else
addpath('/home/student/mexopencv-matlab')
end

addpath(genpath(pwd))
