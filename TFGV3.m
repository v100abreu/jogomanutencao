function varargout = TFGv3(varargin)
% TFGV3 MATLAB code for TFGv3.fig
%      TFGV3, by itself, creates a new TFGV3 or raises the existing
%      singleton*.
%
%      H = TFGV3 returns the handle to a new TFGV3 or the handle to
%      the existing singleton*.
%
%      TFGV3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TFGV3.M with the given input arguments.
%
%      TFGV3('Property','Value',...) creates a new TFGV3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TFGv3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TFGv3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TFGv3

% Last Modified by GUIDE v2.5 23-Feb-2019 00:47:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TFGv3_OpeningFcn, ...
                   'gui_OutputFcn',  @TFGv3_OutputFcn, ...
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


% --- Executes just before TFGv3 is made visible.
function TFGv3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TFGv3 (see VARARGIN)


%inicialização programa
handles.mesAtual = 1;
handles.valorTotal = 0;
handles.valorPARADATOTAL = 80000;
handles.horaTotal = 0;
handles.ultimoGasto = 0;
handles.maiorGasto = 0;
handles.ntrabalhadores = 0;
handles.funcionario = trabalhador;

set(handles.uitable1,'ColumnWidth',{220});
%Gera as catastrofes
tabelaproblemas = readtable("problemasTabela.csv");
handles.evento_ruim = {"Não haverá problemas no mês selecionado" , "TEMPO QUENTE" , "TEMPO FRIO"};
handles.queda_qualidade = [ 0 0.2 0.1];
handles.evento_ruim = tabelaproblemas{:,1}';
handles.queda_qualidade = tabelaproblemas{:,2};
handles.ncatastrofes = length(handles.evento_ruim)-1;

%Gera os eventos nos meses
handles.pevento = 0.3;%probabilidade de ocorrer catastrofe
handles.evento_calendario = randi(handles.ncatastrofes,6,1) .* abs(round(rand(6,1)+handles.pevento-0.5)) ;
handles.calendario = geracalendario(handles.evento_calendario);
set(handles.uitable1,'Data',handles.calendario);


idxobj = 0;

% %%Edite o primeiro Objeto

% 
% Objeto(idxobj) = parteQuebravel;
% Objeto(idxobj).nome = "rodas";
% Objeto(idxobj).idade = 2;
% Objeto(idxobj).idadeMax = 100;
% Objeto(idxobj).custo = 70;
% Objeto(idxobj).quantidade = 200;
% Objeto(idxobj).qtdnecessaria = 180;
% Objeto(idxobj).qualidade = 1;
% Objeto(idxobj).horahomem = 2;
% Objeto(idxobj).k1 = 0.6;
% Objeto(idxobj).k2 = 1;
% Objeto(idxobj).k3 = 0.03;
% Objeto(idxobj).atualiza;
% Objeto(idxobj).atualizaexibir;
% 
% handles.objeto(idxobj) = Objeto(idxobj);
% 
% 
% %Edite o segundo objeto
% 

todaspecas = readtable("parteQuebravelTabela.csv");
tamanhotabela = size(todaspecas);

for ind = 1:tamanhotabela(1)
    idxobj = idxobj +1;

    Objeto(idxobj) = parteQuebravel;
    Objeto(idxobj).nome = string(todaspecas{ind,1});
    Objeto(idxobj).idade = todaspecas{ind,2};
    Objeto(idxobj).custo = todaspecas{ind,3};
    Objeto(idxobj).quantidade = todaspecas{ind,4};
    Objeto(idxobj).qtdnecessaria = todaspecas{ind,5};
    Objeto(idxobj).qualidade = todaspecas{ind,6};
    Objeto(idxobj).horahomem = todaspecas{ind,7};
    Objeto(idxobj).k1 = todaspecas{ind,8};
    Objeto(idxobj).k2 = todaspecas{ind,9};
    Objeto(idxobj).k3 = todaspecas{ind,10};
    Objeto(idxobj).atualiza;
    Objeto(idxobj).atualizaexibir;
    
    handles.objeto(idxobj) = Objeto(idxobj);
    strlistbox1{ind} = Objeto(ind).nome;
    handles.horaTotal = handles.horaTotal + Objeto(ind).horahomemT;

end

handles.nobjetos = idxobj;
set(handles.listbox1,'String',strlistbox1);






% Choose default command line output for TFGv3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TFGv3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TFGv3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
idx = get(hObject,'Value');

set(handles.text2,'String',handles.objeto(idx).exibir);

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = get(handles.listbox1,'Value');
auxqtd = handles.objeto(idx).quantidade;

if auxqtd < ceil(handles.objeto(idx).qtdnecessaria*1.2)
    handles.objeto(idx).quantidade = auxqtd +1;
    handles.objeto(idx).atualizaexibir;
    handles.valorTotal = handles.valorTotal + handles.objeto(idx).custo;
end

set(handles.text2,'String',handles.objeto(idx).exibir);
set(handles.text7,'String',handles.valorTotal);

guidata(hObject,handles)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = get(handles.listbox1,'Value');
auxidade = handles.objeto(idx).idade;

if auxidade ~= 1
    auxqtd = handles.objeto(idx).quantidade;
    if handles.objeto(idx).idadeMax > handles.objeto(idx).idade && handles.objeto(idx).qualidade > 0.3 %reutilizavel para troca
        custo = round(handles.objeto(idx).custo * auxqtd /(handles.objeto(idx).idadeMax - handles.objeto(idx).idade)+(1-handles.objeto(idx).qualidade)*handles.objeto(idx).custo);
    else % antigos inutilizaveis para troca
        custo = round(handles.objeto(idx).custo * auxqtd);
    end
    handles.objeto(idx).idade = 1;
    handles.objeto(idx).qualidade = 1;
    handles.objeto(idx).atualiza;
    handles.objeto(idx).atualizaexibir;
    handles.valorTotal = handles.valorTotal + custo;
end

set(handles.text2,'String',handles.objeto(idx).exibir);
set(handles.text7,'String',handles.valorTotal);

guidata(hObject,handles)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles) %BOTÃO CONTRATAR
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.ntrabalhadores = handles.ntrabalhadores +1;


handles.funcionario(handles.ntrabalhadores).fimdesemana = get(handles.checkbox1,'Value');
handles.funcionario(handles.ntrabalhadores).ferias = get(handles.checkbox2,'Value');
handles.funcionario(handles.ntrabalhadores).salario = str2double(get(handles.edit1,'String'));
handles.funcionario(handles.ntrabalhadores).definehh;

handles.n_ativos = 0;
handles.n_horas = 0;
for idx = 1:handles.ntrabalhadores
    if handles.funcionario(idx).horahomem ~= 0
        handles.n_ativos = handles.n_ativos + 1;
        handles.n_horas = handles.n_horas + handles.funcionario(idx).horahomem;
    end
    handles.funcionario(idx).atualizaexibir(handles.horaTotal);
    strlistbox2{idx} = handles.funcionario(idx).nome;
end

% for i = 1:handles.ntrabalhadores % gera a tabela de trabalhadores
%         handles.funcionario.atualizaexibir
%         strlistbox2{i} = handles.funcionario(i).nome;
% end

set(handles.listbox2,'String',strlistbox2);
    
set(handles.text2,'String',{"Novo funcionario adicionado" 
    "Voce possui "+handles.n_ativos+" funcionarios ativos" 
    "Que atendem "+handles.n_horas+" horas homem de serviço"});


guidata(hObject,handles)

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
idx = get(hObject,'Value');
frase = get(hObject,'String');
frase2 = "Os funcionarios serão adicionados aqui";   

set(handles.text2,'String',handles.funcionario(idx).exibir);

if strcmp(frase, frase2)
    set(handles.text2,'String',"Contrate funcionarios através do botão contratar");
end
 

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles) %BOTÃO DEMITIR
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

idx = get(handles.listbox2,'Value');

handles.funcionario(idx).horahomem = 0;


handles.n_ativos = 0;
handles.n_horas = 0;
for idx = 1:handles.ntrabalhadores
    if handles.funcionario(idx).horahomem ~= 0
        handles.n_ativos = handles.n_ativos + 1;
        handles.n_horas = handles.n_horas + handles.funcionario(idx).horahomem;
    end
    handles.funcionario(idx).atualizaexibir(handles.horaTotal);
end



set(handles.text2,'String',{"Funcionario demitido" 
    "Voce possui "+handles.n_ativos+" funcionarios ativos" 
    "Que atendem "+handles.n_horas+" horas homem de serviço"});


guidata(hObject,handles)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flagdemitidos = 0;
flagPARADA = 0;
handles.n_horas = 0;

%Ocorrencia da mudança de mês

for i = 1:handles.ntrabalhadores
    if handles.funcionario(i).horahomem ~= 0
        handles.funcionario(i).atualiza;
        handles.funcionario(i).atualizaexibir(handles.horaTotal);
        handles.n_horas = handles.n_horas + handles.funcionario(i).horahomem;
        if handles.funcionario(i).horahomem ~= 0 
            aux = handles.valorTotal + handles.funcionario(i).salario;
            handles.valorTotal = aux;
        else
            flagdemitidos = flagdemitidos+1;
        end
    end
end
set(handles.text7,'String',handles.valorTotal);

for i = 1:handles.nobjetos%CONTINUAR AQUI
    handles.objeto(i).atualiza;
    if handles.objeto(i).limite >= 1 && handles.objeto(i).quantidade > 0
        restante1 = handles.objeto(i).quantidade - randi(round(handles.objeto(i).qtdnecessaria*0.1));
        handles.objeto(i).quantidade = restante1;
    end
    
    if (0.1 *(handles.horaTotal - handles.n_horas)/ handles.n_horas) < 0.3
        qualidadeAtual = handles.objeto(i).qualidade - 0.1 *(handles.horaTotal - handles.n_horas)/ handles.n_horas;
    else
        qualidadeAtual = handles.objeto(i).qualidade - 0.3;
    end
    
     
     if qualidadeAtual <= 0 && handles.objeto(i).quantidade > 0
         restante2 = handles.objeto(i).quantidade - randi(round(handles.objeto(i).qtdnecessaria*0.25));
         handles.objeto(i).quantidade = restante2;
         qualidadeAtual = 0.4;
     elseif qualidadeAtual > 1
         qualidadeAtual =1;
     end
     handles.objeto(i).qualidade = qualidadeAtual;
     if handles.objeto(i).quantidade < handles.objeto(i).qtdnecessaria && flagPARADA == 0
         aux1 = handles.valorTotal + handles.valorPARADATOTAL;
         flagPARADA = 1;
         handles.valorTotal = aux1;
     end
     
     set(handles.text7,'String',handles.valorTotal);
     handles.objeto(i).aumentaIdade;
     handles.objeto(i).atualizaexibir;
end

        

if handles.valorTotal - handles.ultimoGasto > handles.maiorGasto
    handles.maiorGasto = handles.valorTotal - handles.ultimoGasto;
end
handles.ultimoGasto = handles.valorTotal;
fatorDemanda = handles.maiorGasto/(handles.valorTotal/handles.mesAtual);
set(handles.text9,'String',fatorDemanda);

%Atuação de catastrofes sobre os equipamentos
if handles.evento_calendario(1) > 0
    for i = 1:handles.nobjetos
         qualidadeAtual = handles.objeto(i).qualidade - handles.queda_qualidade(handles.evento_calendario(1)+1);
         handles.objeto(i).qualidade = qualidadeAtual;
    end
end
      

handles.mesAtual = handles.mesAtual +1;

for i = 1:handles.nobjetos
    handles.objeto(i).atualiza;
    if handles.objeto(i).limite >= 1 || rand/handles.objeto(i).limite < 1 % função que diz se algum objeto vai quebrar ou nao
        restante = handles.objeto(i).quantidade - randi(round(handles.objeto(i).qtdnecessaria*0.25));
        handles.objeto(i).quantidade = restante;
    end
        

end

set(handles.text5,'String',handles.mesAtual);
auxcld = atzcalendario(handles.evento_calendario,handles.ncatastrofes,handles.pevento);
handles.evento_calendario = auxcld;
handles.calendario = geracalendario(handles.evento_calendario);
set(handles.uitable1,'Data',handles.calendario);


%texto relatorio mensal
linha0 = "Relatorio Mensal:";
if flagdemitidos == 0
    linha1 = "Não houveram demissões";
else
    linha1 = flagdemitidos + " pessoas não trabalham mais aqui";
end

if flagPARADA == 0
    linha2 = "Não houve parada total";
else
    linha2 = "Houve parada TOTAL, perda da produção em " + handles.valorPARADATOTAL + " R$";
end
todaslinhas = { linha0
                linha1
                linha2};
set(handles.text2, 'String' , todaslinhas);

guidata(hObject,handles)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(eventdata.Indices)
    handles.currentCell=eventdata.Indices;
    
    Indices=handles.currentCell;
    dado=handles.evento_calendario;
    dado=dado(Indices(1),Indices(2));
    exibe_dado = handles.evento_ruim{dado+1};
set(handles.text2,'String', exibe_dado);
end

guidata(hObject,handles)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i = 1:10 %Apenas executa o botao 1 10 vezes
    % COPIA DO CODIGO DO BOTAO 1
    
        idx = get(handles.listbox1,'Value');
    auxqtd = handles.objeto(idx).quantidade;

    if auxqtd < ceil(handles.objeto(idx).qtdnecessaria*1.2)
        handles.objeto(idx).quantidade = auxqtd +1;
        handles.objeto(idx).atualizaexibir;
        handles.valorTotal = handles.valorTotal + handles.objeto(idx).custo;
    end

    set(handles.text2,'String',handles.objeto(idx).exibir);
    set(handles.text7,'String',handles.valorTotal);

%FIM DA COPIA DO BOTAO 1
    
    
    
end

guidata(hObject,handles)
