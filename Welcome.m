function varargout = Welcome(varargin)
% WELCOME MATLAB code for Welcome.fig
%      WELCOME, by itself, creates a new WELCOME or raises the existing
%      singleton*.
%
%      H = WELCOME returns the handle to a new WELCOME or the handle to
%      the existing singleton*.
%
%      WELCOME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WELCOME.M with the given input arguments.
%
%      WELCOME('Property','Value',...) creates a new WELCOME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Welcome_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Welcome_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Welcome

% Last Modified by GUIDE v2.5 05-Oct-2015 16:08:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Welcome_OpeningFcn, ...
                   'gui_OutputFcn',  @Welcome_OutputFcn, ...
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


% --- Executes just before Welcome is made visible.
function Welcome_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Welcome (see VARARGIN)

%This changes the static textbox to the instructions
WelcomeInstructions = evalin('base','WelcomeInstructions');
    set(handles.txtWelcome, 'String', WelcomeInstructions);
Researcher= evalin('base','Researcher');
    set(handles.txtResearcher, 'String', Researcher);
ParID = evalin('base','ParID');
    set(handles.txtParID, 'String', ParID);

%Change where the Gui appears:    
%pixels
set( handles.Welcome, ...
    'Units', 'pixels' );
%get your display size
screenSize = get(0, 'ScreenSize');
% %calculate the center of the display
% position = get( handles.Welcome, ...
%     'Position' );
% position(1) = (screenSize(3)-position(3))/2;
% position(2) = (screenSize(4)-position(4))/2;
% %center the window
% set( handles.Welcome, ...
%     'Position', position );

% Choose default command line output for Welcome
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Welcome wait for user response (see UIRESUME)
% uiwait(handles.Welcome);


% --- Outputs from this function are returned to the command line.
function varargout = Welcome_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtWelcome_Callback(hObject, eventdata, handles)
% hObject    handle to txtWelcome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function txtWelcome_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWelcome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in btnOK.
function btnOK_Callback(hObject, eventdata, handles)
% hObject    handle to btnOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Close the form
close(handles.Welcome)


function txtParticID_Callback(hObject, eventdata, handles)
% hObject    handle to txtParticID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of txtParticID as text
%        str2double(get(hObject,'String')) returns contents of txtParticID as a double

%Get what they typed
ParticipantID = get(hObject, 'String');
%Put it in the workspace
assignin('base', 'ParticipantID', ParticipantID);



% --- Executes during object creation, after setting all properties.
function txtParticID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtParticID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
