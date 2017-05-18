function varargout = GUI_FP(varargin)
% GUI_FP MATLAB code for GUI_FP.fig
%      GUI_FP, by itself, creates a new GUI_FP or raises the existing
%      singleton*.
%
%      H = GUI_FP returns the handle to a new GUI_FP or the handle to
%      the existing singleton*.
%
%      GUI_FP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FP.M with the given input arguments.
%
%      GUI_FP('Property','Value',...) creates a new GUI_FP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_FP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_FP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_FP

% Last Modified by GUIDE v2.5 18-May-2017 06:20:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_FP_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_FP_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_FP is made visible.
function GUI_FP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_FP (see VARARGIN)

% Choose default command line output for GUI_FP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_FP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_FP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, user_canceled] = imgetfile;
if (user_canceled == 0)
    I = imread(filename);
    handles.I = I;
    guidata(hObject,handles);
    axes(handles.axes7);
    imshow(I);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = handles.I;
gray = rgb2gray(I);
fiturLBP = LBP(gray,true);
axes(handles.axes1);
bar(fiturLBP);
%set(handles.prediksi,'string',size(fiturLBP));
%processing image
%{
preprocessedDisk = Preprocessing(I(:,:,1),'disk');
preprocessedCup = Preprocessing(I(:,:,2),'cup');
[disk,index,diskArea] = DiscSegmentation(I);
[cup,cupArea] = SegmenCup(I);
blood = BloodVessel(I(:,:,2),disk);

%cropping
[row,col]=find(disk);
row_t = min(row);
col_t = min(col);
%%%%%%%%%%%%%
disk = imcrop(disk,[col_t row_t max(col)-col_t max(row)-row_t]);
%%%%%%%%%%%%%
cup = imcrop(cup,[col_t row_t max(col)-col_t max(row)-row_t]);
%%%%%%%%%%%%%
blood = imcrop(blood,[col_t row_t max(col)-col_t max(row)-row_t]);
%%%%%%%%%%%%%
%viewing image
axes(handles.axes2);
imshow(blood);
axes(handles.axes3);
imshow(255-preprocessedDisk);
axes(handles.axes4);
imshow(disk);
axes(handles.axes5);
imshow(255-preprocessedCup);
axes(handles.axes6);
imshow(cup);

%extracting feature
CupToDiskRatio = sqrt(cupArea/diskArea);
bloodISNT = ISNTBlood(blood);
[imNrr,nrrISNT] = NRR(cup,disk);
axes(handles.axes1);
imshow(imNrr);
newData = csvread('newdataTA_Train.csv');
newDataset = [newData(:,1) newData(:,2) newData(:,3)];
newGroup = newData(:,4);
svmModel = svmtrain(newDataset, newGroup, ...
                 'Autoscale',true, 'Showplot',false, 'Method','LS', ...
                 'BoxConstraint',2e-1, 'Kernel_Function','rbf','rbf_sigma',0.2);
pred = svmclassify(svmModel, [CupToDiskRatio nrrISNT bloodISNT], 'Showplot',false);
if pred == 1
    set(handles.edit3,'string','Glaukoma');
else
    set(handles.edit3,'string','Normal');
end

%}
