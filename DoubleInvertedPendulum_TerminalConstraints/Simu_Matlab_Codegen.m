function Simu_Matlab_Codegen

data       = coder.load('GEN_initData.mat');
N          = data.N;
xDim       = data.xDim;

global discretizationMethod isMEnabled ...
       uMin uMax xMin xMax GMax GMin ...
       veryBigNum ...
       nonsingularRegularization descentRegularization
   
globalVariable = {'discretizationMethod',coder.Constant(discretizationMethod),...
                  'isMEnabled',coder.Constant(isMEnabled),...
                  'uMax',coder.Constant(uMax),...
                  'uMin',coder.Constant(uMin),...
                  'xMax',coder.Constant(xMax),...
                  'xMin',coder.Constant(xMin),...
                  'GMax',coder.Constant(GMax),...
                  'GMin',coder.Constant(GMin),...
                  'veryBigNum',coder.Constant(veryBigNum),...
                  'nonsingularRegularization',coder.Constant(nonsingularRegularization),...
                  'descentRegularization',coder.Constant(descentRegularization)};

cfg = coder.config('lib');
cfg.FilePartitionMethod = 'SingleFile';

cfg.TargetLang = 'C';
stackUsageMax = xDim*N/360*200000;
cfg.StackUsageMax = stackUsageMax;
cfg.BuildConfiguration = 'Faster Runs'; % no MexCodeConfig 
cfg.SupportNonFinite = false; % no MexCodeConfig

codegen -config cfg Simu_Matlab -globals globalVariable