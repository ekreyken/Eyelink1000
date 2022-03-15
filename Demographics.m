function varargout = Demographics(varargin)
% DEMOGRAPHICS MATLAB code for Demographics.fig
%      DEMOGRAPHICS, by itself, creates a new DEMOGRAPHICS or raises the existing
%      singleton*.
%
%      H = DEMOGRAPHICS returns the handle to a new DEMOGRAPHICS or the handle to
%      the existing singleton*.
%
%      DEMOGRAPHICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMOGRAPHICS.M with the given input arguments.
%
%      DEMOGRAPHICS('Property','Value',...) creates a new DEMOGRAPHICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demographics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demographics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demographics

% Last Modified by GUIDE v2.5 07-Oct-2015 16:31:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demographics_OpeningFcn, ...
                   'gui_OutputFcn',  @Demographics_OutputFcn, ...
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


% --- Executes just before Demographics is made visible.
function Demographics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Demographics (see VARARGIN)

%This changes the static textbox to the questions you're asking
txtDemoInstructions = evalin('base', 'txtDemoInstructions');
    set(handles.txtDemoInstructions, 'String', txtDemoInstructions);
a = evalin('base','a');
    set(handles.a, 'String', a);
b = evalin('base', 'b');
    set(handles.b, 'String', b);
c = evalin('base', 'c');
    set(handles.c, 'String', c)   
d = evalin('base', 'd');
    set(handles.d, 'String', d)
e = evalin('base', 'e');
    set(handles.e, 'String', e)    
f = evalin('base', 'f');
    set(handles.f, 'String', f) 
    
%Change where the Gui appears:    
%pixels
set( handles.Demographics, ...
    'Units', 'pixels' );
%get your display size
screenSize = get(0, 'ScreenSize');
%calculate the center of the display
position = get( handles.Demographics, ...
    'Position' );
position(1) = (screenSize(3)-position(3))/2;
position(2) = (screenSize(4)-position(4))/2;
%center the window
set( handles.Demographics, ...
    'Position', position );

% Choose default command line output for Demographics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Demographics wait for user response (see UIRESUME)
% uiwait(handles.Demographics);


% --- Outputs from this function are returned to the command line.
function varargout = Demographics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aa_Callback(hObject, eventdata, handles)
% hObject    handle to aa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aa as text
%        str2double(get(hObject,'String')) returns contents of aa as a double

%Get what they typed
aa = get(hObject, 'String');
%Put it in the workspace
assignin('base', 'aa', aa);

% --- Executes during object creation, after setting all properties.
function aa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnDone. 
function btnDone_Callback(hObject, eventdata, handles)
% hObject    handle to btnDone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%close the form
close(handles.Demographics);



function bb_Callback(hObject, eventdata, handles)
% hObject    handle to bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bb as text
%        str2double(get(hObject,'String')) returns contents of bb as a double
%get what they wrote
bb = get(hObject, 'String');
%Put it in the workspace
assignin('base', 'bb', bb);


% --- Executes during object creation, after setting all properties.
function bb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cc_Callback(hObject, eventdata, handles)
% hObject    handle to cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc as text
%        str2double(get(hObject,'String')) returns contents of cc as a double
%Get what they typed
cc = get(hObject, 'String');
%Put it in the workspace
assignin('base', 'cc', cc);

% --- Executes during object creation, after setting all properties.
function cc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dd_Callback(hObject, eventdata, handles)
% hObject    handle to dd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dd as text
%        str2double(get(hObject,'String')) returns contents of dd as a double
%Get what they typed
dd = get(hObject, 'String');
%Put it in the workspace
assignin('base', 'dd', dd);

% --- Executes during object creation, after setting all properties.
function dd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ee_Callback(hObject, eventdata, handles)
% hObject    handle to ee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ee as text
%        str2double(get(hObject,'String')) returns contents of ee as a double
%Get what they typed
ee = get(hObject, 'String');
%Put it in the workspace
assignin('base', 'ee', ee);

% --- Executes during object creation, after setting all properties.
function ee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ff_Callback(hObject, eventdata, handles)
% hObject    handle to ff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ff as text
%        str2double(get(hObject,'String')) returns contents of ff as a double
%get what they wrote
ff = get(hObject, 'String');
%Put it in the workspace
assignin('base', 'ff', ff);

% --- Executes during object creation, after setting all properties.
function ff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
