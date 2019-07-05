classdef trabalhador < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    
    
    properties
        nome;
        saude;
        horahomem;
        limsalario;
        salario;
        ferias;
        fimdesemana;
        limdemissao;
        exibir;
    end
    
    methods
        function inicial = trabalhador
            nomeX = load("nomesAleatorios.mat");
            inicial.nome = nomeX.nomeAleatorio{randi(100)}; %escolhe um nome dentro de uma lista
            inicial.saude = randi(30)+70; %saude do trabalhador de 70% a 100%
            inicial.horahomem = 30*8; % horas de trabalho que ele pode entregar em 1 mes
            inicial.limsalario = 2000; %salario minimo limiar do trabalhador
            inicial.limdemissao = 50; % é a % de saude minima, abaixo disso ele se demite
        end
            
        function obj = avalia(obj)
            if obj.saude < obj.limdemissao % limite para se demitir  
                obj.horahomem = 0;
            end
        end
        
        function obj = definehh(obj)
         
            obj.horahomem = round(30* 8 *(1-1/12*obj.ferias)*(1-2/7*obj.fimdesemana));
        end
        
        function obj = atualiza(obj)
            ganhapouco = 0;
            if obj.salario < obj.limsalario 
                ganhapouco = 1;
                if obj.saude >= obj.limdemissao 
                    obj.saude = obj.saude - 8 - (obj.limsalario - obj.salario)/obj.limsalario*20;
                end
            end
            if obj.ferias == 0 && obj.saude >= obj.limdemissao
                obj.saude = obj.saude - round(8*(1.2+ganhapouco-obj.fimdesemana)) + 2*(obj.salario - obj.limsalario)/obj.limsalario;
                if obj.saude > 100
                    obj.saude = 100;
                end
            end
            if obj.fimdesemana ==0 && obj.saude >= obj.limdemissao
                obj.saude = obj.saude - round(10*(1.2+ganhapouco-obj.ferias)) + 2*(obj.salario - obj.limsalario)/obj.limsalario; 
                if obj.saude > 100
                    obj.saude = 100;
                end
            end
            if obj.saude < obj.limdemissao %% demite o trabalhador
                obj.horahomem = 0;
            end
            
        end
    
        function obj = atualizaexibir(obj,hora)
            if obj.horahomem ~= 0
                obj.exibir =  {obj.nome + " trabalha aqui com  " + obj.saude + " de saude."
                    "Seu salario é de "+obj.salario + " R$"
                    "Entrega " + obj.horahomem + " de horas por mês"
                    "de um total de " + hora + "horas"};
            else 
                obj.exibir =  {obj.nome + " não trabalha mais aqui."  } ;
            end
                    
        end
    end
end

