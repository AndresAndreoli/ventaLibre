unit TDAArbolesAVL;

interface
uses
    TiposYconstantes, SysUtils, Dialogs;

const
  _PosNula=TiposYconstantes._PosNula;

type
  registroDatos = record
  				          Clave:              TiposYconstantes.tipoClave;               // ID Publicado
	  			          IDCategoria:        TiposYconstantes.TipoPosicion;            // Tomado de CATEGORIA.DAT
		  		          IDVendedor:         TiposYconstantes.TipoPosicion;            // Tomado de USUARIOS.DAT
			  	          NombreArticulo:     TiposYconstantes.TipoInfo;
				            descripcion:        TiposYconstantes.TipoDescripcion;         // Detalle del producto
				            precio:             TiposYconstantes.TipoPrecio;
				            fechapublicacion:   TiposYconstantes.TipoFecha;
				            fechacierre:        TiposYconstantes.TipoFecha;
				            tipoArticulo:       TiposYconstantes.TipoEstado;              // 1=usado, 2=nuevo
                    estadoPublicacion:  TiposYconstantes.TipoEstado;              // 1=publicado, 2=pausado, 3=vendido, 4=anulado, 5=bloqueado por el administrador del sistema
				            nombreFoto:         TiposYconstantes.TipoFoto;
				            siguiente:          TiposYconstantes.TipoEnlace;              // Borrados Pos datos
                    provincia:          TiposYconstantes.TipoProvincia;           // Provincia del Publicador del articulo
                    // Campos Extras
                    IDcomprador:        TiposYconstantes.TipoPosicion;            // Comprador Articulo
                    mailComprador:      TiposYconstantes.tipoClave;               {Los almaceno en el caso que}
                    mailVendedor:       TiposYconstantes.tipoClave;               {alguno de los 2 usuarios se da de baja}
                  end;

  registroIndice= record
			              Clave:                           TiposYconstantes.tipoClave;//es una clave compuesta que creo yo en el metodo, no esta definida en el tp
			              Id:                              TiposYconstantes.TipoPosicion; // ID vendedor o categoria
			              Padre,hijoIzquierdo,hijoDerecho: TiposYconstantes.TipoPosicion; // Enlaces
			              nivel:                           TiposYconstantes.TipoPosicion;
			              posicion:                        TiposYconstantes.TipoPosicion; // posicion del elemento en PUBLICADOS.DAT
			            end;

	registroControl=Record
			              ultimoId:           TiposYconstantes.TipoPosicion;          // Autoincremental - Inicia en 0
			              Raiz1,Borrados1:  TiposYconstantes.TipoPosicion;
			              Raiz2,Borrados2:  TiposYconstantes.TipoPosicion;
			              BorradosVentas:     TiposYconstantes.TipoPosicion;
			            end;
			
	tipoArchivoDatos=file of registroDatos;
	tipoArchivoIndiceCat=file of registroIndice;
	tipoArchivoIndiceVen=file of registroIndice;
	tipoArchivoControl=file Of registroControl;


	tipoArticulos=record
      D:tipoArchivoDatos;
			C:tipoArchivoControl;
      I1:tipoArchivoIndiceVen;
			I2:tipoArchivoIndiceCat;
      end;

procedure Crear (var Me: tipoArticulos; Ruta,Nombre:String);
Procedure Abrir(var Me:tipoArticulos);
Procedure Cerrar(var Me:tipoArticulos);
Procedure Destruir(var Me:tipoArticulos);
Function vacio(var Me: tipoArticulos; esArbolUno:boolean):Boolean;  // true=tipoArticulos vacio; false=tipoArticulos no vacio
Function UltimoID(var me: tipoArticulos): integer;

Function Buscar(Var Me:tipoArticulos; Var Pos:tipoposicion; Clave:tipoClave; esArbolUno:boolean):Boolean; //necesita
Procedure Insertar(var Me: tipoArticulos;reg:registroIndice; regDat:registroDatos; Pos:tipoposicion; esArbolUno:boolean; var posEnDatos:tipoposicion);//necesita
Procedure Eliminar(var Me: tipoArticulos; Pos:tipoposicion; esArbolUno:boolean); //necesita
Procedure Capturar(var Me: tipoArticulos;  Pos:tipoposicion; var reg:registroIndice; esArbolUno:boolean); //necesita
Procedure capturarDatos(var Me: tipoArticulos; Pos:tipoposicion; var regDatos:registroDatos);
Procedure Modificar(var Me: tipoArticulos; pos:tipoposicion; reg:registroDatos);

Function Padre(var Me: tipoArticulos; var Reg: registroIndice): tipoposicion; //Donde se encuentra el padre del registro que le pasas
function hijoDerecho(var Me: tipoArticulos; pos: tipoposicion; esArbolUno:boolean): tipoposicion;  // Donde se encuentra el hijo derecho del registro que le pasas
function hijoIzquierdo(var Me: tipoArticulos; pos: tipoposicion; esArbolUno:boolean): tipoposicion;  // Donde se encuentra el hijo izquierdo del registro que le pasas

function PosNula(Var Me:tipoArticulos):tipoposicion; //Posicion nula del ME
Function ClaveNodo(var Me: tipoArticulos; reg: registroIndice):string; //tipoClave del registro que le pasamos


//-------------------------trabajando con las dos raices---------------------------------------------
procedure setRaiz(var Me: tipoArticulos; pos:tipoposicion; esUno:boolean);
procedure setBorrados(var Me: tipoArticulos; pos:tipoposicion; esUno:boolean);
procedure setBorradosVentas(var Me: tipoArticulos; pos:tipoposicion);

function getRaiz(var Me: tipoArticulos; esUno:boolean): tipoposicion;
function getBorrados(var Me: tipoArticulos; esUno:boolean): tipoposicion;
function getBorradosVentas(var Me: tipoArticulos): tipoposicion;

//----------------------------los registros-----------------------------
procedure leerIndice(var Me: tipoArticulos; pos:tipoposicion;var reg:registroIndice; esArbolUno:boolean);
procedure grabarIndice(var Me: tipoArticulos; pos:tipoposicion; reg:registroIndice; esArbolUno:boolean);

/////////////////////////Balanceo//////////////////////////////////////////////////

procedure ProfundidadDelArbol(var me:tipoArticulos; Raiz:tipoposicion;  var Profundidad:tipoPOsicion; esArbolUno:boolean);
Function ProfundidadDelNodo(me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean): integer;  //
Procedure DisminuirNiveles(var me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean);      //
Procedure AumentarNiveles(var me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean);

Procedure DerechaDerecha(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);     //
Procedure IzquierdaIzquierda(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);      //
Procedure IzquierdaDerecha(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);     //
Procedure DerechaIzquierda(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);     //
Function FactorEquilibrio(me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean): integer; //
Procedure CasoDeDesequilibrio(me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);    //
Procedure Indice(me: tipoArticulos; raiz: tipoposicion; var PosNodo: tipoposicion; Var Balance: boolean; esArbolUno:boolean);
procedure BalancearArbol(var me: tipoArticulos; esArbolUno:boolean);    //
Procedure AcomodarNiveles(var me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean);

implementation

 procedure crear (var Me: tipoArticulos; Ruta,Nombre:String);
 var FaltaControl,FaltaDatos:Boolean;
	FaltaIndice1,FaltaIndice2:Boolean;
	Rc: registroControl;
   begin
     assign (Me.D,ruta+Nombre+'.dat');
     assign (Me.I1,ruta+Nombre+'.ntx_1');
     assign (Me.I2,ruta+Nombre+'.ntx_2');
     assign (Me.C,ruta+Nombre+'.con');
    {$i-}
    Reset(Me.D);
    FaltaDatos:=(Ioresult<>0);
    Reset(Me.C);
    FaltaControl:=(Ioresult<>0);
    Reset(Me.I1);
    FaltaIndice1:=(ioResult<>0);
	  Reset(Me.I2);
    FaltaIndice2:=(ioResult<>0);
    If ((faltaControl) or (FaltaIndice1) or (FaltaIndice2) or (FaltaDatos) ) then
      begin
        Rewrite(Me.C);
        //Se incializan las variables de control
        Rc.Raiz1:=_PosNula;
        Rc.Raiz2:=_PosNula;
        Rc.Borrados1:=_PosNula;
        Rc.Borrados2:=_PosNula;
        Rc.BorradosVentas:=_PosNula;
        Rc.ultimoId:=_PosNula;
        Write(Me.C,Rc);
        Rewrite(me.i1);
        Rewrite(me.D);
        Rewrite(me.i2);
        Close(me.i1);
        Close(Me.D);
		    Close(me.i2);
        Close(Me.C);
      end;
     end;

procedure Abrir(var Me:tipoArticulos);     
begin
  Reset(me.i1);
  Reset(me.i2);
  Reset(Me.C);
  Reset(Me.D);
end;

procedure Cerrar(var Me:tipoArticulos);    
begin
  Close(me.i1);
  Close(me.i2);
  Close(Me.C);
  Close(Me.D);
end;

procedure Destruir(var Me:tipoArticulos);
begin
  Erase(me.i1);
  Erase(me.i2);
  Erase(Me.C);
  Erase(Me.D);
end;

//--------------------------------------trabajando con los indices--------------------------------------------
procedure leerIndice(var Me: tipoArticulos; pos:tipoposicion;var reg:registroIndice; esArbolUno:boolean);
begin
	if(esArbolUno)then
	begin
		seek(me.i1,pos);
		read(me.i1,reg);
	end
	else
	begin
		seek(me.i2,pos);
		read(me.i2,reg);
	end;
end;

procedure grabarIndice(var Me: tipoArticulos; pos:tipoposicion; reg:registroIndice; esArbolUno:boolean);
begin
	if(esArbolUno)then
	begin
		seek(me.i1,pos);
		write(me.i1,reg);
	end
	else
	begin
		seek(me.i2,pos);
		write(me.i2,reg);
	end;
end;

//-----------------------------------trabajando con dobles raices---------------------------------------------

procedure setRaiz(var Me: tipoArticulos; pos:integer; esUno:boolean);
var rc,nuevo:registroControl;
begin

 seek(me.C,0);
 read(me.c,rc);
 if esUno then
    rc.Raiz1:=pos
 else
    rc.Raiz2:=pos;
 seek(me.C,0);
 write(me.c,rc);

end;

procedure setBorrados(var Me: tipoArticulos; pos:tipoposicion; esUno:boolean);
var rc:registroControl;
begin
	seek(me.c,0);
	read(me.c,rc);
	if esUno then
		rc.borrados1:=pos
	else	
		rc.borrados2:=pos;
	seek(me.c,0);
	write(me.c,rc);
end;

procedure setBorradosVentas(var Me: tipoArticulos; pos:tipoposicion);
var rc:registroControl;
begin
	seek(me.c,0);
	read(me.c,rc);
	rc.borradosVentas:=pos;
	seek(me.c,0);
	write(me.c,rc);
end;

function getRaiz(var Me: tipoArticulos; esUno:boolean): tipoposicion;
var rc:registroControl; raiz:tipoposicion;
begin
	seek(me.c,0);
	read(me.c,rc);
	if esUno then
		raiz:=rc.raiz1
	else
		raiz:=rc.raiz2;
	getRaiz:=raiz;
end;

function getBorrados(var Me: tipoArticulos; esUno:boolean): tipoposicion;
var rc:registroControl; borrado:tipoposicion;
begin
	seek(me.c,0);
	read(me.c,rc);
	if esUno then
		borrado:=rc.borrados1
	else
		borrado:=rc.borrados2;
	getBorrados:=borrado;
end;

function getBorradosVentas(var Me: tipoArticulos): tipoposicion;
var rc:registroControl;
begin
	seek(me.c,0);
	read(me.c,rc);
	getBorradosVentas:=rc.borradosVentas;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function buscar(Var Me:tipoArticulos; Var Pos:tipoposicion; Clave:tipoClave; esArbolUno:boolean):Boolean;  //ok
var	encontrado:Boolean; rc:registroControl;
	RegAux:registroIndice; PosPadre:tipoposicion;
begin
	Encontrado:=False;
	Seek(Me.C,0);
	Read(Me.C,Rc);
	Pos:=getRaiz(me,esArbolUno);
	PosPadre:=_PosNula;
     
		While (Not Encontrado) and (Pos<>_PosNula) Do
			Begin
				leerIndice(me,Pos,regAux,esArbolUno);
				If (RegAux.Clave=Clave) Then
					Encontrado:=True
        Else
          begin
            PosPadre:=Pos;
					  If(RegAux.Clave<Clave) Then
						  Pos:=RegAux.hijoDerecho
            Else
						  Pos:=RegAux.hijoIzquierdo;
          end;

			End;
	Buscar:=Encontrado;
	If (Not(Encontrado)) Then
		Pos:=PosPadre;
End;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



Procedure Insertar(var Me: tipoArticulos;Reg:registroIndice; regDat:registroDatos; Pos:tipoposicion; esArbolUno:boolean; var posEnDatos:tipoposicion);  //ok
Var
  Aux,RegPadre:registroIndice;
  Rc:registroControl;
  PosNueva, posBorrado:tipoposicion;
  regAnt: registroDatos;
Begin

  if(esArbolUno)then
    begin
      //Inserto en la lista segun la posicion parametrizada
      seek(me.C,0);
      read(me.C,rc);
      //le coloco el id al articulo
      rc.ultimoId:=rc.ultimoId+1;
      regDat.clave:=inttostr(rc.ultimoId);
    
      if rc.borradosVentas <> _PosNula then   //Uso la lista de borrados
      begin
        seek(me.D,rc.borradosVentas);
        read(me.D,regAnt);
        posnueva:= rc.borradosVentas;
        rc.borradosVentas:= regAnt.Siguiente;
      end
      else
        posnueva:= filesize(me.D);           //No hay registros borrados tengo que inserrtar al final del archivo

      posEnDatos:=posnueva;

      //Gravo el registro parametrizado y el reg de control con los enlaces actualizados
      seek(me.D,posnueva);
      write(me.D,regDat);
      seek(me.C,0);
      write(me.C,rc);

    end; // es arbol Vendedor

  reg.posicion:=posEnDatos; //guardo la pos en datos que me devuelve el metodo

	Seek(Me.C,0);
	Read(Me.C,Rc);
	If(getBorrados(Me,esArbolUno)=_PosNula) Then  //No hay borrados
		if(esArbolUno)then
			PosNueva:=FileSize(me.i1)
		else
			PosNueva:=FileSize(me.i2)
	Else
    begin
      PosNueva:=getBorrados(me,esArbolUno);
	    leerIndice(me,posNueva,Aux,esArbolUno);//estaba didigendome a borrados
      setBorrados(me,Aux.hijoDerecho,esArbolUno);
    end;

  If (getRaiz(me,esArbolUno)=_PosNula) Then //Inserto En ÃƒÂ¡rbol vacio
    Begin
		  Reg.Padre:= _PosNula;
      Reg.hijoIzquierdo:=  _PosNula;
      Reg.hijoDerecho:=  _PosNula;
      Reg.nivel := 1;
		  setRaiz(me,PosNueva,esArbolUno);
    end
		//Grabamos al final
	Else  //Inserto como hoja
    begin
      leerIndice(me,pos,regPadre,esArbolUno);

      Reg.Padre:=Pos;
      Reg.hijoIzquierdo:=  _PosNula;
      Reg.hijoDerecho:=  _PosNula;
      Reg.nivel := regPadre.nivel + 1;

		  If(RegPadre.Clave>Reg.Clave) Then
			  RegPadre.hijoIzquierdo:=PosNueva
		  Else
        begin
			    RegPadre.hijoDerecho:=PosNueva;
	      End;

	  grabarIndice(me,pos,regPadre,esArbolUno);
    end;

  grabarIndice(me,posNueva,reg,esArbolUno);

  BalancearArbol(me, esArbolUno);

end;



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure Eliminar(var Me:tipoArticulos; Pos:tipoposicion; esArbolUno:boolean);
   var
    regAelim,regpadre,reghIzq,reghDer, regPadreNuevo: registroIndice;
    rc: registroControl;
    posPadre,posHizq,posHder, posPadreNuevo, posAcomodo: tipoposicion;
    corte:boolean;
    regDatos: registroDatos;
 begin

  seek(me.C,0);
  read(me.c,rc);

  //Capturo el registro a eliminar (trabajo con multiples indices)
  leerIndice(me,pos,regAelim,esArbolUno);

   if(esArbolUno)then //elimino en datos
    begin
      seek(me.C,0);
      read(me.C,rc);
      seek(me.D,regAelim.posicion);
      read(me.D,regDatos);

      regDatos.Siguiente:= rc.borradosVentas;   // Cadena
      rc.borradosVentas:=regAelim.posicion;

      seek(me.D,regAelim.posicion);
      write(me.D,regDatos);

      seek(me.C,0);
      write(me.C,rc);
    end;
  
  //incializo las variables
  posAcomodo:= _PosNula;
  pospadre:= regaelim.Padre;
  posHizq   := regaelim.hijoIzquierdo;
  posHder   := regaelim.hijoDerecho;

  if (pospadre = _PosNula) then
  //no tiene padre
  begin
   if (posHizq = _PosNula) and (posHder = _PosNula) then
   // no tiene padre ,no tiene hijos
    begin
     setRaiz(me,_PosNula,esArbolUno);
    end
     else
     //no tiene padre, tiene hijos
     begin
      if (posHizq <> _PosNula) and (posHder = _PosNula) then
      //no tiene padre, tiene hijo izquierdo, no tiene hijo derecho.
      begin
       //nueva raÃƒÂ­z
	   setRaiz(me,posHizq,esArbolUno);
       posAcomodo := posHizq;

       //Capturo el hijo izquierdo
	   leerIndice(me,posHizq,reghizq,esArbolUno);

       reghizq.Padre:=_PosNula;
       reghizq.Nivel:=1;
       //Grabo
	   grabarIndice(me,posHizq,reghizq,esArbolUno);
      end
       else
       if (posHizq = _PosNula) and (posHder <> _PosNula) then
       //no tiene padre, tiene hijo derecho, no tiene hijo izquierdo.
        begin
         //nueva raÃƒÂ­z
		 setRaiz(me,posHder,esArbolUno);
      
         posAcomodo:=posHder;
         //Capturo el hijo derecho
		 leerIndice(me,posHder,reghDer,esArbolUno);

         reghDer.Padre:=_PosNula;
         //Grabo
		 grabarIndice(me,posHder,reghDer,esArbolUno);
        end
         else
         //no tiene padre, tiene hijos, tiene ambos hijos.
         if (posHizq <> _PosNula) and (posHder <> _PosNula) then
          begin
          //enganche del nodo hijo izq a la izquierda del ÃƒÂºltimo nodo hijo der el hijo derecho pasa a ser el "nuevo padre"
		  leerIndice(me,posHizq,reghizq,esArbolUno);

		  leerIndice(me,posHder,reghDer,esArbolUno);

           posPadreNuevo:= posHder;
           corte:=false;
           while (posPadreNuevo <> _PosNula) and not (corte) do
           begin
			 leerIndice(me,posPadrenuevo,regPadreNuevo,esArbolUno);

            if regPadreNuevo.hijoIzquierdo <> _PosNula then
             posPadreNuevo:= regPadreNuevo.hijoIzquierdo
             else
              corte:=true;

           end; //end while

           //Capturo el nuevo padre para el nodo que quedo desvÃƒÂ­nculado
		   leerIndice(me,posPadreNuevo,regPadreNuevo,esArbolUno);

           regPadreNuevo.hijoIzquierdo:= posHizq;

           if regPadreNuevo.Clave = reghDer.Clave then
            regPadreNuevo.Padre:= PosPadre
            else
             begin
              reghDer.padre:=_PosNula;
			  grabarIndice(me,posHder,reghDer,esArbolUno);
             end;

           reghizq.Padre:= posPadreNuevo;
		   grabarIndice(me,posPadreNuevo,regPadreNuevo,esArbolUno);

		   grabarIndice(me,posHizq,reghizq,esArbolUno);

			setRaiz(me,posHder,esArbolUno);

           posAcomodo:=posHder;

          end 

     end // end no tiene padre, tiene hijos.
  end //end no tiene padre
   else

   begin
    if (posHizq = _PosNula) and (posHder = _PosNula) then
    //no tiene hijos
     begin
	 leerIndice(me,pospadre,regpadre,esArbolUno);

      if regpadre.hijoIzquierdo = pos then
       regpadre.hijoIzquierdo:= _PosNula
       else
        if regpadre.hijoDerecho = pos then
         regpadre.hijoDerecho:= _PosNula;
     end
      else
      //tiene hijos
       begin
        if (posHizq <> _PosNula) and (posHder = _PosNula) then
        //tiene padre, tiene solo hijo izq
         begin
		  leerIndice(me,posHizq,reghizq,esArbolUno);

		  leerIndice(me,pospadre,regPadre,esArbolUno);

          if reghizq.Padre = regPadre.hijoIzquierdo  then
           regPadre.hijoIzquierdo:= posHizq
           else
            if reghizq.Padre = regPadre.hijoDerecho then
             regPadre.hijoDerecho:= posHizq;

          posAcomodo:= pospadre;
          reghizq.Padre:= pospadre;

         end
          else
           if (posHizq = _PosNula) and (posHder <> _PosNula) then
           //tiene padre, tiene solo hijo derecho
           begin
			leerIndice(me,posHder,reghDer,esArbolUno);
          
			leerIndice(me,pospadre,regPadre,esArbolUno);

            if reghDer.Padre = regPadre.hijoIzquierdo  then
             regPadre.hijoIzquierdo:= posHder
             else
              if reghDer.Padre = regPadre.hijoDerecho then
               regPadre.hijoDerecho:= posHder;

            posAcomodo:= pospadre;
            reghDer.Padre:= pospadre;
           end //end tiene padre, solo hijo derecho
            else
            if (posHizq <> _PosNula) and (posHder <> _PosNula) then
            //tiene padre, no tiene hijo medio, tiene hijo izq y der
             begin
              //engancho el hijo izq al extremo izq del hijo der

			  leerIndice(me,posHizq,reghizq,esArbolUno);
     
			  leerIndice(me,posHder,reghDer,esArbolUno);
              posPadreNuevo:= posHder;
              corte:=false;

              while (posPadreNuevo <> _PosNula) and not (corte) do
               begin
        
				leerIndice(me,posPadrenuevo,regPadreNuevo,esArbolUno);

                if regPadreNuevo.hijoIzquierdo <> _PosNula then
                 posPadreNuevo:= regPadreNuevo.hijoIzquierdo
                 else
                  corte:=true;

               end; //end while
			  leerIndice(me,posPadreNuevo,regPadreNuevo,esArbolUno);
              
              regPadreNuevo.hijoIzquierdo:= posHizq;
              reghizq.Padre:= posPadreNuevo;

			grabarIndice(me,posPadreNuevo,regPadreNuevo,esArbolUno);
			
			grabarIndice(me,posHizq,reghizq,esArbolUno);
              
			  leerIndice(me,pospadre,regPadre,esArbolUno);

              if reghDer.Clave = regpadrenuevo.Clave then
               reghDer:= regpadrenuevo;

              if reghDer.Padre = regpadre.hijoIzquierdo then
               regpadre.hijoIzquierdo:= posHder
               else
                regpadre.hijoDerecho:= posHder;

              reghDer.Padre:= pospadre;

              posAcomodo:=pospadrenuevo;

			  grabarIndice(me,posHder,reghDer,esArbolUno);
     
             end
              else
              //no tiene hijos
               begin
             
				leerIndice(me,pospadre,regPadre,esArbolUno);
                if pos = regpadre.hijoIzquierdo then
                 regpadre.hijoIzquierdo:= _PosNula
                 else
                  regpadre.hijoDerecho:= _PosNula;
				grabarIndice(me,pospadre,regpadre,esArbolUno);

               end;
       end; //end tiene padre, no tiene hijo medio

	grabarIndice(me,pospadre,regpadre,esArbolUno);
   end; //end tiene padre

  //Anulo los valores del nodo a eliminar
  regAelim.Padre:=_PosNula;
  regAelim.hijoIzquierdo:=_PosNula;
  regAelim.hijoDerecho:= getBorrados(me,esArbolUno);
  //Grabo
  grabarIndice(me,pos,regAelim,esArbolUno);
  //Agrego a la pila de borrados
  setBorrados(me,pos,esArbolUno);

  //rc.Cantidad := rc.Cantidad -1; //////////////////////////////////////////////////cantidad

  //Se acomodan los niveles de los nodos, debido a los reenganches en distintos
  // niveles quedan desacomodados.
  if posAcomodo <> _PosNula then
   AcomodarNiveles(me,posAcomodo,esArbolUno);

  //Grabo la cabecera de control
{ 
 seek(me.C,0);
 write(me.C,rc);
}
 end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Procedure Capturar(var Me: tipoArticulos;  Pos:tipoposicion; var reg:registroIndice; esArbolUno:boolean);
begin
    leerIndice(me,pos,reg,esArbolUno);   //aca leo el reg
//    TDA_listaSimple.CapturarInfo(me,reg.posicion,regDat);
end;

Procedure capturarDatos(var Me: tipoArticulos; Pos:tipoposicion; var regDatos:registroDatos);
begin
  seek(me.D,pos);
  read(me.d,regDatos);
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



Procedure Modificar(var Me: tipoArticulos; pos:tipoposicion; reg:registroDatos);    //pk
begin
  seek(me.d,pos);
  write(me.d,reg);
 { leerIndice(me,pos,regaux,esArbolUno);
  Reg.Padre:=RegAux.Padre;
  Reg.hijoIzquierdo:=RegAux.hijoIzquierdo;
  Reg.hijoDerecho:=RegAux.hijoDerecho;
  grabarIndice(me,pos,reg,esArbolUno);  }
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



Function vacio(var Me: tipoArticulos; esArbolUno:boolean):Boolean;           
var
  Rc:registroControl;
begin
  Seek(Me.C,0);
  Read(Me.c, Rc);

   vacio:=  (getRaiz(me,esArbolUno) = _PosNula) ;
end;

Function UltimoID(var me: tipoArticulos): integer;
var
  Rc:registroControl;
begin
  seek(me.C, 0);
  read(me.C, rc);

  UltimoID:= rc.ultimoId+1;
end;


Function Padre(var Me: tipoArticulos; var Reg: registroIndice): tipoposicion; //ok
  begin
   Padre:= Reg.padre;
  end;



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function hijoDerecho(var Me: tipoArticulos; pos: tipoposicion; esArbolUno:boolean): tipoposicion;  //ok
var
reg: registroIndice;
begin
  leerIndice(me,pos,reg,esArbolUno);

  hijoDerecho:= reg.hijoDerecho;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function hijoIzquierdo(var Me: tipoArticulos; pos: tipoposicion; esArbolUno:boolean): tipoposicion; //ok
var
reg: registroIndice;
begin
  leerIndice(me,pos,reg,esArbolUno);

  hijoIzquierdo:= reg.hijoIzquierdo;

end;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function PosNula(Var Me:tipoArticulos):tipoposicion;   //ok
begin
  PosNula:= _PosNula;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



Function ClaveNodo(var Me: tipoArticulos; reg: registroIndice):string;  //ok
begin
  ClaveNodo:=reg.Clave
end;


/////////////////////////Balanceo//////////////////////////////////////////////////

procedure ProfundidadDelArbol(var me:tipoArticulos; Raiz:tipoposicion;
  var Profundidad:tipoPOsicion; esArbolUno:boolean);

var
 Nodo: registroIndice;
 isNull: registroDatos;

 begin
   If Raiz <> _PosNula then
    begin
    // Primero recursivo tendiendo a la Izquierda
    ProfundidadDelArbol(me, hijoIzquierdo(me, raiz, esArbolUno), Profundidad, esArbolUno);
    // Recursividad tendiendo a la Derecha.
    ProfundidadDelArbol(me, hijoDerecho(me, raiz, esArbolUno), Profundidad, esArbolUno);

    // Guardo en Nodo el nodo indice.

    Capturar(me, raiz, nodo, esArbolUno);

    If Nodo.nivel > Profundidad then
      Profundidad := Nodo.nivel;
    end;
 end;

Function ProfundidadDelNodo(me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean): integer;
var
 Profundidad:tipoPosicion;
 Nodo:registroIndice;
 isNull:registroDatos;
Begin
  {Dada una posiciÃƒÂ³n, devuelve la profundidad (nivel) en el que se encuentra}
  Profundidad := 0;
  Capturar(me, raiz, nodo, esArbolUno);
  //Capturar(me, nodo, isNull, raiz, esArbolUno);
  ProfundidadDelArbol(me, raiz, Profundidad, esArbolUno);
  result := (Profundidad - nodo.nivel) + 1;
End;

{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{PROCEDIMIENTOS PARA DISMINUIR O AUMENTAR EL NIVEL DE UN tipoArticulos O
  SUBtipoArticulos ESPECIFICO}

Procedure DisminuirNiveles(var me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean);
var
  Nodo: registroIndice;
  isNull: registroDatos;
begin
  If raiz <> _PosNula then
  begin
  // Primero recursivo hacia la Izquierda
  DisminuirNiveles(me, hijoIzquierdo(me, raiz, esArbolUno), esArbolUno);
  Capturar(me, raiz, nodo, esArbolUno);
 // Capturar(me, nodo, isNull, raiz, esArbolUno);
  Nodo.nivel := Nodo.nivel - 1;
  grabarIndice(me,raiz,Nodo,esArbolUno);
  // Recursividad hacia la Derecha
  DisminuirNiveles(me, hijoDerecho(me, raiz, esArbolUno), esArbolUno);
  end;
end;

Procedure AumentarNiveles(var me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean);
var
  Nodo: registroIndice;isNull:registroDatos;
begin
  If raiz <> _PosNula then
   begin
    // Primero recursivo hacia la Izquierda
    AumentarNiveles(me, hijoIzquierdo(me, raiz, esArbolUno), esArbolUno);
  //  Capturar(me, nodo, isNull, raiz, esArbolUno);
    Capturar(me, raiz, nodo, esArbolUno);
    Nodo.nivel := Nodo.nivel + 1;
	grabarIndice(me,raiz,Nodo,esArbolUno);
    // Recursividad hacia la Derecha.
    AumentarNiveles(me, hijoDerecho(me, raiz, esArbolUno), esArbolUno);
   end;
end;

Procedure AcomodarNiveles(var me: tipoArticulos; raiz: tipoposicion; esArbolUno:boolean);
var
  Nodo,NodoPadre: registroIndice;isNull:registroDatos;
begin
  If raiz <> _PosNula then
  begin
  {Procedimiento que acomoda los niveles de los nodos en el ÃƒÂ¡rbol}
  //Capturar(me, nodo, isNull, raiz, esArbolUno);
  Capturar(me, raiz, nodo, esArbolUno);

  if Nodo.Padre <> _PosNula then
   begin
    //Capturar(me,NodoPadre,isNull, Nodo.Padre, esArbolUno);
    Capturar(me, raiz, nodo, esArbolUno);
    Nodo.nivel := NodoPadre.Nivel + 1;
   end
    else //no tiene padre, es la raiz.
     Nodo.Nivel:=1;

   grabarIndice(me,raiz,Nodo,esArbolUno);

  // Primero recursivo hacia la Izquierda
  AcomodarNiveles(me, hijoIzquierdo(me, raiz, esArbolUno), esArbolUno);

  // Recursividad hacia la Derecha.
  AcomodarNiveles(me, hijoDerecho(me, raiz, esArbolUno), esArbolUno);

  end;
end;

{ *****************************************************************************}
{PROCEDIMIENTOS DE ROTACIONES PARA LOGRAR EL EQUILIBRIO DEL tipoArticulos AVL}

Procedure DerechaDerecha(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);
Var
  NodoArriba, NodoAbajo, NodoAnterior: registroIndice;
  RC: registroControl;
  posAux: tipoposicion;
begin

  leerIndice(me,PosNodo,NodoArriba,esArbolUno);
  leerIndice(me,NodoArriba.hijoDerecho,NodoAbajo,esArbolUno);
  seek(me.C, 0);
  Read(me.C, RC);

  { Cambio enlaces }
  posAux := NodoAbajo.hijoIzquierdo;
  NodoAbajo.padre := NodoArriba.padre;
  NodoAbajo.hijoIzquierdo := PosNodo;
  NodoArriba.padre := NodoArriba.hijoDerecho;
  NodoArriba.hijoDerecho := posAux;

  If NodoAbajo.padre <> _PosNula then
  begin
	 leerIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);
    If NodoAnterior.hijoDerecho = PosNodo then
      NodoAnterior.hijoDerecho := NodoArriba.padre
    Else
      NodoAnterior.hijoIzquierdo := NodoArriba.padre;
	grabarIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);
  end;

  { Cambio niveles }
  NodoAbajo.nivel := NodoAbajo.nivel - 1;
  NodoArriba.nivel := NodoArriba.nivel + 1;

  { Verifico que no haya sido la raiz }
  If PosNodo = getRaiz(me,esArbolUno) then
    setRaiz(me,NodoArriba.padre,esArbolUno);

  grabarIndice(me,PosNodo,NodoArriba,esArbolUno);
  
  grabarIndice(me,NodoArriba.padre,NodoAbajo,esArbolUno);

 { 
  seek(me.C, 0);
  Write(me.C, RC);
}
  DisminuirNiveles(me, NodoAbajo.hijoDerecho, esArbolUno);
  AumentarNiveles(me, NodoArriba.hijoIzquierdo, esArbolUno);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////


Procedure IzquierdaIzquierda(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);
Var
  NodoArriba, NodoAbajo, NodoAnterior: registroIndice;
  RC: registroControl;
  posAux: tipoposicion;
begin

  leerIndice(me,PosNodo,NodoArriba,esArbolUno);

  leerIndice(me,NodoArriba.hijoIzquierdo,NodoAbajo,esArbolUno);
  
  seek(me.C, 0);
  Read(me.C, RC);

  { Cambio enlaces }
  posAux := NodoAbajo.hijoDerecho;
  NodoAbajo.padre := NodoArriba.padre;
  NodoAbajo.hijoDerecho := PosNodo;
  NodoArriba.padre := NodoArriba.hijoIzquierdo;
  NodoArriba.hijoIzquierdo := posAux;;

  If NodoAbajo.padre <> _PosNula then
  begin
	leerIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);

    If NodoAnterior.hijoDerecho = PosNodo then
      NodoAnterior.hijoDerecho := NodoArriba.padre
    Else
      NodoAnterior.hijoIzquierdo := NodoArriba.padre;

	grabarIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);
  end;

  { Cambio niveles }
  NodoAbajo.nivel := NodoAbajo.nivel - 1;
  NodoArriba.nivel := NodoArriba.nivel + 1;

  { Verifico que no haya sido la raiz }
  If PosNodo = getRaiz(me,esArbolUno) then
    setRaiz(me, NodoArriba.padre,esArbolUno);

  grabarIndice(me,PosNodo,NodoArriba,esArbolUno);

  grabarIndice(me,NodoArriba.padre,NodoAbajo,esArbolUno);
  {
  seek(me.C, 0);
  Write(me.C, RC);
}
  DisminuirNiveles(me, NodoAbajo.hijoIzquierdo, esArbolUno);
  AumentarNiveles(me, NodoArriba.hijoDerecho, esArbolUno);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////


Procedure IzquierdaDerecha(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);
Var
  NodoArriba, NodoMedio, NodoAbajo, NodoAnterior: registroIndice;
  RC: registroControl;
  posAux, PosMedio, PosAbajo: tipoposicion;
begin
{..0..  ARRIBA
 0....  MEDIO
 .0...  ABAJO}

  leerIndice(me,PosNodo,NodoArriba,esArbolUno);

  leerIndice(me,NodoArriba.hijoIzquierdo,NodoMedio,esArbolUno);

  leerIndice(me,NodoMedio.hijoDerecho,NodoAbajo,esArbolUno);
  seek(me.C, 0);
  Read(me.C, RC);

  PosMedio := NodoArriba.hijoIzquierdo;
  PosAbajo := NodoMedio.hijoDerecho;
  posAux := NodoArriba.padre;
  { Cambio enlaces }
  NodoArriba.padre := NodoMedio.hijoDerecho;
  NodoArriba.hijoIzquierdo := NodoAbajo.hijoDerecho;

  NodoMedio.padre := NodoMedio.hijoDerecho;
  NodoMedio.hijoDerecho := NodoAbajo.hijoIzquierdo;

  NodoAbajo.padre := posAux;
  NodoAbajo.hijoDerecho := PosNodo;
  NodoAbajo.hijoIzquierdo := PosMedio;
  {..0..  ABAJO
   0...0  MEDIO - ARRIBA}


  If NodoAbajo.padre <> _PosNula then
  begin
	leerIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);
    If NodoAnterior.hijoDerecho = PosNodo then
      NodoAnterior.hijoDerecho := PosAbajo
    Else
      NodoAnterior.hijoIzquierdo := PosAbajo;
	grabarIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);
  end;

  { Cambio niveles }
  NodoAbajo.nivel := NodoAbajo.nivel - 2;
  NodoArriba.nivel := NodoArriba.nivel + 1;

  { Verifico que no haya sido la raiz }
  If PosNodo = getRaiz(me,esArbolUno) then
setRaiz(me, NodoArriba.padre,esArbolUno);

  grabarIndice(me,PosNodo,NodoArriba,esArbolUno);

  grabarIndice(me,PosMedio,NodoMedio,esArbolUno);
 
  grabarIndice(me,PosAbajo,NodoAbajo,esArbolUno);
  {
  seek(me.C, 0);
  Write(me.C, RC);
}
  DisminuirNiveles(me, NodoArriba.hijoIzquierdo, esArbolUno);
  AumentarNiveles(me, NodoArriba.hijoDerecho, esArbolUno);
  DisminuirNiveles(me, NodoMedio.hijoDerecho, esArbolUno);

end;

{ **************************************************************************** }
Procedure DerechaIzquierda(var me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);
Var
  NodoArriba, NodoMedio, NodoAbajo, NodoAnterior: registroIndice;
  RC: registroControl;
  posAux, PosMedio, PosAbajo: tipoposicion;
begin
  {..0..  ARRIBA
   ....0  MEDIO
   ...0.  ABAJO}

  leerIndice(me,PosNodo,NodoArriba,esArbolUno);

  leerIndice(me, NodoArriba.hijoDerecho,NodoMedio,esArbolUno);

  leerIndice(me, NodoMedio.hijoIzquierdo,NodoAbajo,esArbolUno);
  seek(me.C, 0);
  Read(me.C, RC);

  PosMedio := NodoArriba.hijoDerecho;
  PosAbajo := NodoMedio.hijoIzquierdo;
  posAux := NodoArriba.padre;
  { Cambio enlaces }
  NodoArriba.padre := NodoMedio.hijoIzquierdo;
  NodoArriba.hijoDerecho := NodoAbajo.hijoIzquierdo;

  NodoMedio.padre := NodoMedio.hijoIzquierdo;
  NodoMedio.hijoIzquierdo := NodoAbajo.hijoDerecho;

  NodoAbajo.padre := posAux;
  NodoAbajo.hijoIzquierdo := PosNodo;
  NodoAbajo.hijoDerecho := PosMedio;
  {..0..  ABAJO
   0...0  ARRIBA - MEDIO}

  If NodoAbajo.padre <> _PosNula then
  begin
 
	leerIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);
    If NodoAnterior.hijoDerecho = PosNodo then
      NodoAnterior.hijoDerecho := PosAbajo
    Else
      NodoAnterior.hijoIzquierdo := PosAbajo;

	grabarIndice(me,NodoAbajo.padre,NodoAnterior,esArbolUno);
  end;

  { Cambio el campo nivel }
  NodoAbajo.nivel := NodoAbajo.nivel - 2;
  NodoArriba.nivel := NodoArriba.nivel + 1;

  { Verifico que el problema no haya sido la raiz }
  If PosNodo = getRaiz(me,esArbolUno) then
   setRaiz(me,NodoArriba.padre,esArbolUno);

  grabarIndice(me,PosNodo,NodoArriba,esArbolUno);

  grabarIndice(me,PosMedio,NodoMedio,esArbolUno);

  grabarIndice(me,PosAbajo,NodoAbajo,esArbolUno);
  {
  seek(me.C, 0);
  Write(me.C, RC);
}
  DisminuirNiveles(me, NodoArriba.hijoDerecho, esArbolUno);
  AumentarNiveles(me, NodoArriba.hijoIzquierdo, esArbolUno);
  DisminuirNiveles(me, NodoMedio.hijoIzquierdo, esArbolUno);

end;

////////////////////////////////////////////////////////////////////////////////////////////////////


Function FactorEquilibrio(me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean): integer;
var
  Nodo: registroIndice;isNull:registroDatos;
  Ti, Td: integer;
begin
  If PosNodo = _PosNula then
    FactorEquilibrio := 0
  Else
  begin
    // Guardo en Nodo el nodo indice.
   //Capturar(me, Nodo, isNull, PosNodo, esArbolUno);
   Capturar(me, PosNodo, nodo, esArbolUno);

    // Calculo la profundidad de ambos hijos.
    If Nodo.hijoIzquierdo <> _PosNula then
      Ti := ProfundidadDelNodo(me, Nodo.hijoIzquierdo, esArbolUno)
    Else
      Ti := 0;
    If Nodo.hijoDerecho <> _PosNula then
      Td := ProfundidadDelNodo(me, Nodo.hijoDerecho, esArbolUno)
    Else
      Td := 0;

    { -->AVL es cuando de todo nodo |Altura(Ti)-Altura(Td)|<=1.
      --->Ti y Td son los subtipoArticuloses de un nodo.
      --> Aca Ti y Td contienen la Altura de dicho subtipoArticulos. }
    FactorEquilibrio := Ti - Td;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////


Procedure CasoDeDesequilibrio(me: tipoArticulos; PosNodo: tipoposicion; esArbolUno:boolean);
var
  Nodo: registroIndice;isNull:registroDatos;
  begin

    //Capturar(me, Nodo, isNull, PosNodo, esArbolUno);
     Capturar(me, PosNodo, nodo, esArbolUno);

    If FactorEquilibrio(me, PosNodo, esArbolUno) >= 0 then
    begin
      If FactorEquilibrio(me, Nodo.hijoIzquierdo, esArbolUno) >= 0 then
        IzquierdaIzquierda(me, PosNodo, esArbolUno)
      Else
        IzquierdaDerecha(me, PosNodo, esArbolUno);
    end
    else
     begin
      If FactorEquilibrio(me, Nodo.hijoDerecho, esArbolUno) >= 0 then
       DerechaIzquierda(me, PosNodo, esArbolUno)
        else
         DerechaDerecha(me, PosNodo, esArbolUno);
     end;
  end;

  ////////////////////////////////////////////////////////////////////////////////////////////////////


Procedure Indice(me: tipoArticulos; raiz: tipoposicion; var PosNodo: tipoposicion;
  Var Balance: boolean; esArbolUno: boolean);
{ Verifica si el me esta balanceado. Si no lo esta devuelve la posiciÃƒÂ³n del nodo
  que general el desequilibrio.}
var
  Result: integer;
  begin
    // Si lo que entra es posNula sale.
    If (raiz <> _PosNula) then
    begin
     // Recursivo hacia la Izquierda
    Indice(me, hijoIzquierdo(me, raiz, esArbolUno), PosNodo, Balance, esArbolUno);
    // Recursivo hacia la derecha
    Indice(me, hijoDerecho(me, raiz, esArbolUno), PosNodo, Balance, esArbolUno);

    Result := FactorEquilibrio(me, raiz, esArbolUno);

      If Result < 0 then
        Result := Result * (-1);

      { Cuando conoce la posicion del nodo en desequilibrio no lo cambia }
      If (Result > 1) then
        Balance := false;

      If (PosNodo = _PosNula) and (not Balance) then
        PosNodo := raiz;
      end;
  end;

  ////////////////////////////////////////////////////////////////////////////////////////////////////


procedure BalancearArbol(var me: tipoArticulos; esArbolUno:boolean);
var
  balanceado: boolean;
  pos: tipoposicion;
  Nodo: registroIndice;
  isNull: registroDatos;
  begin
    balanceado := true;
    pos := _PosNula;
    //Invoca al procedimiento que devuelve "false" si el tipoArticulos esta desbalanceado
    Indice(me, getRaiz(me,esArbolUno), pos, balanceado, esArbolUno);

    if not balanceado then
    begin

      While (not balanceado) do
       begin
        balanceado := true;
        pos := _PosNula;

        Indice(me, getRaiz(me,esArbolUno), pos, balanceado, esArbolUno);
        If (not balanceado) then
        begin
          //Capturar(me, Nodo, isNull, pos, esArbolUno);
           Capturar(me, pos, nodo, esArbolUno);
          CasoDeDesequilibrio(me, pos, esArbolUno);
        end;

       end; //end while
    end;//end if

  end;


end.
